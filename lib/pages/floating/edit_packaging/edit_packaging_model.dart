import '/flutter_flow/flutter_flow_util.dart';
import 'edit_packaging_widget.dart' show EditPackagingWidget;
import 'package:flutter/material.dart';

class EditPackagingModel extends FlutterFlowModel<EditPackagingWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode1;
  TextEditingController? orderNoTFTextController1;
  String? Function(BuildContext, String?)? orderNoTFTextController1Validator;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode2;
  TextEditingController? orderNoTFTextController2;
  String? Function(BuildContext, String?)? orderNoTFTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    orderNoTFFocusNode1?.dispose();
    orderNoTFTextController1?.dispose();

    orderNoTFFocusNode2?.dispose();
    orderNoTFTextController2?.dispose();
  }
}
