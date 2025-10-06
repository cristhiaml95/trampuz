import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

DateTime? parsePostgresTimestamp(String timestamp) {
  List<DateFormat> formats = [
    DateFormat(
        "yyyy-MM-dd HH:mm:ss.SSSSSSz"), // timestamptz with microseconds and timezone
    DateFormat("yyyy-MM-dd HH:mm:ssz"), // timestamptz
    DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS"), // timestamp with microseconds
    DateFormat("yyyy-MM-dd HH:mm:ss"), // timestamp
    DateFormat("HH:mm:ss.SSSSSSz"), // timetz with microseconds
    DateFormat("HH:mm:ssz"), // timetz
    DateFormat("HH:mm:ss.SSSSSS"), // time with microseconds
    DateFormat("HH:mm:ss"), // time
    DateFormat("yyyy-MM-dd"), // date
  ];

  for (var format in formats) {
    try {
      return format.parse(timestamp, true);
    } catch (e) {
      // Continuar probando con otros formatos
    }
  }

  // Si ninguno de los formatos coincide, imprimir advertencia y retornar null
  print('Could not parse the date/time: $timestamp');
  return null;
}

List<String> splitBarcodes(String barcodesGroup) {
  // Primero se eliminan los '/' del string
  var tempString = barcodesGroup.trim().replaceAll('/', '');

  // Se dividen los elementos por espacios y saltos de línea
  var splitList = tempString.split(RegExp(r'\s+|\n+'));

  // Filtrar la lista para eliminar cualquier elemento vacío
  splitList = splitList.where((s) => s.isNotEmpty).toList();

  // Verificar si la lista está vacía después de filtrar
  if (splitList.isEmpty) {
    return [];
  }

  return splitList;
}

String joinStrings(List<String> strings) {
  var filteredStrings = strings.where((string) => string != '/').toList();

  return filteredStrings.join(' ');
}

List<String> noRepeated(List<String> duplicatedList) {
  return duplicatedList.toSet().toList();
}

DateTime stringToDateTime(String timeString) {
  DateTime now = DateTime.now();

  // Dividir el string 'HH:mm' para obtener las horas y minutos
  List<String> parts = timeString.split(':');
  if (parts.length != 2) {
    throw FormatException("El string debe estar en formato HH:mm");
  }

  // Convertir las partes en enteros
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Crear un nuevo objeto DateTime con la fecha actual y la hora especificada
  return DateTime(now.year, now.month, now.day, hour, minute);
}

String urlName(String url) {
// Dividimos el enlace (URL) en una lista de subcadenas utilizando '/' como delimitador.
  List<String> partes = url.split('/');

  // Verificamos si el último elemento es vacío debido a un '/' al final del URL.
  // Si es así, retornamos el penúltimo elemento.
  if (partes.isNotEmpty && partes.last.isEmpty) {
    return partes[partes.length - 2];
  }

  // Retornamos el último elemento de la lista, que es la parte después del último '/'.
  return partes.last;
}

List<dynamic>? stringToJson(String? jsonString) {
  if (jsonString == null) {
    return null;
  }

  final trimmed = jsonString.trim();
  if (trimmed.isEmpty) {
    return null;
  }

  try {
    return json.decode(trimmed) as List<dynamic>;
  } catch (e) {
    // You might want to handle errors differently in production
    print('Error parsing JSON: $e');
    return null;
  }
}

double? reduceDouble(double? value) {
  if (value == null) return null;

  // 1. Redondeamos a 3 decimales.
  final rounded = double.parse(value.toStringAsFixed(3));

  // 2. Devolvemos el número ya reducido (mantiene tipo double).
  return rounded;
}

