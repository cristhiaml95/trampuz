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

import 'dart:async';

/// ====== Config ======
/// ID fijo del “custom” objetivo (Carinski) para la vista `customs`.
const String _CUSTOMS_TARGET_ID = '756a1fad-8f1e-43d4-ad2a-00ffdca46299';

/// Tiempos de control de ráfagas
const Duration _CUSTOMS_DEBOUNCE = Duration(milliseconds: 450);
const Duration _CUSTOMS_MIN_INTERVAL = Duration(milliseconds: 1000); // throttle

/// Nombre de la tabla de logs que emite eventos agregados (INSERT) vía Realtime.
const String _REFRESH_LOGS_TABLE = 'order_level_refresh_logs';

/// ====== Infra de debounce/colas por canal-vista ======
String _keyFor(String schema, String table, String viewName) =>
    '$schema.$table::$viewName';

final Map<String, Timer> _debounces = <String, Timer>{};
final Map<String, List<PostgresChangePayload>> _queues =
    <String, List<PostgresChangePayload>>{};

/// Marca del último refresh por canal-vista (para throttle)
final Map<String, DateTime> _lastRefreshAt = <String, DateTime>{};

List<PostgresChangePayload> _queue(String key) =>
    _queues.putIfAbsent(key, () => <PostgresChangePayload>[]);

void _cancelDebounce(String key) {
  final t = _debounces[key];
  if (t != null && t.isActive) t.cancel();
}

void _setDebounce(String key, Duration d, void Function() fn) {
  _cancelDebounce(key);
  _debounces[key] = Timer(d, fn);
}

/// ====== Utilidades ======
bool _asBool(dynamic v) {
  if (v is bool) return v;
  if (v is int) return v != 0;
  if (v is String) {
    final s = v.toLowerCase();
    return s == 'true' || s == 't' || s == '1';
  }
  return false;
}

bool _idEquals(dynamic a, dynamic b) {
  if (a == b) return true;
  if (a == null || b == null) return false;
  return '$a' == '$b';
}

/// ====== SELECT Top-50 para customs (reemplaza AppState) ======
void _logTop50OrderNos(List<Map<String, dynamic>> rows) {
  try {
    final orderNos = rows
        .map((r) => r['order_no'])
        .take(50)
        .map((v) => v?.toString() ?? '(null)')
        .toList();

    final cronos = rows.map((r) => r['crono']).where((c) => c != null).toList()
      ..sort((a, b) => a.toString().compareTo(b.toString()));

    final cronoMin = cronos.isNotEmpty ? cronos.first : null;
    final cronoMax = cronos.isNotEmpty ? cronos.last : null;

    print('📦 customs Top-50 ► total=${rows.length}');
    print('⏱️ crono[min..max]=[$cronoMin .. $cronoMax]');
    print('🧾 order_no[0..49]= ${orderNos.join(', ')}');
  } catch (e) {
    print('🟠 Error al loggear order_no Top-50: $e');
  }
}

Future<void> _refreshCustomsTop50(String customId) async {
  try {
    final supabase = SupaFlow.client;

    final res = await supabase
        .from('order_level')
        .select('*') // En FlutterFlow no usar genéricos aquí
        .eq('is_deleted', false)
        .neq('availability', 'consumed')
        .eq('custom', customId) // <- cambia el nombre de FK si difiere
        .order('crono', ascending: false, nullsFirst: false) // crono.desc
        .limit(50);

    final rows = (res as List).cast<Map<String, dynamic>>();

    _logTop50OrderNos(rows);

    // 🔄 reemplazo de lista envuelto en update() para que FlutterFlow pinte
    FFAppState().update(() {
      FFAppState().customsApiOPJsonList = List.from(rows);
    });

    print(
        '✅ customs refrescado (Top-50) custom=$customId, filas=${rows.length}.');
  } catch (e) {
    print('🔴 Error refrescando customs Top-50: $e');
  }
}

