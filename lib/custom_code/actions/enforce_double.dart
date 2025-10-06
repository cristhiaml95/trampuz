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

Future<double> enforceDouble(String? value) async {
  // Todo el código va dentro de esta función
  if (value == null) return 0.0;

  String input = value
      .replaceAll('\u00A0', ' ') // NBSP
      .replaceAll('\u2007', ' ') // Figure space
      .replaceAll('\u202F', ' ') // Narrow NBSP
      .replaceAll('\u2212', '-') // minus unicode (evita el char '−')
      .trim();

  if (input.isEmpty) return 0.0;

  // Detecta % y ‰ antes de limpiar
  final lower = input.toLowerCase();
  final hasPercent = input.contains('%') ||
      RegExp(r'\bpor\s*ciento\b').hasMatch(lower) ||
      lower.contains('percent');
  final hasPerMille = input.contains('‰');

  // Quita símbolos de moneda (ASCII only en el código)
  input = input
      .replaceAllMapped(
        RegExp(
          r'(S/\.?|US\$|USD|PEN|EUR|€|\$|£|¥|₹|₽|₩|₺|₫|₴|₡|₲|₦|₪|₱|฿|₵|₭|₼|₾|₿)',
          caseSensitive: false,
        ),
        (m) => '',
      )
      .trim();

  if (input.isEmpty) return 0.0;

  // Primer bloque numérico plausible
  // OJO: raw string con comillas DOBLES para permitir ' y usamos \u2019 para la comilla tipográfica
  final numMatch = RegExp(
    r"[-+()]?\d[\d\s.,'\u2019]*([eE][-+]?\d+)?",
  ).firstMatch(input);
  if (numMatch == null) return 0.0;

  String s = numMatch.group(0)!.trim();

  // Negativo contable por paréntesis
  bool negative = false;
  if (s.contains('(') && s.contains(')')) {
    negative = true;
    s = s.replaceAll('(', '').replaceAll(')', '');
  }

  // Quita espacios y apóstrofos usados como miles
  s = s.replaceAll(RegExp(r'\s'), '').replaceAll(RegExp(r"['\u2019]"), '');

  // Separa exponente (si hay) para no confundir separadores con el exponente
  String expPart = '';
  final expMatch = RegExp(r'[eE][+\-]?\d+$').firstMatch(s);
  if (expMatch != null) {
    expPart = s.substring(expMatch.start); // ej: e-3
    s = s.substring(0, expMatch.start);
  }

  // Signo al inicio
  if (s.startsWith('+')) {
    s = s.substring(1);
  } else if (s.startsWith('-')) {
    negative = true;
    s = s.substring(1);
  }

  // Limpia cualquier resto no numérico
  s = s.replaceAll(RegExp(r'[^0-9\.,]'), '');
  if (s.isEmpty) return 0.0;

  // Heurísticas de separadores , .
  int lastDot = s.lastIndexOf('.');
  int lastComma = s.lastIndexOf(',');
  String base = s;

  // --- Normalización inline (sin helpers externos) ---
  if (lastDot >= 0 && lastComma >= 0) {
    // Ambos presentes → el último que aparezca es decimal
    final String decimalSep = (lastDot > lastComma) ? '.' : ',';
    final String otherSep = decimalSep == '.' ? ',' : '.';

    // Patrón clásico de miles sin decimales (1.234.567 o 1,234,567)
    if (RegExp(r'^(\d{1,3}([.,]\d{3})+)$').hasMatch(base)) {
      base = base.replaceAll(RegExp(r'[.,]'), '');
    } else {
      base = base.replaceAll(otherSep, ''); // quita miles del otro separador
      final parts = base.split(decimalSep);
      if (parts.length > 2) {
        final last = parts.removeLast();
        base = parts.join('') +
            decimalSep +
            last; // conserva solo el último decimal
      }
    }
  } else if (lastDot >= 0 || lastComma >= 0) {
    final String decimalSep = (lastDot >= 0) ? '.' : ',';
    final String otherSep = decimalSep == '.' ? ',' : '.';

    // Patrón de miles sin decimales
    if (RegExp(r'^(\d{1,3}([.,]\d{3})+)$').hasMatch(base)) {
      base = base.replaceAll(RegExp(r'[.,]'), '');
    } else if (!base.contains(otherSep)) {
      // Decide si ese separador es decimal o miles por longitud del grupo final
      final int lastSep = base.lastIndexOf(decimalSep);
      if (lastSep >= 0) {
        final String after = base.substring(lastSep + 1);
        final int digitsAfter = after.replaceAll(RegExp(r'[^0-9]'), '').length;
        final String before =
            base.substring(0, lastSep).replaceAll(RegExp(r'[^0-9]'), '');
        final bool isProbablyThousands = digitsAfter == 3 && before.length >= 4;
        if (isProbablyThousands) {
          base = base.replaceAll(RegExp(r'[.,]'), '');
        } else {
          base = base.replaceAll(otherSep, '');
          final parts = base.split(decimalSep);
          if (parts.length > 2) {
            final last = parts.removeLast();
            base = parts.join('') + decimalSep + last;
          }
        }
      }
    } else {
      // Hay ambos tipos pero el otro separador actúa de miles
      base = base.replaceAll(otherSep, '');
      final parts = base.split(decimalSep);
      if (parts.length > 2) {
        final last = parts.removeLast();
        base = parts.join('') + decimalSep + last;
      }
    }
  }
  // --- Fin normalización inline ---

  // Estándariza coma decimal a punto
  base = base.replaceAll(',', '.');

  // Reconstruye con exponente (si hubo)
  String normalized = base + (expPart.isNotEmpty ? expPart : '');

  // Limpieza final
  normalized = normalized.replaceAll(RegExp(r'[^0-9eE+\-\.]'), '');
  final dotParts = normalized.split('.');
  if (dotParts.length > 2) {
    final last = dotParts.removeLast();
    normalized = dotParts.join('') + '.' + last;
  }

  double? parsed = double.tryParse(normalized);
  if (parsed == null) return 0.0;

  if (negative) parsed = -parsed;
  if (hasPerMille) {
    parsed = parsed / 1000.0;
  } else if (hasPercent) {
    parsed = parsed / 100.0;
  }

  return parsed;
}
