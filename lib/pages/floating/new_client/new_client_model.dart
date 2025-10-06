import '/flutter_flow/flutter_flow_util.dart';
import 'new_client_widget.dart' show NewClientWidget;
import 'package:flutter/material.dart';

class NewClientModel extends FlutterFlowModel<NewClientWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for clientTF widget.
  FocusNode? clientTFFocusNode;
  TextEditingController? clientTFTextController;
  String? Function(BuildContext, String?)? clientTFTextControllerValidator;
  String? _clientTFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'h1eq3lya' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for addressTF widget.
  FocusNode? addressTFFocusNode;
  TextEditingController? addressTFTextController;
  String? Function(BuildContext, String?)? addressTFTextControllerValidator;
  // State field(s) for cityTF widget.
  FocusNode? cityTFFocusNode;
  TextEditingController? cityTFTextController;
  String? Function(BuildContext, String?)? cityTFTextControllerValidator;
  // State field(s) for countryTF widget.
  FocusNode? countryTFFocusNode;
  TextEditingController? countryTFTextController;
  String? Function(BuildContext, String?)? countryTFTextControllerValidator;
  // State field(s) for nameAissTF widget.
  FocusNode? nameAissTFFocusNode;
  TextEditingController? nameAissTFTextController;
  String? Function(BuildContext, String?)? nameAissTFTextControllerValidator;
  // State field(s) for vatNoTF widget.
  FocusNode? vatNoTFFocusNode;
  TextEditingController? vatNoTFTextController;
  String? Function(BuildContext, String?)? vatNoTFTextControllerValidator;

  @override
  void initState(BuildContext context) {
    clientTFTextControllerValidator = _clientTFTextControllerValidator;
  }

  @override
  void dispose() {
    clientTFFocusNode?.dispose();
    clientTFTextController?.dispose();

    addressTFFocusNode?.dispose();
    addressTFTextController?.dispose();

    cityTFFocusNode?.dispose();
    cityTFTextController?.dispose();

    countryTFFocusNode?.dispose();
    countryTFTextController?.dispose();

    nameAissTFFocusNode?.dispose();
    nameAissTFTextController?.dispose();

    vatNoTFFocusNode?.dispose();
    vatNoTFTextController?.dispose();
  }
}