/// ====== Parches locales estándar para otras vistas ======
void _applyChangesToList(
  List<dynamic> currentList,
  List<PostgresChangePayload> changes,
) {
  for (final change in changes) {
    final eventType = change.eventType;

    final Map<String, dynamic>? newRecord = (change.newRecord != null)
        ? Map<String, dynamic>.from(change.newRecord!)
        : null;
    final Map<String, dynamic>? oldRecord = (change.oldRecord != null)
        ? Map<String, dynamic>.from(change.oldRecord!)
        : null;

    final dynamic recordId = newRecord?['id'] ?? oldRecord?['id'];
    if (recordId == null) {
      print('🟠 Cambio sin ID; se ignora. Tipo: $eventType');
      continue;
    }

    final bool newDeleted =
        _asBool(newRecord?['is_deleted'] ?? newRecord?['is_delete'] ?? false);
    final bool oldDeleted =
        _asBool(oldRecord?['is_deleted'] ?? oldRecord?['is_delete'] ?? false);

    final int idx =
        currentList.indexWhere((row) => _idEquals(row['id'], recordId));

    if (eventType == PostgresChangeEvent.update) {
      final bool wentFromFalseToTrue = (!oldDeleted && newDeleted);
      final bool wentFromTrueToFalse = (oldDeleted && !newDeleted);

      if (wentFromFalseToTrue) {
        if (idx != -1) {
          currentList.removeAt(idx);
          print('✅ [UPDATE] ID=$recordId is_deleted: false→true ⇒ removido.');
        } else {
          print('ℹ️ [UPDATE] ID=$recordId ya no estaba visible.');
        }
        continue;
      }

      if (!newDeleted) {
        if (idx != -1) {
          currentList[idx] = newRecord!;
          print('✅ [UPDATE] ID=$recordId actualizado en la lista.');
        } else {
          currentList.insert(0, newRecord!);
          if (wentFromTrueToFalse) {
            print('✅ [UPDATE] ID=$recordId reinsertado (undelete).');
          } else {
            print('✅ [UPDATE] ID=$recordId insertado (no estaba).');
          }
        }
      } else {
        if (idx != -1) {
          currentList.removeAt(idx);
          print('✅ [UPDATE] ID=$recordId removido por is_deleted=true.');
        }
      }
    } else if (eventType == PostgresChangeEvent.insert) {
      if (!newDeleted && newRecord != null) {
        currentList.insert(0, newRecord);
        print('✅ [INSERT] ID=$recordId insertado en la lista.');
      } else {
        print('🟡 [INSERT] ID=$recordId con is_deleted=true; no se muestra.');
      }
    } else if (eventType == PostgresChangeEvent.delete) {
      if (idx != -1) {
        currentList.removeAt(idx);
        print('✅ [DELETE] ID=$recordId removido de la lista.');
      } else {
        print('ℹ️ [DELETE] ID=$recordId no estaba en la lista.');
      }
    }
  }
}

void _updateStateForView(String viewName, List<PostgresChangePayload> changes) {
  FFAppState().update(() {
    switch (viewName) {
      case 'orderWarehouse':
        {
          final list = FFAppState().orderWarehouseApiOPJsonList;
          _applyChangesToList(list, changes);
          FFAppState().orderWarehouseApiOPJsonList = List.from(list);
          break;
        }
      case 'warehouse2':
        {
          final list = FFAppState().warehouse2ApiOPJsonList;
          _applyChangesToList(list, changes);
          FFAppState().warehouse2ApiOPJsonList = List.from(list);
          break;
        }
      case 'calendar':
        {
          final list = FFAppState().calendarApiOPJsonList;
          _applyChangesToList(list, changes);
          FFAppState().calendarApiOPJsonList = List.from(list);
          break;
        }
      case 'customs':
        {
          // En customs no se parchea fila a fila: se refresca en bloque.
          break;
        }
      case 'reports':
        {
          final list = FFAppState().reportsApiOPJsonList;
          _applyChangesToList(list, changes);
          FFAppState().reportsApiOPJsonList = List.from(list);
          break;
        }
      default:
        print('🔴 ERROR: viewName "$viewName" no reconocido.');
    }
  });
}

