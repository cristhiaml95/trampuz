import '/flutter_flow/flutter_flow_util.dart';
import 'new_manipulation_widget.dart' show NewManipulationWidget;
import 'package:flutter/material.dart';

class NewManipulationModel extends FlutterFlowModel<NewManipulationWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for manipulationTF widget.
  FocusNode? manipulationTFFocusNode;
  TextEditingController? manipulationTFTextController;
  String? Function(BuildContext, String?)?
      manipulationTFTextControllerValidator;
  String? _manipulationTFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'tsup8plf' /* Field is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    manipulationTFTextControllerValidator =
        _manipulationTFTextControllerValidator;
  }

  @override
  void dispose() {
    manipulationTFFocusNode?.dispose();
    manipulationTFTextController?.dispose();
  }
}
