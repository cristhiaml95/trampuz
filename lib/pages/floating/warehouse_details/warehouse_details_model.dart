import '/flutter_flow/flutter_flow_util.dart';
import 'warehouse_details_widget.dart' show WarehouseDetailsWidget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class WarehouseDetailsModel extends FlutterFlowModel<WarehouseDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
