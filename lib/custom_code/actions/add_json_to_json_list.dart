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

/// Inserta un JSON (dynamic) al inicio de una lista de JSON (List<dynamic>).
/// - Si `jsonList` es null, se crea una nueva lista.
/// - Si `json` es null, se devuelve la lista original (o una lista vacía) sin cambios.
///
/// Ejemplos:
///   addJsonToJsonList({'a':1}, [{'b':2}]) -> [{'a':1}, {'b':2}]
///   addJsonToJsonList({'a':1}, null)       -> [{'a':1}]
Future<List<dynamic>> addJsonToJsonList(
  dynamic json,
  List<dynamic>? jsonList,
) async {
  // Si no hay elemento que insertar, devolvemos una copia segura de la lista original.
  if (json == null) {
    return List<dynamic>.from(jsonList ?? const []);
  }

  // Creamos una lista nueva para evitar mutar la referencia original (seguro para FF).
  final List<dynamic> result = <dynamic>[];

  // Añadimos primero el JSON recibido.
  result.add(json);

  // Si existe una lista previa, concatenamos sus elementos preservando el orden.
  if (jsonList != null && jsonList.isNotEmpty) {
    result.addAll(jsonList);
  }

  return result;
}
