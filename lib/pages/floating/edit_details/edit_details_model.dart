import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_details_widget.dart' show EditDetailsWidget;
import 'package:flutter/material.dart';

class EditDetailsModel extends FlutterFlowModel<EditDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for goodDD widget.
  String? goodDDValue;
  FormFieldController<String>? goodDDValueController;
  // State field(s) for descriptionDD widget.
  String? descriptionDDValue;
  FormFieldController<String>? descriptionDDValueController;
  // State field(s) for packagingDD widget.
  String? packagingDDValue;
  FormFieldController<String>? packagingDDValueController;
  // State field(s) for warehpusePositionDD widget.
  String? warehpusePositionDDValue;
  FormFieldController<String>? warehpusePositionDDValueController;
  // State field(s) for barcodeTF widget.
  FocusNode? barcodeTFFocusNode;
  TextEditingController? barcodeTFTextController;
  String? Function(BuildContext, String?)? barcodeTFTextControllerValidator;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? sureQueryOP;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    barcodeTFFocusNode?.dispose();
    barcodeTFTextController?.dispose();
  }
}
