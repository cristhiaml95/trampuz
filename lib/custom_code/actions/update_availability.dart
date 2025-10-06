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

/// Actualiza (o elimina) el filtro `availability` dentro de una URL
/// o de un query–string.
///
/// * **newAvailability** –  `consumed`, `available`, `disassociated`,
///   `error`, `"all"` o `null`.
/// * **url** –  Puede ser la URL completa **o** únicamente el query
///   (`is_deleted=eq.false&limit=50`, por ejemplo).
///
/// Devuelve la misma estructura (URL completa o solo query) con
/// `availability` ajustado:
///   * si `newAvailability == 'all'` o `null` ⇒ se elimina el filtro.
///   * en otro caso ⇒ se pone `availability=eq.<nuevoValor>`.
Future<String> updateAvailability(
  String? newAvailability,
  String? url,
) async {
  if (url == null || url.isEmpty) return '';

  // ¿La cadena incluye ruta/base o solo parámetros?
  final bool hasBasePath = url.contains('?');

  // Separamos base y query.
  late String base;
  late String query;
  if (hasBasePath) {
    final int idx = url.indexOf('?');
    base = url.substring(0, idx);
    query = url.substring(idx + 1); // sin el '?'
  } else {
    base = ''; // solo parámetros
    query = url; // la cadena completa es el query
  }

  // Parseamos el query-string a un mapa mutable.
  final Map<String, String> params =
      Map<String, String>.from(Uri.splitQueryString(query));

  // Actualizamos o quitamos availability.
  if (newAvailability == null ||
      newAvailability.toLowerCase() == 'all' ||
      newAvailability.isEmpty) {
    params.remove('availability');
  } else {
    params['availability'] = 'eq.$newAvailability';
  }

  // Reconstruimos el query-string.
  final String newQuery = params.entries
      .map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');

  // Devolvemos en el mismo formato que recibimos.
  return hasBasePath ? '$base?$newQuery' : newQuery;
}