/// Conectar a Realtime para una tabla base y para la tabla de logs agregados.
/// - Para `customs`:
///   a) reacciona a cambios en `order_level` SOLO si pertenecen al custom objetivo (fila a fila)
///   b) reacciona a INSERT en `order_level_refresh_logs` cuando `is_customs_operation = true`
///      ⇒ fuerza refresh Top-50 (soluciona el caso de RPC masivo)
Future<void> conectar(
  String tabela, // p.ej. 'order_level'
  String? viewName, // p.ej. 'customs'
) async {
  if (viewName == null || viewName.isEmpty) {
    print('🔴 ERROR en conectar: El parámetro viewName es requerido.');
    return;
  }

  final supabase = SupaFlow.client;
  const schema = 'public';

  /// ====== Carga inicial para customs ======
  if (viewName == 'customs' && _CUSTOMS_TARGET_ID.isNotEmpty) {
    print('🚚 Carga inicial customs Top-50 para custom=$_CUSTOMS_TARGET_ID');
    await _refreshCustomsTop50(_CUSTOMS_TARGET_ID);
  }

  /// ====== Suscripción a la tabla base (order_level) ======
  final baseChannelName = '$schema:$tabela';
  final baseChannel = supabase.channel(baseChannelName);
  final baseKey = _keyFor(schema, tabela, viewName);

  baseChannel
      .onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: schema,
        table: tabela,
        callback: (payload) async {
          try {
            // Feedback visual inmediato
            FFAppState().update(() {
              FFAppState().updates = FFAppState().updates + 1;
            });

            if (viewName == 'customs') {
              final String? idFromEvent =
                  payload.newRecord?['custom']?.toString() ??
                      payload.oldRecord?['custom']?.toString();

              // Solo refresca si el evento es del custom objetivo
              if (idFromEvent != _CUSTOMS_TARGET_ID) {
                // Silencioso para no inundar logs
                return;
              }

              // Debounce + throttle
              Duration delay = _CUSTOMS_DEBOUNCE;
              final last = _lastRefreshAt[baseKey];
              if (last != null) {
                final elapsed = DateTime.now().difference(last);
                if (elapsed < _CUSTOMS_MIN_INTERVAL) {
                  delay += (_CUSTOMS_MIN_INTERVAL - elapsed);
                }
              }

              print(
                  '⏳ Programando refresh customs en ${delay.inMilliseconds}ms '
                  '(evento=${payload.eventType}, idFromEvent=$idFromEvent)');

              _setDebounce(baseKey, delay, () async {
                print(
                    '🚀 Ejecutando refresh customs (custom=$_CUSTOMS_TARGET_ID)…');
                _lastRefreshAt[baseKey] = DateTime.now();
                await _refreshCustomsTop50(_CUSTOMS_TARGET_ID);
                print('🏁 Refresh customs terminado.');
              });

              return; // customs no encola ni parchea fila a fila
            }

            // —— Otras vistas: encola y procesa TODOS los eventos en orden ——
            final q = _queue(baseKey);
            q.add(payload);

            _setDebounce(baseKey, const Duration(milliseconds: 500), () {
              if (q.isEmpty) return;

              // ✅ Procesar en el orden de llegada, sin dedupe,
              // para no perder UPDATE is_deleted=true / DELETE tras un INSERT.
              final toProcess = List<PostgresChangePayload>.from(q);
              q.clear();

              _updateStateForView(viewName, toProcess);
            });
          } catch (e) {
            print('🔴 ERROR al procesar payload Realtime (base): $e');
          }
        },
      )
      .subscribe();

  print('🟢 Suscrito a tabla base: $baseChannelName (vista=$viewName)');

  /// ====== Suscripción a la tabla de logs agregados ======
  /// Reaccionamos a INSERT cuando is_customs_operation = true
  if (viewName == 'customs') {
    final logsChannelName = '$schema:${_REFRESH_LOGS_TABLE}';
    final logsChannel = supabase.channel(logsChannelName);
    final logsKey = _keyFor(schema, _REFRESH_LOGS_TABLE, viewName);

    logsChannel
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: schema,
          table: _REFRESH_LOGS_TABLE,
          callback: (payload) async {
            try {
              final Map<String, dynamic> row =
                  Map<String, dynamic>.from(payload.newRecord ?? {});

              final bool isCustomsOp = _asBool(row['is_customs_operation']) ||
                  _asBool(row['customs_propagated']); // compat

              if (!isCustomsOp) {
                // No es operación aduanera ⇒ ignorar
                return;
              }

              final String opType = (row['operation_type'] ?? '').toString();
              final int? execMs = row['execution_time_ms'] is int
                  ? row['execution_time_ms'] as int
                  : int.tryParse('${row['execution_time_ms'] ?? ''}');
              final int? updated = row['records_updated'] is int
                  ? row['records_updated'] as int
                  : int.tryParse('${row['records_updated'] ?? ''}');

              print('📣 Log agregado (aduanas): type=$opType '
                  'execMs=${execMs ?? '-'}ms, updated=${updated ?? '-'}');

              // Debounce + throttle frente a ráfagas de logs
              Duration delay = _CUSTOMS_DEBOUNCE;
              final last = _lastRefreshAt[logsKey];
              if (last != null) {
                final elapsed = DateTime.now().difference(last);
                if (elapsed < _CUSTOMS_MIN_INTERVAL) {
                  delay += (_CUSTOMS_MIN_INTERVAL - elapsed);
                }
              }

              _setDebounce(logsKey, delay, () async {
                print(
                    '🚀 Refresh Top-50 por log agregado (custom=$_CUSTOMS_TARGET_ID)…');
                _lastRefreshAt[logsKey] = DateTime.now();
                await _refreshCustomsTop50(_CUSTOMS_TARGET_ID);
                print('🏁 Refresh por log terminado.');
              });
            } catch (e) {
              print('🔴 ERROR al procesar INSERT en $_REFRESH_LOGS_TABLE: $e');
            }
          },
        )
        .subscribe();

    print('🛰️ Suscrito a tabla de logs: $logsChannelName (INSERT)');
  }
}
