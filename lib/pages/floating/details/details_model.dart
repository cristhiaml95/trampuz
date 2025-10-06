import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'details_widget.dart' show DetailsWidget;
import 'package:flutter/material.dart';

class DetailsModel extends FlutterFlowModel<DetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in Icon widget.
  ApiCallResponse? refreshAssociatedOrderOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in Icon widget.
  ApiCallResponse? refreshRowOP;
  // State field(s) for barcodeDD widget.
  String? barcodeDDValue;
  FormFieldController<String>? barcodeDDValueController;
  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  bool requestCompleted = false;
  String? requestLastUniqueKey;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future detailsActionB(BuildContext context) async {
    ApiCallResponse? detailsViewApiOP;

    detailsViewApiOP = await TablesGroup.detailsViewCall.call(
      orderId: widget!.orderId,
      userToken: currentJwtToken,
    );

    if ((detailsViewApiOP.succeeded ?? true)) {
      FFAppState().detailsJsonList =
          (detailsViewApiOP.jsonBody ?? '').toList().cast<dynamic>();
    }
  }

  /// Additional helper methods.
  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted1;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

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
