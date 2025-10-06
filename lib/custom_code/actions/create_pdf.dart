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
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../auth/supabase_auth/auth_util.dart';
import '../../flutter_flow/upload_data.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future createPdf(
  String orderNo,
  String clientName,
  String warehouseName,
  String flow,
  String licence,
  String container,
  String item,
  String opisBlaga,
  String palletPosition,
  String weight,
  String universalRef,
  String fmsRef,
  String loadRefDvh,
  String customName,
  String damageMark,
  String comment,
  String typeUnUpload,
  String responsibleName,
  String assistant1Name,
  String otherManipulation,
  String arrivalDate,
  String quantity,
  String warehousePosition,
) async {
  // Add your function code here!
  final pdf = pw.Document();
  // Carga la fuente personalizada
  final customFont = await loadCustomFontFromUrl(
      'https://xvpkpgmwllqgytdtlnts.supabase.co/storage/v1/object/sign/assets/Roboto-Regular.ttf?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhc3NldHMvUm9ib3RvLVJlZ3VsYXIudHRmIiwiaWF0IjoxNzA5NzIxOTUwLCJleHAiOjIwMjUwODE5NTB9.qfsJ30LQGGuIjGGKiL6gyl8swxphp0okrYHIYXmqiAg&t=2024-03-06T10%3A45%3A50.923Z');
  final customFontBold = await loadCustomFontFromUrl(
      'https://xvpkpgmwllqgytdtlnts.supabase.co/storage/v1/object/sign/assets/Roboto-Bold.ttf?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhc3NldHMvUm9ib3RvLUJvbGQudHRmIiwiaWF0IjoxNzA5NzIxOTI4LCJleHAiOjIwMjUwODE5Mjh9.pjWZuSUqDRpNWBPBoCIrTLQD1EYkHxZNFnv8c-3orTk&t=2024-03-06T10%3A45%3A28.747Z');
  final logoImage = await networkImage(
      'https://xvpkpgmwllqgytdtlnts.supabase.co/storage/v1/object/sign/assets/logo.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yMDUxOWI3NS1jMTFiLTQ0M2UtOGNkNi1lNDVlNTNhZTE4NGYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhc3NldHMvbG9nby5wbmciLCJpYXQiOjE3NTk3NTg5NjEsImV4cCI6MjA3NTExODk2MX0.QhSNqxkea8IL3ANQ4UV_sl7JRn6xxM-V5cfmzxMcrJM');
  final pw.Font helvetica = pw.Font.helvetica();
  final pw.Font helveticaBold = pw.Font.helveticaBold();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Image(logoImage, width: 500, height: 250)),
            pw.Divider(color: PdfColors.white, thickness: 12, height: 28),
            pw.Divider(color: PdfColors.red, thickness: 3, height: 20),
            pw.Divider(color: PdfColors.white, thickness: 12, height: 28),
            pw.Center(
                child: _buildText(
                    "ŠT. NAR. ", orderNo, customFont, customFontBold, 28, 500)),
            pw.Divider(color: PdfColors.white, thickness: 12, height: 28),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Expanded(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    _buildText("SKLAD. ", warehouseName, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("STRANKA ", clientName, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText(
                        "In/Out ", flow, customFont, customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("REG. ŠTEVILKA ", licence, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("ŠT. KONTEJNER ", container, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText(
                        "BLAGO ", item, customFont, customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("OPIS BLAGA ", opisBlaga, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("KOLIČINA ", quantity, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("PAL.MESTA ", palletPosition, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("TEŽA/KG ", weight, customFont, customFontBold,
                        12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("Položaj skladišča ", warehousePosition,
                        customFont, customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                  ])),
              pw.Expanded(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    _buildText("REF.1 ", universalRef, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText(
                        "REF.2 ", fmsRef, customFont, customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("REF.3 ", loadRefDvh, customFont, customFontBold,
                        12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("CAR.POST. ", customName, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 10),
                    _buildText("KOMENTAR RAZNO ", comment, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("DELO Z ", typeUnUpload, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("ODG.SKL. ", responsibleName, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("SKLADIŠČNIK 1 ", assistant1Name, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("MANIPULACIJA ", otherManipulation, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                    _buildText("DATUM ", arrivalDate, customFont,
                        customFontBold, 12, 240),
                    pw.SizedBox(height: 10),
                  ])),
            ])
            // Añade más Widgets según sea necesario
          ],
        );
      },
    ),
  );

  // Guardar el documento PDF
  final output = await pdf.save();
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => output);
}

pw.Widget _buildText(String title, String value, pw.Font fontRegular,
    pw.Font fontBold, double fontSize, double maxWidth) {
  return pw.Container(
    width: maxWidth, // Define un ancho máximo para el contenedor del texto
    child: pw.RichText(
      text: pw.TextSpan(
        text: title + ": ",
        style: pw.TextStyle(font: fontBold, fontSize: fontSize),
        children: [
          pw.TextSpan(
            text: value,
            style: pw.TextStyle(font: fontRegular, fontSize: fontSize),
          ),
        ],
      ),
    ),
  );
}

Future<pw.Font> loadCustomFontFromUrl(String url) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return pw.Font.ttf(response.bodyBytes.buffer.asByteData());
  } else {
    throw Exception('Failed to load font from URL');
  }
}
