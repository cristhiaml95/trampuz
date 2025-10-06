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
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '/flutter_flow/upload_data.dart';

Future getPDF(dynamic order) async {
  // ---------- Parse input ----------
  final Map<String, dynamic> data = order is String
      ? Map<String, dynamic>.from(jsonDecode(order) as Map)
      : Map<String, dynamic>.from(order as Map);

  // ---------- Helpers ----------
  T? _get<T>(List<String> keys) {
    for (final k in keys) {
      if (data.containsKey(k) && data[k] != null) {
        final v = data[k];
        if (v is T) return v;
        if (T == String && v is! String) return '$v' as T;
        if (T == num && v is num) return v as T;
      }
    }
    return null;
  }

  String _vs(List<String> keys, {String def = '-'}) {
    final v = _get<String>(keys);
    if (v == null) return def;
    final s = v.toString();
    return s.trim().isEmpty ? def : s;
  }

  bool _vb(List<String> keys) {
    final v = _get<dynamic>(keys);
    if (v == null) return false;
    if (v is bool) return v;
    if (v is num) return v != 0;
    final s = '$v'.toLowerCase();
    return s == 'true' || s == '1' || s == 'yes';
  }

  String _fmtDate(String? iso) {
    if (iso == null || iso.isEmpty) return '-';
    try {
      DateTime dt;
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(iso)) {
        dt = DateTime.parse('${iso}T00:00:00Z');
      } else {
        dt = DateTime.tryParse(iso) ?? DateTime.parse(iso.replaceAll(' ', 'T'));
      }
      return '${dt.year.toString().padLeft(4, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  String _fmtTime(String? t) {
    if (t == null || t.isEmpty) return '-';
    try {
      if (RegExp(r'^\d{2}:\d{2}(:\d{2})?([+-]\d{2}:\d{2})?$').hasMatch(t)) {
        final base = '2001-01-01T${t.replaceAll(' ', '')}';
        final dt = DateTime.tryParse(base) ?? DateTime.parse('${base}Z');
        return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      }
      final dt = DateTime.tryParse(t) ?? DateTime.parse(t.replaceAll(' ', 'T'));
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return t;
    }
  }

  String _fmtNumEU(dynamic v, {int decimals = 2}) {
    if (v == null) return '-';
    final n = v is num ? v : num.tryParse('$v');
    if (n == null) return '$v';
    final s = n.toStringAsFixed(decimals);
    final parts = s.split('.');
    final miles = parts[0];
    final buf = StringBuffer();
    for (int i = 0; i < miles.length; i++) {
      buf.write(miles[i]);
      final left = miles.length - i - 1;
      if (left > 0 && left % 3 == 0) buf.write('.');
    }
    return parts.length == 2 ? '${buf.toString()},${parts[1]}' : buf.toString();
  }

  String _moneyEU(dynamic v,
      {String sym = '€', bool symbolsOK = true, int decimals = 2}) {
    final s = _fmtNumEU(v, decimals: decimals);
    if (s == '-') return s;
    return symbolsOK ? '$s$sym' : '$s ${sym == '€' ? 'EUR' : 'USD'}';
  }

  Future<pw.Font?> _loadFont(String? url) async {
    if (url == null || url.isEmpty) return null;
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return pw.Font.ttf(res.bodyBytes.buffer.asByteData());
      }
    } catch (_) {}
    return null;
  }

  // ---------- Fonts ----------
  final regUrl = data['font_regular_url'] ??
      'https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSans/NotoSans-Regular.ttf';
  final boldUrl = data['font_bold_url'] ??
      'https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSans/NotoSans-Bold.ttf';

  final _reg = await _loadFont(regUrl);
  final _bold = await _loadFont(boldUrl);
  final bool symbolsOK = _reg != null && _bold != null;

  final fontReg = _reg ?? pw.Font.helvetica();
  final fontBold = _bold ?? pw.Font.helveticaBold();

  // ---------- Styles ----------
  final base = pw.TextStyle(font: fontReg, fontSize: 9);
  final label = pw.TextStyle(
      font: fontReg, fontSize: 7, color: PdfColors.grey700, letterSpacing: .2);
  final valueBig = pw.TextStyle(font: fontBold, fontSize: 11);
  final valueSmall = pw.TextStyle(font: fontBold, fontSize: 9);
  final title = pw.TextStyle(font: fontBold, fontSize: 22);
  final small = pw.TextStyle(font: fontReg, fontSize: 8);
  final tiny = pw.TextStyle(font: fontReg, fontSize: 7);
  final boxBorder = pw.Border.all(color: PdfColors.grey600, width: 0.6);

  String symText(String withSym, String fallback) =>
      symbolsOK ? withSym : fallback;

  // ---------- Mapping ----------
  final orderNr = _vs(['order_no', 'order_nr']);
  final orderStatus = _vs(['order_status']);
  final io = _vs(['flow', 'input_output', 'io']);
  final client = _vs(['client_name', 'client']);
  final warehouse = _vs(['warehouse_name', 'warehouse']);

  final createdAtISO = _vs(['created_at2', 'created_at']);
  final createdAtShow = _fmtDate(createdAtISO);
  final adminName = _vs(['admin_name', 'admin']);

  final etaDate = _fmtDate(_vs(['eta_date2', 'eta_date']));
  final announcedTime = _fmtTime(_vs(['eta_i2', 'eta_i']));
  final arrivalTime = _fmtTime(_vs(['arrival2', 'arrival']));
  final startTime = _fmtTime(_vs(['start2', 'start']));
  final stopTime = _fmtTime(_vs(['stop2', 'stop']));

  final inventoryStatus = _vs(['inv_status', 'inventory_status']);
  final precheck = _vb(['precheck', 'pre_check']);
  final check = _vb(['checked', 'check']);

  final responsible = _vs(['responsible_name', 'responsible']);
  final assistant1 = _vs(['assistant1_name', 'assistant1']);

  final ramp =
      _vs(['loading_gate_ramp', 'loading_gate', 'ramp', 'loading_sequence']);
  final warehousePos = _vs(['warehouse_position_name', 'warehouse_position']);
  final customName = _vs(['custom_name', 'custom']);
  final fmsRef = _vs(['fms_ref']);
  final loadRef = _vs(['load_ref_dvh', 'load_ref']);

  final improvement = _vs(['improvement']);
  final licensePlate = _vs(['licence_plate', 'license_plate']);
  final containerNo = _vs(['container_no']);
  final universalRef = _vs(['universal_ref_no', 'universal_ref_num']);

  final quantity = _vs(['quantity']);
  final palletPosition = _vs(['pallet_position']);
  final unit = _vs(['unit']);
  final good = _vs(['item', 'good']);
  final weight = _vs(['weight']);
  final packaging = _vs(['packaging_name', 'packaging']);

  final goodDesc = _vs(['opis_blaga', 'good_description']);
  final comment = _vs(['comment']);

  // Aduanas / costos
  final taric = _vs(['taric_code']);
  final customsPct = _vs(['customs_percentage']);
  final initCost = _vs(['init_cost']);
  final currencySel = _vs(['euro_or_dolar']);
  final exchRate = _vs(['exchange_rate_used']);
  final exchangedCost = _vs(['exchanged_cost']);
  final valuePerUnit = _vs(['value_per_unit']);
  final currentWarranty = _vs(['current_customs_warranty']);
  final internalRef = _vs(['internal_accounting', 'internal_ref_custom']);

  // currency symbol
  String currencySymbol = '€';
  final cur = currencySel.toLowerCase();
  if (cur.contains('usd') || cur.contains('\$') || cur.contains('dolar')) {
    currencySymbol = r'$';
  }

  // barcodes
  String barcodesText =
      _vs(['barcode_list', 'barcodes', 'received_barcodes'], def: '');
  final bc =
      data['barcode_list'] ?? data['barcodes'] ?? data['received_barcodes'];
  if (bc is List) {
    barcodesText = bc.map((e) => '$e').join(', ');
  }

  // ---------- UI helpers ----------
  const double vGapXS = 3;
  const double vGapS = 4;
  const double vGapM = 6;
  const double vGapL = 8;

  pw.Widget box(
    String lbl,
    String val, {
    double h = 34,
    pw.TextStyle? vStyle,
    pw.EdgeInsets? pad,
    PdfColor? fill,
    int maxLines = 1,
    bool dashed = false,
    pw.Alignment align = pw.Alignment.centerLeft,
  }) {
    final String safeVal = (val.trim().isEmpty) ? '-' : val;
    final bool dense = h <= 28;
    final effPad = pad ??
        pw.EdgeInsets.symmetric(horizontal: 6, vertical: dense ? 1.5 : 4);
    final effValueStyle = vStyle ?? (dense ? valueSmall : valueBig);
    final border = dashed
        ? pw.Border.all(
            color: PdfColors.grey500, width: 0.6, style: pw.BorderStyle.dashed)
        : boxBorder;

    return pw.Container(
      height: h,
      padding: effPad,
      decoration: pw.BoxDecoration(
        color: fill,
        border: border,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(lbl, style: label, maxLines: 1),
          pw.SizedBox(height: dense ? 1 : 2),
          pw.FittedBox(
            fit: pw.BoxFit.scaleDown,
            alignment: align,
            child: pw.Text(safeVal, style: effValueStyle, maxLines: maxLines),
          ),
        ],
      ),
    );
  }

  pw.Widget checkBox(bool val) => pw.Container(
        width: 13,
        height: 13,
        decoration: pw.BoxDecoration(
          border: boxBorder,
          color: val ? PdfColors.green200 : PdfColors.white,
        ),
        child: val
            ? pw.Stack(children: [
                pw.Positioned(
                  left: 2,
                  top: 7,
                  child: pw.Transform.rotate(
                    angle: -0.8,
                    child: pw.Container(
                        width: 6, height: 1.6, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 6,
                  top: 4,
                  child: pw.Transform.rotate(
                    angle: 0.8,
                    child: pw.Container(
                        width: 9, height: 1.6, color: PdfColors.black),
                  ),
                ),
              ])
            : null,
      );

  pw.Widget checkField(String lbl, bool val) => pw.Row(
        children: [
          checkBox(val),
          pw.SizedBox(width: 6),
          pw.Text(lbl, style: base, maxLines: 1),
        ],
      );

  pw.Widget gridRow(List<pw.Widget> children,
      {List<int>? flex, double gap = 6}) {
    final f = flex ?? List<int>.filled(children.length, 1);
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(children.length, (i) {
        return pw.Expanded(
          flex: f[i],
          child: pw.Padding(
            padding:
                pw.EdgeInsets.only(right: i == children.length - 1 ? 0 : gap),
            child: children[i],
          ),
        );
      }),
    );
  }

  // ---------- Document ----------
  final doc = pw.Document();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.fromLTRB(16, 14, 16, 16),
      build: (ctx) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // línea superior
            pw.Container(height: 2, color: PdfColors.green700),
            pw.SizedBox(height: vGapS),

            // Cabecera
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'začetna forma... narejena pri najavi',
                    style: small,
                    maxLines: 1,
                  ),
                ),
                pw.Container(
                  padding:
                      const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(border: boxBorder),
                  child: pw.Text('T L C - StockMaster', style: base),
                ),
              ],
            ),
            pw.SizedBox(height: vGapM),

            // ORDER NR y bloque info derecha
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Número de orden centrado visualmente
                pw.Expanded(
                  flex: 7,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: boxBorder,
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(3)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('ORDER NR:', style: label),
                        pw.SizedBox(height: 4),
                        pw.Text(orderNr, style: title, maxLines: 1),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(width: 8),
                // Bloque administrativo compacto
                pw.Expanded(
                  flex: 5,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      border: boxBorder,
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(3)),
                    ),
                    child: pw.Column(
                      children: [
                        gridRow([
                          box('creation date/h:', createdAtShow,
                              h: 24, vStyle: small, maxLines: 1),
                          box('ADMIN:', adminName,
                              h: 24, vStyle: base, maxLines: 1),
                        ], flex: [
                          1,
                          1
                        ]),
                        pw.SizedBox(height: vGapS),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            border: boxBorder,
                            color: PdfColors.grey200,
                            borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(3)),
                          ),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('TERMINAL',
                                  style: base.copyWith(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(etaDate, style: base),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: vGapXS),
                        pw.Text('estimated arrival', style: label),
                        pw.Row(children: [
                          pw.Text('Announced: $announcedTime', style: small),
                          pw.SizedBox(width: 10),
                          pw.Text('Arrival: $arrivalTime', style: small),
                        ]),
                        pw.Row(children: [
                          pw.Text('Start: $startTime', style: small),
                          pw.SizedBox(width: 10),
                          pw.Text('Stop: $stopTime', style: small),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: vGapL),

            // Línea: Estado / IO / Cliente / Almacén
            gridRow([
              box('Order status', orderStatus, h: 30),
              box('Input/Output', io, h: 30),
              box('Client', client, h: 30),
              box('Warehouse', warehouse, h: 30),
            ], flex: [
              2,
              1,
              3,
              2
            ]),

            pw.SizedBox(height: vGapS),

            // Línea: Aduana / Checks / Contabilidad
            gridRow([
              box('Custom', customName, h: 28, fill: PdfColors.grey200),
              pw.Container(
                height: 28,
                padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                decoration: pw.BoxDecoration(
                    border: boxBorder,
                    borderRadius:
                        const pw.BorderRadius.all(pw.Radius.circular(3))),
                child: pw.Row(
                  children: [
                    checkField('Pre-Check', precheck),
                    pw.SizedBox(width: 12),
                    checkField('Check', check),
                  ],
                ),
              ),
              box('Internal number - accounting', internalRef, h: 28),
            ], flex: [
              2,
              2,
              3
            ]),

            pw.SizedBox(height: vGapM),

            // Línea: Inventario / Rampa / Posición / Responsable / Asistente
            gridRow([
              box('Inventory status', inventoryStatus,
                  h: 26, vStyle: valueSmall),
              box('Ramp', ramp, h: 26, vStyle: valueSmall),
              box('Warehouse position', warehousePos,
                  h: 26, vStyle: valueSmall),
              box('Responsible', responsible, h: 26, vStyle: valueSmall),
              box('Assistant 1', assistant1, h: 26, vStyle: valueSmall),
            ], flex: [
              2,
              1,
              2,
              2,
              2
            ]),

            pw.SizedBox(height: vGapM),

            // Referencias (sin botón de documentos)
            gridRow([
              box('Improvement', improvement, h: 24, dashed: true),
              box('Licence plate nr.', licensePlate, h: 24, dashed: true),
              box('Container No.', containerNo, h: 24, dashed: true),
              box('Universal ref num', universalRef,
                  h: 24, fill: PdfColors.grey200),
              box('FMS ref', fmsRef, h: 24),
              box('Load ref/dvh', loadRef, h: 24),
            ], flex: [
              2,
              2,
              3,
              3,
              2,
              2
            ]),

            pw.SizedBox(height: vGapM),

            // Cantidades
            gridRow([
              box('Quantity',
                  _fmtNumEU(num.tryParse(quantity) ?? quantity, decimals: 0),
                  h: 26),
              box('Pallet position', palletPosition, h: 26),
              box('Unit', unit, h: 26),
              box('Good', good, h: 26),
              box('Weight', _fmtNumEU(num.tryParse(weight) ?? weight), h: 26),
              box('Packaging', packaging, h: 26),
            ]),

            pw.SizedBox(height: vGapM),

            // Descripción y Comentario
            gridRow([
              box('Good description', goodDesc,
                  h: 38, vStyle: base, maxLines: 2, dashed: true),
              pw.SizedBox(width: 0),
              box('COMMENT', comment,
                  h: 38, vStyle: base, maxLines: 2, dashed: true),
            ], flex: [
              3,
              0,
              3
            ]),

            pw.SizedBox(height: vGapM),

            // Barcodes
            pw.Container(
              height: 54,
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                    color: PdfColors.grey600,
                    width: 0.6,
                    style: pw.BorderStyle.dashed),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Barcodes', style: label),
                  pw.SizedBox(height: vGapXS),
                  pw.Text(barcodesText, style: base, maxLines: 3),
                ],
              ),
            ),

            pw.SizedBox(height: vGapL),

            // Banda INFO + recuadro valor
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 6, horizontal: 8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.green100,
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(3)),
                      border: boxBorder,
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('INFO CUSTOMS WAREHOUSE',
                            style:
                                base.copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Row(children: [
                          pw.Text('Exchange rate: ', style: base),
                          pw.Text(_fmtNumEU(num.tryParse(exchRate) ?? exchRate),
                              style: base.copyWith(
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 16),
                          pw.Text('Date exchange: ', style: base),
                          pw.Text(
                              _fmtDate(_vs(
                                  ['date_exchange', 'eta_date2', 'eta_date'])),
                              style: base),
                        ]),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.amber100,
                    borderRadius:
                        const pw.BorderRadius.all(pw.Radius.circular(3)),
                    border: boxBorder,
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('free warranty:', style: small),
                      pw.Text(
                        _moneyEU(num.tryParse(exchangedCost) ?? exchangedCost,
                            sym: currencySymbol, symbolsOK: symbolsOK),
                        style: title.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: vGapM),

            // Tabla aduanas
            pw.Container(
              decoration: pw.BoxDecoration(
                border: boxBorder,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
              ),
              child: pw.Column(
                children: [
                  pw.Container(
                    color: PdfColors.grey200,
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 6),
                    child: pw.Row(children: [
                      pw.Expanded(
                          flex: 10, child: pw.Text('In/Out', style: tiny)),
                      pw.Expanded(
                          flex: 10, child: pw.Text('Quantit.', style: tiny)),
                      pw.Expanded(
                          flex: 10, child: pw.Text('Weight', style: tiny)),
                      pw.Expanded(
                          flex: 14, child: pw.Text('Taric code', style: tiny)),
                      pw.Expanded(
                          flex: 10, child: pw.Text('Customs %', style: tiny)),
                      pw.Expanded(
                          flex: 12, child: pw.Text('Costs', style: tiny)),
                      pw.Expanded(
                          flex: 12, child: pw.Text('Currency', style: tiny)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text(
                              symText('Total value €', 'Total value EUR'),
                              style: tiny)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text('Value per unit', style: tiny)),
                      pw.Expanded(
                          flex: 16,
                          child: pw.Text('Burdened\nguarantee',
                              style: tiny, maxLines: 2)),
                      pw.Expanded(
                          flex: 24,
                          child: pw.Text('Internal reference number - custom',
                              style: tiny, maxLines: 2)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text('Date document in/out',
                              style: tiny, maxLines: 2)),
                    ]),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 6),
                    child: pw.Row(children: [
                      pw.Expanded(
                          flex: 10, child: pw.Text(orderNr, style: base)),
                      pw.Expanded(
                          flex: 10,
                          child: pw.Text(
                              _fmtNumEU(num.tryParse(quantity) ?? quantity,
                                  decimals: 0),
                              style: base)),
                      pw.Expanded(
                          flex: 10,
                          child: pw.Text(
                              _fmtNumEU(num.tryParse(weight) ?? weight),
                              style: base)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text(taric.trim().isEmpty ? '/' : taric,
                              style: base)),
                      pw.Expanded(
                          flex: 10,
                          child: pw.Text(
                              '${_fmtNumEU(num.tryParse(customsPct) ?? customsPct)}%',
                              style: base)),
                      pw.Expanded(
                          flex: 12,
                          child: pw.Text(
                              '${_fmtNumEU(num.tryParse(initCost) ?? initCost)} ${currencySel.isEmpty ? '/' : currencySel}',
                              style: base)),
                      pw.Expanded(
                          flex: 12,
                          child: pw.Text(
                              currencySel.isEmpty
                                  ? '/'
                                  : currencySel.toUpperCase(),
                              style: base)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text(
                              _moneyEU(
                                  num.tryParse(exchangedCost) ?? exchangedCost,
                                  sym: '€',
                                  symbolsOK: symbolsOK),
                              style: base)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text(
                              _fmtNumEU(
                                  num.tryParse(valuePerUnit) ?? valuePerUnit),
                              style: base)),
                      pw.Expanded(
                          flex: 16,
                          child: pw.Text(
                              _moneyEU(
                                  num.tryParse(currentWarranty) ??
                                      currentWarranty,
                                  sym: '€',
                                  symbolsOK: symbolsOK),
                              style: base)),
                      pw.Expanded(
                          flex: 24, child: pw.Text(internalRef, style: base)),
                      pw.Expanded(
                          flex: 14,
                          child: pw.Text(
                              _fmtDate(_vs(
                                  ['date_document', 'eta_date2', 'eta_date'])),
                              style: base)),
                    ]),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: vGapM),
            pw.Text(
              'Document created on ${_fmtDate(DateTime.now().toIso8601String())} at ${_fmtTime(DateTime.now().toIso8601String())}',
              style: small,
            ),
          ],
        );
      },
    ),
  );

  final bytes = await doc.save();
  final fileName =
      'order_${orderNr.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : orderNr}.pdf';

  if (kIsWeb) {
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }

  return FFUploadedFile(name: fileName, bytes: Uint8List.fromList(bytes));
}
