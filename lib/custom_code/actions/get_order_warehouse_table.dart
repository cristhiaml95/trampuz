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
import 'dart:convert'; // jsonDecode para cadenas JSON

/// Descarga las 50 últimas órdenes de `order_level` y sincroniza los grid
/// states.
///
/// - Prefiere users.grid_state_list / users.current_grid_set (nuevo shape) -
/// Si faltan, migra desde users.last_grid_state (viejo shape) al nuevo -
/// Reconciliación: si current_grid_set pide un id, lo fuerza como activeId -
/// Actualiza FFAppState().plutogridTableInfo y FFAppState().currentGridSet -
/// Persiste migraciones/reconciliaciones en users para próximos arranques
Future getOrderWarehouseTable() async {
  const verbose = true; // <- ponlo en false si no quieres logs verbosos
  final supabase = SupaFlow.client;
  final currentUser = supabase.auth.currentUser;

  // ========= Helpers de logging =========
  String _typeOf(dynamic x) => x == null ? 'null' : x.runtimeType.toString();
  String _short(String s, [int max = 500]) =>
      (s.length <= max) ? s : '${s.substring(0, max)}… (${s.length} chars)';
  String _pretty(Object o) => const JsonEncoder.withIndent('  ').convert(o);

  void log(String msg) {
    if (verbose) debugPrint(msg);
  }

  void logJson(String title, Object? obj, {int max = 800}) {
    if (!verbose) return;
    try {
      final s = obj == null ? 'null' : _pretty(obj);
      debugPrint('$title:\n${_short(s, max)}');
    } catch (_) {
      debugPrint('$title: <no printable>');
    }
  }

  // ========= Helpers de datos =========

  // Normaliza un valor (List/List<String>/String) a List<Map<String,dynamic>>
  List<Map<String, dynamic>> _asJsonList(dynamic raw) {
    try {
      if (raw == null) return const [];
      if (raw is List) {
        final out = <Map<String, dynamic>>[];
        for (final e in raw) {
          if (e == null) continue;
          if (e is Map) {
            out.add(Map<String, dynamic>.from(e));
          } else if (e is String) {
            if (e.trim().isEmpty) continue;
            final dec = jsonDecode(e);
            if (dec is Map) out.add(Map<String, dynamic>.from(dec));
          }
        }
        return out;
      }
      if (raw is String && raw.trim().isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          final out = <Map<String, dynamic>>[];
          for (final e in decoded) {
            if (e == null) continue;
            if (e is Map) out.add(Map<String, dynamic>.from(e));
          }
          return out;
        }
      }
    } catch (e) {
      log('⚠️ _asJsonList decode error: $e');
    }
    return const [];
  }

  // Firma determinística del payload para deduplicar
  String _payloadSig(Map<String, dynamic> payload) {
    final vis = List<String>.from(payload['visible'] ?? const <String>[]);
    final hid = List<String>.from(payload['hidden'] ?? const <String>[]);
    final wMap = Map<String, dynamic>.from(payload['widths'] ?? const {});

    final visPart = vis.join('|'); // visible respeta orden
    hid.sort();
    final hidPart = hid.join('|');

    final keys = wMap.keys.map((e) => e.toString()).toList()..sort();
    final widthParts = <String>[];
    for (final k in keys) {
      final v = (wMap[k] as num?)?.toDouble() ?? 0.0;
      widthParts.add('$k=${v.toStringAsFixed(3)}');
    }
    final widPart = widthParts.join('|');

    return 'V:${visPart}__H:${hidPart}__W:${widPart}';
  }

  // Garantiza shape nuevo: 1 json por vista con {states:[], activeId} (máx 3, dedup por firma)
  List<Map<String, dynamic>> _normalizeNewShape(
    List<Map<String, dynamic>> list,
  ) {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final result = <Map<String, dynamic>>[];

    for (final entry in list) {
      if (entry.isEmpty) continue;
      final view = entry['view']?.toString();
      if (view == null || view.isEmpty) continue;

      if (entry.containsKey('states')) {
        final rawStatesDyn = entry['states'] ?? const <Map<String, dynamic>>[];
        final rawStates = (rawStatesDyn as List)
            .map<Map<String, dynamic>>(
                (e) => Map<String, dynamic>.from(e as Map))
            .toList();

        // NO hacer dedup aquí - los datos vienen de la DB y deben respetarse
        // La deduplicación solo debe ocurrir en el momento de GUARDAR (en PlutoGrid)
        final normalized = <Map<String, dynamic>>[];
        for (final s in rawStates) {
          final payload = Map<String, dynamic>.from(
              s['payload'] ?? const <String, dynamic>{});
          normalized.add({
            'name': s['name']?.toString(),
            'updatedAt': s['updatedAt']?.toString(),
            'payload': {
              'visible': List<String>.from(payload['visible'] ?? const []),
              'hidden': List<String>.from(payload['hidden'] ?? const []),
              'widths':
                  Map<String, dynamic>.from(payload['widths'] ?? const {}),
            }
          });
        }

        // Máx 3 y reasignar ids
        final capped = normalized.take(3).toList();
        for (var i = 0; i < capped.length; i++) {
          capped[i] = {
            'id': '$view-$i',
            'name': capped[i]['name']?.toString() ?? 'Perfil #${i + 1}',
            'updatedAt': capped[i]['updatedAt']?.toString() ?? nowIso,
            'payload': Map<String, dynamic>.from(capped[i]['payload'] as Map),
          };
        }

        // activeId consistente
        String? activeId = entry['activeId']?.toString();
        if (activeId == null ||
            (!capped.any((s) => s['id'] == activeId) && capped.isNotEmpty)) {
          activeId = '$view-0';
        }

        result.add({'view': view, 'states': capped, 'activeId': activeId});
      }
    }

    return result;
  }

  // Migración: viejo → nuevo (agrupa por vista, toma hasta 3 por vista)
  List<Map<String, dynamic>> _migrateOldToNew(
    List<Map<String, dynamic>> oldList,
  ) {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final byView = <String, List<Map<String, dynamic>>>{};

    for (final e in oldList) {
      final view = e['view']?.toString() ?? '';
      if (view.isEmpty) continue;

      final payload = <String, dynamic>{
        'visible': List<String>.from(e['visible'] ?? const <String>[]),
        'hidden': List<String>.from(e['hidden'] ?? const <String>[]),
        'widths': Map<String, dynamic>.from(e['widths'] ?? const {}),
      };

      final sig = _payloadSig(payload);
      if (sig.isEmpty) continue;

      final list = byView.putIfAbsent(view, () => <Map<String, dynamic>>[]);
      final exists = list.any((x) {
        final px = x['payload'];
        if (px is Map) {
          return _payloadSig(Map<String, dynamic>.from(px)) == sig;
        }
        return false;
      });
      if (!exists) list.add({'payload': payload});
    }

    final migrated = <Map<String, dynamic>>[];
    byView.forEach((view, items) {
      final capped = items.take(3).toList();
      final states = <Map<String, dynamic>>[];
      for (var i = 0; i < capped.length; i++) {
        states.add({
          'id': '$view-$i',
          'name': 'Migrado #${i + 1}',
          'updatedAt': nowIso,
          'payload': capped[i]['payload'],
        });
      }
      final activeId = states.isNotEmpty ? '$view-0' : null;
      migrated.add({'view': view, 'states': states, 'activeId': activeId});
    });

    return migrated;
  }

  // Deriva current_grid_set desde plutogridTableInfo (nuevo shape)
  List<Map<String, dynamic>> _deriveCurrentGridSet(
    List<Map<String, dynamic>> plist,
  ) {
    final res = <Map<String, dynamic>>[];
    for (final entry in plist) {
      final view = entry['view']?.toString();
      final activeId = entry['activeId']?.toString();
      if (view != null && activeId != null) {
        res.add({'view': view, 'id': activeId});
      }
    }
    return res;
  }

  // Reconciliar: si currentGridSet pide id para una vista, forzar activeId en esa vista
  // Devuelve (plistReconciliada, huboCambios)
  (List<Map<String, dynamic>>, bool) _reconcileActiveIds(
    List<Map<String, dynamic>> plist,
    List<Map<String, dynamic>> cgs,
  ) {
    if (plist.isEmpty || cgs.isEmpty) return (plist, false);

    final byViewSelected = <String, String>{};
    for (final e in cgs) {
      final v = e['view']?.toString();
      final id = e['id']?.toString();
      if (v != null && id != null) byViewSelected[v] = id;
    }

    bool changed = false;
    final out = <Map<String, dynamic>>[];

    for (final entry in plist) {
      final view = entry['view']?.toString() ?? '';
      if (view.isEmpty) {
        out.add(entry);
        continue;
      }
      final wantId = byViewSelected[view];
      if (wantId == null) {
        out.add(entry);
        continue;
      }

      final states = List<Map<String, dynamic>>.from(
        (entry['states'] ?? const <Map<String, dynamic>>[])
            .map((e) => Map<String, dynamic>.from(e as Map)),
      );
      if (states.any((s) => s['id'] == wantId)) {
        final currentActive = entry['activeId']?.toString();
        if (currentActive != wantId) {
          final ne = Map<String, dynamic>.from(entry);
          ne['activeId'] = wantId;
          out.add(ne);
          changed = true;
        } else {
          out.add(entry);
        }
      } else {
        // Si no existe el id pedido en states, mantenemos el activeId existente
        out.add(entry);
      }
    }

    return (out, changed);
  }

  log('🔎 [getOrderWarehouseTable] start');

  // ========= 1) order_level =========
  try {
    final List<dynamic> orderData = await supabase
        .from('order_level')
        .select('''
          order_no,taric_code,value_per_unit,custom_percentage_per_cost,
          acumulated_customs_percentages,remaining_customs_threshold,
          customs_percentage,euro_or_dolar,exchange_rate_used,
          dolars,euros,current_customs_warranty,
          client_name,inv_status,acepted,precheck,checked,warehouse_name,
          order_status,eta_date,flow,licence_plate,improvement,container_no,quantity,
          packaging_name,weight,pallet_position,universal_ref_no,fms_ref,load_ref_dvh,
          custom_name,internal_ref_custom,comment,documents,item,opis_blaga,loading_type,
          other_manipulation,responsible_name,responsible_last_name,assistant1_name,
          assistant1_last_name,assistant2_name,assistant2_last_name,admin_name,
          admin_last_name,internal_accounting,details,loading_gate_ramp,loading_sequence,
          assistant3_name,assistant3_last_name,assistant4_name,assistant4_last_name,
          assistant5_name,assistant5_last_name,assistant6_name,assistant6_last_name,
          loading_type2,associated_orders,no_barcodes,repeated_barcodes,availability,
          damage_mark,id,warehouse,quantity_available,barcodes,good,good_description,
          packaging,client,custom,eta_date2,eta_i2,eta_f2,arrival2,start2,stop2,
          created_at2,admin,assistant1,assistant2,assistant3,assistant4,assistant5,
          assistant6,associated_order
        ''')
        .eq('is_deleted', false)
        .neq('availability', 'consumed')
        .order('crono', ascending: false)
        .limit(50);

    final orderRows = (orderData ?? const [])
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    log('📦 order_level -> ${orderRows.length} filas');
    FFAppState().update(() {
      FFAppState().orderWarehouseApiOPJsonList = orderRows;
    });
  } catch (e, st) {
    debugPrint('❌ order_level error: $e\n$st');
  }

  // ========= 2) users.* grid states =========
  if (currentUser == null) {
    log('ℹ️ No hay usuario autenticado: se omiten grid states.');
    return;
  }

  try {
    final Map<String, dynamic>? userRowDyn = await supabase
        .from('users')
        .select('grid_state_list,current_grid_set,last_grid_state')
        .eq('id', currentUser.id)
        .maybeSingle();

    if (userRowDyn == null) {
      log('⚠️ El usuario ${currentUser.id} no existe en users.');
      return;
    }

    final userRow = Map<String, dynamic>.from(userRowDyn);

    log('👤 users.row obtenido. Tipos -> '
        'grid_state_list: ${_typeOf(userRow['grid_state_list'])}, '
        'current_grid_set: ${_typeOf(userRow['current_grid_set'])}, '
        'last_grid_state: ${_typeOf(userRow['last_grid_state'])}');

    // Preferimos nuevo shape
    List<Map<String, dynamic>> gridStateList =
        _asJsonList(userRow['grid_state_list']);
    List<Map<String, dynamic>> currentGridSet =
        _asJsonList(userRow['current_grid_set']);

    log('🧩 parseados: grid_state_list(vistas)=${gridStateList.length}, '
        'current_grid_set=${currentGridSet.length}');

    bool mustPersist = false;

    // Si no hay nuevo shape, migrar desde last_grid_state (viejo)
    if (gridStateList.isEmpty) {
      final old = _asJsonList(userRow['last_grid_state']);
      if (old.isNotEmpty) {
        gridStateList = _migrateOldToNew(old);
        mustPersist = true;
        log('🛠 Migrado last_grid_state → grid_state_list (${gridStateList.length} vistas).');
      } else {
        log('ℹ️ No hay last_grid_state para migrar.');
      }
    }

    // Asegurar shape correcto (dedup, clamp, ids)
    final normalized = _normalizeNewShape(gridStateList);
    if (jsonEncode(normalized) != jsonEncode(gridStateList)) {
      gridStateList = normalized;
      mustPersist = true;
      log('🔧 Normalizado grid_state_list al nuevo shape.');
    }

    // Si no vino currentGridSet, derivarlo del activo de cada vista
    if (currentGridSet.isEmpty) {
      currentGridSet = _deriveCurrentGridSet(gridStateList);
      mustPersist = true;
      log('🧭 current_grid_set derivado de activeId por vista.');
    }

    // Reconciliar: si currentGridSet pide un id, forzar activeId en cada vista
    final (reconciled, changed) =
        _reconcileActiveIds(gridStateList, currentGridSet);
    if (changed) {
      gridStateList = reconciled;
      mustPersist = true;
      log('🔁 Reconciliado activeId desde current_grid_set.');
    }

    // === Logs finales previos a AppState
    log('📋 Resumen vistas:');
    for (final e in gridStateList) {
      final view = e['view'];
      final activeId = e['activeId'];
      final states = (e['states'] as List?) ?? const [];
      log('  • view=$view  activeId=$activeId  states=${states.length}');
    }
    logJson('▶ current_grid_set (final)', currentGridSet);

    // === Actualiza SIEMPRE AppState para que el widget reaccione ===
    FFAppState().update(() {
      // 👇 AQUI se guarda grid_state_list en plutogridTableInfo
      FFAppState().plutogridTableInfo = gridStateList;
      FFAppState().currentGridSet = currentGridSet;
    });
    // ✅ Mensaje explícito de éxito
    debugPrint(
        '✅ plutogridTableInfo actualizado desde grid_state_list (${gridStateList.length} vistas). '
        'currentGridSet=${currentGridSet.length} entradas.');

    // Persistir cambios en DB si hubo migraciones/reconciliaciones
    if (mustPersist) {
      try {
        await supabase.from('users').update({
          'grid_state_list': gridStateList,
          'current_grid_set': currentGridSet,
        }).eq('id', currentUser.id);
        log('💾 Persistidos grid_state_list y current_grid_set en DB.');
      } catch (e) {
        log('⚠️ No pude persistir grid_state_list/current_grid_set: $e');
      }
    } else {
      log('ℹ️ No había nada que persistir (DB ya consistente).');
    }
  } catch (error, stack) {
    debugPrint('❌ users grid state error: $error\n$stack');
  }

  log('🏁 [getOrderWarehouseTable] done');
}
