// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// Devuelve los nombres de columnas detectadas como filtros dentro de `urlColumns`.
/// - Ignora params no-filtro como: order, limit, select, etc.
/// - Soporta grupos lógicos Supabase: `or=()` y `and=()`
/// - Mantiene el orden de aparición y evita duplicados.
/// - Sanea y decodifica con tolerancia `%` mal formateados.
Future<List<String>> getFilteredColumnNamesFromUrl(
  String? urlColumns,
) async {
  try {
    if (urlColumns == null || urlColumns.trim().isEmpty) return [];

    // Claves no relacionadas a filtros directos (se ignoran)
    const Set<String> ignoreKeys = {
      'order',
      'limit',
      'offset',
      'select',
      'page',
      'page_size',
      'pagesize',
      'range',
      'rangeunit',
      'head',
      'count',
      'format',
      'csv',
    };

    // Resultado único preservando orden
    final List<String> result = [];
    final Set<String> seenLower = {};

    void _add(String name) {
      final n = name.trim();
      if (n.isEmpty) return;
      final lower = n.toLowerCase();
      if (seenLower.contains(lower)) return;
      seenLower.add(lower);
      result.add(n);
    }

    // Reemplaza cualquier '%' que NO vaya seguido de 2 hex por '%25' (literal '%')
    String _sanitizeBadPercents(String s) {
      return s.replaceAllMapped(
        RegExp(r'%(?![0-9A-Fa-f]{2})'),
        (_) => '%25',
      );
    }

    // Decodifica tipo "query component" (convierte '+' a espacio) con saneamiento.
    String _safeDecodeQC(String s) {
      final sanitized = _sanitizeBadPercents(s);
      try {
        return Uri.decodeQueryComponent(sanitized);
      } catch (e) {
        // Si aún así falla, devuelve el original saneado y loguea
        print(
            '[getFilteredColumnNamesFromUrl] Decode error: $e | input="$s" | sanitized="$sanitized"');
        return sanitized;
      }
    }

    // Extrae nombres de columna de grupos lógicos: "(col.op.valor, col2.not.op.valor, ...)"
    void _parseLogicalGroup(String decodedValue) {
      try {
        // Coincide: <columna>.(not.)?<operador>.
        // Ej: custom_name.eq., order_no.ilike., inv_status.not.eq., item.in.(
        final regex = RegExp(
          r'([a-zA-Z0-9_]+)\.(?:not\.)?[a-zA-Z]+\.',
          caseSensitive: false,
        );
        for (final m in regex.allMatches(decodedValue)) {
          final colName = m.group(1);
          if (colName != null) _add(colName);
        }
      } catch (e) {
        print(
            '[getFilteredColumnNamesFromUrl] Logical group parse error: $e | value="$decodedValue"');
      }
    }

    // Partimos por pares & sin decodificar globalmente; decodificamos key/value por separado.
    for (final pair in urlColumns.split('&')) {
      final p = pair.trim();
      if (p.isEmpty) continue;

      final int eqIdx = p.indexOf('=');
      if (eqIdx <= 0) continue; // sin '=' o key vacío

      final rawKey = p.substring(0, eqIdx);
      final rawVal = p.substring(eqIdx + 1);

      final key = _safeDecodeQC(rawKey).trim();
      final value = _safeDecodeQC(rawVal);

      if (key.isEmpty) continue;

      final keyLower = key.toLowerCase();

      // Grupos lógicos: parsear columnas dentro del valor
      if (keyLower == 'or' || keyLower == 'and') {
        _parseLogicalGroup(value);
        continue;
      }

      // Ignorar claves de control
      if (ignoreKeys.contains(keyLower)) continue;

      // Filtro regular: <columna>=<operador.valor>
      _add(key);
    }

    return result;
  } catch (e) {
    print('[getFilteredColumnNamesFromUrl] Error: $e');
    return [];
  }
}
