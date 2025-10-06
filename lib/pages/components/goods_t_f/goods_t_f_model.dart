import '/flutter_flow/flutter_flow_util.dart';
import 'goods_t_f_widget.dart' show GoodsTFWidget;
import 'package:flutter/material.dart';

class GoodsTFModel extends FlutterFlowModel<GoodsTFWidget> {
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
