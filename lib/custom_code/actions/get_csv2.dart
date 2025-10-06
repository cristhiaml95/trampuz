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

import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

// ▸ Para Web
import 'package:universal_html/html.dart' as html;

// ▸ Para Android / iOS / Desktop
import 'dart:io' show Directory, File, Platform;
import 'package:path_provider/path_provider.dart';

/// Genera un CSV con las columnas indicadas y **lo descarga al instante**.
/// No devuelve nada.
///
/// * **Web** → crea un Blob y dispara la descarga (igual que tu ejemplo).
/// * **Mobile / Desktop** → guarda el archivo en la carpeta *Downloads*
///   (o *Documents* en iOS). Si sólo compilas a Web, ignora la parte móvil.
Future<void> getCsv2(
  List<dynamic>? data,
  List<dynamic>? columns,
) async {
  if (data == null || data.isEmpty || columns == null || columns.isEmpty) {
    return;
  }

  // ---------- 1. Construir el CSV en memoria ------------------------------
  final defs = columns.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  final fieldOrder = defs.map((c) => c['column_name'] as String).toList();
  final headers =
      defs.map((c) => (c['ui_en'] ?? c['column_name']).toString()).toList();

  String esc(dynamic v) {
    final s = v?.toString() ?? '';
    final needsQuotes = s.contains(',') || s.contains('"') || s.contains('\n');
    final rep = s.replaceAll('"', '""');
    return needsQuotes ? '"$rep"' : rep;
  }

  final sb = StringBuffer()..writeln(headers.map(esc).join(','));
  for (final raw in data) {
    final row = Map<String, dynamic>.from(raw as Map);
    sb.writeln(fieldOrder.map((f) => esc(row[f])).join(','));
  }
  final csvBytes = utf8.encode(sb.toString());
  final fileName =
      'export_${DateTime.now().toIso8601String().replaceAll(":", "-")}.csv';

  // ---------- 2. WEB: descarga directa ------------------------------------
  if (kIsWeb) {
    final blob = html.Blob([csvBytes], 'text/csv;charset=utf-8');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..download = fileName
      ..style.display = 'none';
    html.document.body!.children.add(anchor);
    anchor.click(); // ← dispara descarga
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    return; // nada más que hacer
  }

  // ---------- 3. ANDROID / IOS / Desktop ----------------------------------
  final dir = await _downloadDir();
  final path = '${dir.path}/$fileName';
  final file = File(path);
  await file.writeAsBytes(csvBytes);

  // Opcional: mostrar un mensaje de éxito en consola
  debugPrint('CSV guardado en: $path');
}

// Carpeta de destino en plataformas no-web
Future<Directory> _downloadDir() async {
  if (Platform.isAndroid) {
    // Ruta típica de descargas en Android
    return Directory('/storage/emulated/0/Download');
  }
  if (Platform.isIOS) {
    // iOS no expone "Downloads"; usamos Documents
    return await getApplicationDocumentsDirectory();
  }
  // macOS / Windows / Linux
  return await getDownloadsDirectory() ?? await getTemporaryDirectory();
}
