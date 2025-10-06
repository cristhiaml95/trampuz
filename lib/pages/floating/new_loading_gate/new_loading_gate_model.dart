import '/flutter_flow/flutter_flow_util.dart';
import 'new_loading_gate_widget.dart' show NewLoadingGateWidget;
import 'package:flutter/material.dart';

class NewLoadingGateModel extends FlutterFlowModel<NewLoadingGateWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for loadingGateTF widget.
  FocusNode? loadingGateTFFocusNode;
  TextEditingController? loadingGateTFTextController;
  String? Function(BuildContext, String?)? loadingGateTFTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    loadingGateTFFocusNode?.dispose();
    loadingGateTFTextController?.dispose();
  }
}
