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

Future<List<String>> getFiltersAppliedList(
  String? language,
  String? urlColumns,
  List<dynamic> columns,
) async {
  // --- Early exits / defaults ---
  if (urlColumns == null || urlColumns.trim().isEmpty) return [];
  final lang = (language ?? 'en').toLowerCase();

  // --- Build a quick lookup for column metadata (skip Icon types later) ---
  final Map<String, Map<String, dynamic>> colByName = {};
  for (final item in columns) {
    if (item is Map) {
      final name = (item['column_name'] ?? '').toString();
      if (name.isEmpty) continue;
      colByName[name] = item.map((k, v) => MapEntry(k.toString(), v));
    }
  }

  // Helper: is this column an Icon type?
  bool _isIcon(Map<String, dynamic> col) {
    final dtype = (col['datatype'] ?? '').toString().toLowerCase();
    return dtype == 'icon';
  }

  // Helper: label for language with fallbacks
  String _labelFor(Map<String, dynamic> col) {
    final key = 'ui_${lang}';
    String label = (col[key] ?? '').toString().trim();
    if (label.isEmpty) {
      label = (col['ui_en'] ?? '').toString().trim();
    }
    if (label.isEmpty) {
      label = (col['column_name'] ?? '').toString();
    }
    return label;
  }

  // --- Parse the querystring robustly (manual split to tolerate duplicate keys) ---
  // Replace '+' with space for safety, then percent-decode each component.
  final String qs = urlColumns.replaceAll('+', ' ');

  // Keys we explicitly ignore (not filters)
  const Set<String> ignoreKeys = {
    'order',
    'limit',
    'offset',
    'select',
    'page',
    'page_size',
    'pagesize',
  };

  // Set to preserve insertion order while avoiding duplicates
  final Set<String> filteredColumnNames = <String>{};

  // Helper: Add a column name if it exists in provided columns and is not Icon
  void _maybeAddColumn(String rawKey) {
    final key = rawKey.trim();
    if (key.isEmpty) return;
    final col = colByName[key];
    if (col == null) return; // not a known/visible column
    if (_isIcon(col)) return; // skip icon datatypes
    filteredColumnNames.add(key);
  }

  // Helper: parse OR/AND values like "(col.op.value,col2.op.value,...)"
  void _parseLogicalGroup(String decodedValue) {
    // Example decodedValue: "(custom_name.eq.CARINSKI POSTOPEK,order_no.ilike.*156*)"
    // We'll extract any <column>.<op>. pattern; op may be prefixed by "not."
    final regex =
        RegExp(r'([a-zA-Z0-9_]+)\.(?:not\.)?[a-zA-Z]+\.', caseSensitive: false);
    for (final match in regex.allMatches(decodedValue)) {
      final colName = match.group(1);
      if (colName != null) {
        _maybeAddColumn(colName);
      }
    }
  }

  for (final pair in qs.split('&')) {
    if (pair.trim().isEmpty) continue;
    final int eqIdx = pair.indexOf('=');
    if (eqIdx <= 0) continue;

    final rawKey = pair.substring(0, eqIdx);
    final rawVal = pair.substring(eqIdx + 1);

    final key = Uri.decodeComponent(rawKey).trim();
    final value = Uri.decodeComponent(rawVal);

    if (key.isEmpty || ignoreKeys.contains(key.toLowerCase())) {
      continue;
    }

    // Handle logical group params like "or" / "and"
    if (key.toLowerCase() == 'or' || key.toLowerCase() == 'and') {
      _parseLogicalGroup(value);
      continue;
    }

    // Regular filter param like "custom_name=neq.CARINSKI POSTOPEK"
    // Treat the LHS as the column name directly.
    _maybeAddColumn(key);
  }

  // Map column names -> translated labels (respect requested language)
  final List<String> translated = [];
  for (final name in filteredColumnNames) {
    final col = colByName[name];
    if (col == null) continue;
    translated.add(_labelFor(col));
  }

  return translated;
}
