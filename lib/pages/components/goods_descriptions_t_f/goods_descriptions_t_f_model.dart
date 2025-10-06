import '/flutter_flow/flutter_flow_util.dart';
import 'goods_descriptions_t_f_widget.dart' show GoodsDescriptionsTFWidget;
import 'package:flutter/material.dart';

class GoodsDescriptionsTFModel
    extends FlutterFlowModel<GoodsDescriptionsTFWidget> {
  ///  Local state fields for this component.

  bool editSave = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
