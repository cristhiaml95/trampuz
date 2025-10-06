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

Future<List<dynamic>> updateCurrentGridState(
  String? gridStateId,
  List<dynamic>? gridStateList,
) async {
  // Normaliza entradas nulas
  if (gridStateList == null) return <dynamic>[];
  final id = gridStateId?.trim();
  // Si no se pasa id, no cambiamos nada: devolvemos tal cual
  if (id == null || id.isEmpty) {
    // Asegura que devolvemos una lista “limpia”
    return List<dynamic>.from(gridStateList);
  }

  // Convierte elemento a elemento a Map<String,dynamic> para tipar correctamente
  final list = gridStateList
      .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map))
      .toList();

  // Intentamos extraer el nombre de la vista desde el id: "<view>-<n>"
  String? viewFromId;
  final m = RegExp(r'^(.*)-(\d+)$').firstMatch(id);
  if (m != null) {
    viewFromId = m.group(1);
  }

  bool updated = false;

  for (var i = 0; i < list.length; i++) {
    final entry = Map<String, dynamic>.from(list[i]);
    final view = (entry['view'] ?? '').toString();

    // Obtiene states tipados
    final statesDyn = entry['states'];
    final states = (statesDyn is List)
        ? statesDyn
            .map<Map<String, dynamic>>(
                (s) => Map<String, dynamic>.from(s as Map))
            .toList()
        : <Map<String, dynamic>>[];

    // ¿Este id existe dentro de esta vista?
    final foundIdx = states.indexWhere((s) => (s['id'] ?? '').toString() == id);

    if (foundIdx >= 0) {
      // Caso 1: el id pertenece a esta vista → actualizar activeId aquí
      entry['activeId'] = id;
      // Reasignar states (sin cambios) y guardar entrada
      entry['states'] = states;
      list[i] = entry;
      updated = true;
      break;
    }

    // Caso 2: no se encontró, pero el prefijo del id coincide con esta vista
    // (permite activar un id que ya sabemos que pertenece a esta vista aunque
    // aún no estuviera en states; útil para escenarios de sync parcial)
    if (!updated && viewFromId != null && viewFromId == view) {
      entry['activeId'] = id;
      entry['states'] = states;
      list[i] = entry;
      updated = true;
      break;
    }
  }

  // Si no se pudo actualizar ninguna vista, simplemente devolvemos la lista original tipada
  return List<dynamic>.from(list);
}
