import '/flutter_flow/flutter_flow_util.dart';
import 'new_packaging_widget.dart' show NewPackagingWidget;
import 'package:flutter/material.dart';

class NewPackagingModel extends FlutterFlowModel<NewPackagingWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for packagingTF widget.
  FocusNode? packagingTFFocusNode;
  TextEditingController? packagingTFTextController;
  String? Function(BuildContext, String?)? packagingTFTextControllerValidator;
  String? _packagingTFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'pmyl2hn9' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for abbreviationTF widget.
  FocusNode? abbreviationTFFocusNode;
  TextEditingController? abbreviationTFTextController;
  String? Function(BuildContext, String?)?
      abbreviationTFTextControllerValidator;

  @override
  void initState(BuildContext context) {
    packagingTFTextControllerValidator = _packagingTFTextControllerValidator;
  }

  @override
  void dispose() {
    packagingTFFocusNode?.dispose();
    packagingTFTextController?.dispose();

    abbreviationTFFocusNode?.dispose();
    abbreviationTFTextController?.dispose();
  }
}
