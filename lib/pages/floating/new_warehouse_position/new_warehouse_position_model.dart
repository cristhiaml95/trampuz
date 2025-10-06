import '/flutter_flow/flutter_flow_util.dart';
import 'new_warehouse_position_widget.dart' show NewWarehousePositionWidget;
import 'package:flutter/material.dart';

class NewWarehousePositionModel
    extends FlutterFlowModel<NewWarehousePositionWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for warehousePositionTF widget.
  FocusNode? warehousePositionTFFocusNode;
  TextEditingController? warehousePositionTFTextController;
  String? Function(BuildContext, String?)?
      warehousePositionTFTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    warehousePositionTFFocusNode?.dispose();
    warehousePositionTFTextController?.dispose();
  }
}
