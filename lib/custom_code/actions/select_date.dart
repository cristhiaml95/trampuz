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

Future<DateTime> selectDate(BuildContext context) async {
  final DateTime now = DateTime.now();

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    initialEntryMode: DatePickerEntryMode.input, // modo entrada por teclado
    builder: (BuildContext context, Widget? child) {
      // Personaliza aquí si quieres tema/idioma; por defecto retorna el child.
      return child ?? const SizedBox.shrink();
    },
  );

  if (pickedDate != null) {
    // Retorna la fecha seleccionada (a las 00:00)
    return DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
  } else {
    // Retorna la fecha/hora actual si se cancela
    return now;
  }
}
