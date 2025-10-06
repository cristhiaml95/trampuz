import '/flutter_flow/flutter_flow_util.dart';
import 'new_warehouse_widget.dart' show NewWarehouseWidget;
import 'package:flutter/material.dart';

class NewWarehouseModel extends FlutterFlowModel<NewWarehouseWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for warehouseTF widget.
  FocusNode? warehouseTFFocusNode;
  TextEditingController? warehouseTFTextController;
  String? Function(BuildContext, String?)? warehouseTFTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    warehouseTFFocusNode?.dispose();
    warehouseTFTextController?.dispose();
  }
}