List<dynamic>? joinJsons(
  dynamic inOrder,
  List<dynamic>? outOrders,
) {
  Map<String, dynamic>? _toMap(dynamic v) {
    try {
      if (v == null) return null;
      if (v is Map<String, dynamic>) return v;
      if (v is Map) return Map<String, dynamic>.from(v);
      if (v is String && v.trim().isNotEmpty) {
        final decoded = jsonDecode(v);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return null;
  }

  Iterable<Map<String, dynamic>> _toMapList(dynamic v) sync* {
    try {
      if (v == null) return;
      if (v is List) {
        for (final e in v) {
          final m = _toMap(e);
          if (m != null) yield m;
        }
        return;
      }
      if (v is String && v.trim().isNotEmpty) {
        final decoded = jsonDecode(v);
        if (decoded is List) {
          for (final e in decoded) {
            final m = _toMap(e);
            if (m != null) yield m;
          }
          return;
        }
        final m = _toMap(decoded);
        if (m != null) yield m;
        return;
      }
      final m = _toMap(v);
      if (m != null) yield m;
    } catch (_) {}
  }

  final List<dynamic> result = <dynamic>[];

  // inOrder primero
  final inMap = _toMap(inOrder);
  if (inMap != null) {
    result.add(inMap);
  }

  // Luego todos los outOrders (en el mismo orden)
  if (outOrders != null) {
    for (final item in outOrders) {
      result.addAll(_toMapList(item));
    }
  }

  return result;
}

String? dynamicToString(dynamic jsonPart) {
  return (jsonPart is String) ? jsonPart : null;
}

List<String>? getListFromJsonPath(
  List<dynamic>? jsonList,
  String? jsonPath,
) {
  // --- Helpers de parsing y evaluación JSONPath ---

  // ¿La ruta espera que el root sea un array? (ej. $[?...], $[*], $[0], etc.)
  bool _wantsArrayRoot(String path) {
    var p = path.trim();
    int i = 0;
    if (p.startsWith(r'$')) {
      i++;
      if (i < p.length && p[i] == '.') i++;
    }
    return i < p.length && p[i] == '[';
  }

  List<String> _tokenize(String path) {
    final p = path.trim();
    int i = 0;
    final tokens = <String>[];

    // Remover $ o $.
    if (p.startsWith(r'$.')) {
      i = 2;
    } else if (p.startsWith(r'$')) {
      i = 1;
    }

    while (i < p.length) {
      final ch = p[i];

      if (ch == '.') {
        i++;
        continue;
      }

      if (ch == '[') {
        i++; // saltar '['
        // Filtro ?(...)
        if (i < p.length && p[i] == '?') {
          int depth = 1;
          int start = i;
          while (i < p.length && depth > 0) {
            if (p[i] == '[') depth++;
            if (p[i] == ']') depth--;
            i++;
          }
          final raw = p.substring(start, i - 1);
          tokens.add(raw.trim()); // ej: ?(@.view=="orderWarehouse")
          continue;
        }

        // Clave entre comillas
        if (i < p.length && (p[i] == '\'' || p[i] == '"')) {
          final quote = p[i];
          i++;
          final start = i;
          while (i < p.length && p[i] != quote) i++;
          final key = p.substring(start, i);
          while (i < p.length && p[i] != ']') i++;
          if (i < p.length && p[i] == ']') i++;
          tokens.add(key);
          continue;
        }

        // Índice o contenido crudo
        final start = i;
        while (i < p.length && p[i] != ']') i++;
        final raw = p.substring(start, i).trim();
        if (i < p.length && p[i] == ']') i++;
        if (raw.isNotEmpty) tokens.add(raw);
        continue;
      }

      // token con notación punto
      final start = i;
      while (i < p.length && p[i] != '.' && p[i] != '[') i++;
      final token = p.substring(start, i).trim();
      if (token.isNotEmpty) tokens.add(token);
    }

    return tokens;
  }

  dynamic _getBySimplePath(dynamic node, String rel) {
    int i = 0;
    while (i < rel.length) {
      if (rel[i] == '.') {
        i++;
        final start = i;
        while (i < rel.length && rel[i] != '.' && rel[i] != '[') i++;
        final key = rel.substring(start, i);
        if (key.isEmpty) continue;
        if (node is Map && node.containsKey(key)) {
          node = node[key];
        } else {
          return null;
        }
        continue;
      }
      if (rel[i] == '[') {
        i++;
        if (i < rel.length && (rel[i] == '\'' || rel[i] == '"')) {
          final quote = rel[i];
          i++;
          final start = i;
          while (i < rel.length && rel[i] != quote) i++;
          final key = rel.substring(start, i);
          while (i < rel.length && rel[i] != ']') i++;
          if (i < rel.length && rel[i] == ']') i++;
          if (node is Map && node.containsKey(key)) {
            node = node[key];
          } else {
            return null;
          }
        } else {
          final start = i;
          while (i < rel.length && rel[i] != ']') i++;
          final raw = rel.substring(start, i).trim();
          if (i < rel.length && rel[i] == ']') i++;
          final idx = int.tryParse(raw);
          if (idx == null || node is! List || idx < 0 || idx >= node.length)
            return null;
          node = node[idx];
        }
        continue;
      }
      final start = i;
      while (i < rel.length && rel[i] != '.' && rel[i] != '[') i++;
      final key = rel.substring(start, i);
      if (key.isEmpty) continue;
      if (node is Map && node.containsKey(key)) {
        node = node[key];
      } else {
        return null;
      }
    }
    return node;
  }

  dynamic _parseLiteral(String raw) {
    final s = raw.trim();
    if ((s.startsWith('"') && s.endsWith('"')) ||
        (s.startsWith("'") && s.endsWith("'"))) {
      return s.substring(1, s.length - 1);
    }
    if (s == 'true') return true;
    if (s == 'false') return false;
    if (s == 'null') return null;
    final i = int.tryParse(s);
    if (i != null) return i;
    final d = double.tryParse(s);
    if (d != null) return d;
    return s;
  }

  bool _eq(dynamic a, dynamic b) {
    if (a == null || b == null) return a == b;
    if (a is num && b is num) return a == b;
    if (a is bool && b is bool) return a == b;
    return a.toString() == b.toString();
  }

  (String, String, String)? _splitByOp(String expr) {
    bool inStr = false;
    String? quote;
    for (int i = 0; i < expr.length - 1; i++) {
      final ch = expr[i];
      final nx = expr[i + 1];
      if (inStr) {
        if (ch == quote) {
          inStr = false;
          quote = null;
        }
        continue;
      }
      if (ch == '\'' || ch == '"') {
        inStr = true;
        quote = ch;
        continue;
      }
      if ((ch == '=' && nx == '=') || (ch == '!' && nx == '=')) {
        final lhs = expr.substring(0, i).trim();
        final op = expr.substring(i, i + 2);
        final rhs = expr.substring(i + 2).trim();
        return (lhs, op, rhs);
      }
    }
    return null;
  }

  List<dynamic> _applyToken(dynamic node, String token) {
    if (token.isEmpty || token == r'$') return [node];

    if (token == '*') {
      if (node is List) return List<dynamic>.from(node);
      if (node is Map) return List<dynamic>.from(node.values);
      return const [];
    }

    if (token.startsWith('?(') && token.endsWith(')')) {
      if (node is! List) return const [];
      final inner = token
          .substring(2, token.length - 1)
          .trim(); // ej: @.view=="orderWarehouse"
      final parts = _splitByOp(inner);
      if (parts == null) return const [];
      final (lhsRaw, op, rhsRaw) = parts;

      var lhs = lhsRaw.trim();
      if (!lhs.startsWith('@')) return const [];
      lhs = lhs.substring(1); // quitar '@' => ".view", "['k']"...

      final rhs = _parseLiteral(rhsRaw);

      final out = <dynamic>[];
      for (final el in node) {
        final val = _getBySimplePath(el, lhs);
        final isEq = _eq(val, rhs);
        if ((op == '==' && isEq) || (op == '!=' && !isEq)) {
          out.add(el);
        }
      }
      return out;
    }

    final idx = int.tryParse(token);
    if (idx != null) {
      if (node is List && idx >= 0 && idx < node.length) return [node[idx]];
      return const [];
    }

    if (node is Map && node.containsKey(token)) return [node[token]];

    return const [];
  }

  List<dynamic> _evaluate(dynamic root, List<String> tokens) {
    var current = <dynamic>[root];
    for (final t in tokens) {
      final next = <dynamic>[];
      for (final n in current) {
        next.addAll(_applyToken(n, t));
      }
      current = next;
      if (current.isEmpty) break;
    }
    return current;
  }

  String _toStringValue(dynamic v) {
    if (v == null) return 'null';
    if (v is String) return v;
    if (v is num || v is bool) return v.toString();
    try {
      return jsonEncode(v);
    } catch (_) {
      return v.toString();
    }
  }

  // --- Normalización de entrada y elección del root ---
  if (jsonList == null ||
      jsonList.isEmpty ||
      jsonPath == null ||
      jsonPath.trim().isEmpty) {
    return <String>[];
  }

  // Normaliza posibles strings JSON a estructuras
  final normalized = <dynamic>[];
  for (var it in jsonList) {
    if (it is String) {
      try {
        normalized.add(jsonDecode(it));
      } catch (_) {
        normalized.add(it);
      }
    } else {
      normalized.add(it);
    }
  }

  final tokens = _tokenize(jsonPath);

  // Si la ruta empieza con '[' tras el '$', se evalúa sobre el ARRAY completo.
  // Si solo hay un elemento y la ruta NO quiere array root, evalúa sobre ese objeto.
  dynamic root;
  final wantsArray = _wantsArrayRoot(jsonPath);
  if (normalized.length == 1 && !wantsArray) {
    root = normalized.first;
  } else {
    root = normalized;
  }

  final vals = _evaluate(root, tokens);

  final out = <String>[];
  for (final v in vals) {
    out.add(_toStringValue(v));
  }
  return out;
}
