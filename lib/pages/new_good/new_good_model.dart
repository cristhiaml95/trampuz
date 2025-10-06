import '/flutter_flow/flutter_flow_util.dart';
import 'new_good_widget.dart' show NewGoodWidget;
import 'package:flutter/material.dart';

class NewGoodModel extends FlutterFlowModel<NewGoodWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for goodTF widget.
  FocusNode? goodTFFocusNode;
  TextEditingController? goodTFTextController;
  String? Function(BuildContext, String?)? goodTFTextControllerValidator;
  String? _goodTFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'sq2f2k0w' /* Field is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    goodTFTextControllerValidator = _goodTFTextControllerValidator;
  }

  @override
  void dispose() {
    goodTFFocusNode?.dispose();
    goodTFTextController?.dispose();
  }
}
