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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
// ---------------------------------------------------------------------------
//                       B E G I N   C U S T O M   C O D E
// ---------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

// ▸ Web
import 'package:universal_html/html.dart' as html;

// ▸ Android / iOS / Desktop
import 'dart:io' show Directory, File, Platform;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

Future<void> getCsv3(
  List<dynamic>? data,
  List<dynamic>? viewConfigJson,
  List<dynamic>? columnDefsJson,
  String? viewName,
  double? exchangeRate,
) async {
  try {
    // ---------- Validaciones iniciales ----------
    if (data == null || data.isEmpty) {
      throw Exception('[getCsv3] "data" vacío o nulo.');
    }
    if (viewConfigJson == null || viewConfigJson.isEmpty) {
      throw Exception('[getCsv3] "viewConfigJson" vacío o nulo.');
    }
    if (columnDefsJson == null || columnDefsJson.isEmpty) {
      throw Exception('[getCsv3] "columnDefsJson" vacío o nulo.');
    }
    if (viewName == null || viewName.trim().isEmpty) {
      throw Exception('[getCsv3] Debe proporcionar "viewName".');
    }

    // ---------- 1. Buscar la vista indicada ----------
    Map<String, dynamic>? cfg;
    for (final raw in viewConfigJson) {
      try {
        final tmp = raw is String
            ? jsonDecode(raw) as Map<String, dynamic>
            : Map<String, dynamic>.from(raw as Map);
        if (tmp['view']?.toString() == viewName) {
          cfg = tmp;
          break;
        }
      } catch (e) {
        debugPrint('[getCsv3] Config vista ignorada: $e');
      }
    }
    if (cfg == null) {
      throw Exception('[getCsv3] view="$viewName" no encontrada.');
    }

    // Columnas visibles excluyendo acciones
    const actionCols = {'icons', 'edit', 'copy', 'pdf'};
    final visible = cfg['visible'] as List<dynamic>? ?? <dynamic>[];
    final fieldOrder = visible
        .whereType<String>()
        .where((c) => !actionCols.contains(c))
        .toList();
    if (fieldOrder.isEmpty) {
      throw Exception('[getCsv3] Vista sin columnas exportables.');
    }

    // ---------- 2. Crear mapa ui_sl ----------
    final Map<String, String> slHeaders = {};
    for (final raw in columnDefsJson) {
      try {
        final d = raw is String
            ? jsonDecode(raw) as Map<String, dynamic>
            : Map<String, dynamic>.from(raw as Map);
        slHeaders[d['column_name']?.toString() ?? ''] =
            d['ui_sl']?.toString() ?? '';
      } catch (e) {
        debugPrint('[getCsv3] Def col ignorada: $e');
      }
    }

    // Encabezados en esloveno, fallback al nombre
    final Map<String, String> missingSl = {};
    final headers = fieldOrder.map((c) {
      final h = slHeaders[c];
      if (h == null || h.trim().isEmpty) missingSl[c] = '⟨sin ui_sl⟩';
      return (h == null || h.trim().isEmpty) ? c : h;
    }).toList();

    if (missingSl.isNotEmpty) {
      debugPrint('[getCsv3] Columnas sin ui_sl: ${missingSl.keys.join(", ")}');
    }

    // ---------- 3. Construir CSV ----------
    String esc(v) {
      final s = v?.toString() ?? '';
      final quoted = s.contains(',') || s.contains('"') || s.contains('\n');
      final rep = s.replaceAll('"', '""');
      return quoted ? '"$rep"' : rep;
    }

    final sb = StringBuffer()..writeln(headers.map(esc).join(','));
    for (final raw in data) {
      final row = Map<String, dynamic>.from(raw as Map);
      sb.writeln(fieldOrder.map((f) => esc(row[f])).join(','));
    }

    // ---------- 4. Nota final ----------
    final fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
    sb.writeln();
    sb.writeln(exchangeRate != null
        ? 'To poročilo je bilo ustvarjeno z uporabo tečaja Banke Slovenije ($exchangeRate) na dan $fecha.'
        : 'To poročilo je bilo ustvarjeno z uporabo tečaja Banke Slovenije na dan $fecha.');

    final bytes = utf8.encode(sb.toString());
    final fileName =
        'export_${DateTime.now().toIso8601String().replaceAll(":", "-")}.csv';

    // ---------- 5. Descargar / guardar ----------
    if (kIsWeb) {
      final blob = html.Blob([bytes], 'text/csv;charset=utf-8');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..download = fileName
        ..style.display = 'none';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
      return;
    }

    final dir = await _downloadDir();
    final path = '${dir.path}/$fileName';
    await File(path).writeAsBytes(bytes);
    debugPrint('[getCsv3] CSV guardado en: $path');
  } catch (e, st) {
    debugPrint('[getCsv3] ERROR: $e');
    debugPrint('[getCsv3] StackTrace:\n$st');
    throw Exception(e.toString());
  }
}

// Ruta de descargas por plataforma
Future<Directory> _downloadDir() async {
  try {
    if (Platform.isAndroid) return Directory('/storage/emulated/0/Download');
    if (Platform.isIOS) return getApplicationDocumentsDirectory();
    return (await getDownloadsDirectory()) ?? await getTemporaryDirectory();
  } catch (e) {
    debugPrint('[getCsv3] Error obteniendo dir descargas: $e');
    return await getTemporaryDirectory();
  }
}
