import '/flutter_flow/flutter_flow_util.dart';
import 'new_threshold_widget.dart' show NewThresholdWidget;
import 'package:flutter/material.dart';

class NewThresholdModel extends FlutterFlowModel<NewThresholdWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for thresholdTF widget.
  FocusNode? thresholdTFFocusNode;
  TextEditingController? thresholdTFTextController;
  String? Function(BuildContext, String?)? thresholdTFTextControllerValidator;
  String? _thresholdTFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'b5ym8ymx' /* Field is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    thresholdTFTextControllerValidator = _thresholdTFTextControllerValidator;
  }

  @override
  void dispose() {
    thresholdTFFocusNode?.dispose();
    thresholdTFTextController?.dispose();
  }
}
