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

Future<int> quantityBalanceAction(List<dynamic>? jsonList) async {
  // Add your function code here!
  int balance = 0;

  try {
    if (jsonList == null || jsonList.isEmpty) {
      return balance; // Devuelve 0 si la lista viene nula o vacía
    }

    for (final item in jsonList) {
      try {
        // Verificar tipo de elemento
        if (item is! Map<String, dynamic>) {
          debugPrint(
              'quantityBalanceAction: elemento ignorado (no Map) -> $item');
          continue;
        }

        // Leer flow y quantity
        final flow = (item['flow'] ?? '').toString().toLowerCase().trim();
        final rawQty = item['quantity'];

        // Convertir quantity a num
        num? qty;
        if (rawQty is num) {
          qty = rawQty;
        } else if (rawQty is String) {
          final sanitized = rawQty.replaceAll(RegExp(r'[,\s]'), '');
          qty = num.tryParse(sanitized);
        }

        if (qty == null) {
          debugPrint(
              'quantityBalanceAction: quantity inválido "$rawQty" en $item');
          continue;
        }

        // Calcular balance según flow
        if (flow == 'in') {
          balance += qty.round();
        } else if (flow == 'out') {
          balance -= qty.round();
        } else {
          debugPrint(
              'quantityBalanceAction: flow desconocido "$flow" en $item');
        }
      } catch (e, st) {
        debugPrint(
            'quantityBalanceAction: error procesando elemento $item\n$e\n$st');
      }
    }
  } catch (e, st) {
    debugPrint('quantityBalanceAction: error fatal\n$e\n$st');
  }

  return balance;
}
