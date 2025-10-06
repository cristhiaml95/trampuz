import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'details_copy_widget.dart' show DetailsCopyWidget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DetailsCopyModel extends FlutterFlowModel<DetailsCopyWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (detailsView)] action in detailsCopy widget.
  ApiCallResponse? detailsViewApiOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in Icon widget.
  ApiCallResponse? refreshAssociatedOrderOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in Icon widget.
  ApiCallResponse? refreshRowOP;
  // State field(s) for barcodeDD widget.
  String? barcodeDDValue;
  FormFieldController<String>? barcodeDDValueController;
  bool requestCompleted = false;
  String? requestLastUniqueKey;

  @override
  void initState(BuildContext context) {
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
