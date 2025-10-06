import '/flutter_flow/flutter_flow_util.dart';
import 'new_custom_widget.dart' show NewCustomWidget;
import 'package:flutter/material.dart';

class NewCustomModel extends FlutterFlowModel<NewCustomWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for customTF widget.
  FocusNode? customTFFocusNode;
  TextEditingController? customTFTextController;
  String? Function(BuildContext, String?)? customTFTextControllerValidator;
  String? _customTFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'u5vics5e' /* Field is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    customTFTextControllerValidator = _customTFTextControllerValidator;
  }

  @override
  void dispose() {
    customTFFocusNode?.dispose();
    customTFTextController?.dispose();
  }
}
