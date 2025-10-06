import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_warehouse2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/index.dart';
import 'warehouse2_widget.dart' show Warehouse2Widget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class Warehouse2Model extends FlutterFlowModel<Warehouse2Widget> {
  ///  Local state fields for this page.

  String? selectedIndexID;

  List<FixedColumnsStruct> fixedColumns = [];
  void addToFixedColumns(FixedColumnsStruct item) => fixedColumns.add(item);
  void removeFromFixedColumns(FixedColumnsStruct item) =>
      fixedColumns.remove(item);
  void removeAtIndexFromFixedColumns(int index) => fixedColumns.removeAt(index);
  void insertAtIndexInFixedColumns(int index, FixedColumnsStruct item) =>
      fixedColumns.insert(index, item);
  void updateFixedColumnsAtIndex(
          int index, Function(FixedColumnsStruct) updateFn) =>
      fixedColumns[index] = updateFn(fixedColumns[index]);

  bool rowPerPageB = true;

  ///  State fields for stateful widgets in this page.

  // Model for lightMode component.
  late LightModeModel lightModeModel;
  // Model for userDetails component.
  late UserDetailsModel userDetailsModel;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRowOP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRowOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRow2OP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRow2OP;
  // Model for filtersPopUp-Warehouse2 component.
  late FiltersPopUpWarehouse2Model filtersPopUpWarehouse2Model;

  @override
  void initState(BuildContext context) {
    lightModeModel = createModel(context, () => LightModeModel());
    userDetailsModel = createModel(context, () => UserDetailsModel());
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
    filtersPopUpWarehouse2Model =
        createModel(context, () => FiltersPopUpWarehouse2Model());
  }

  @override
  void dispose() {
    lightModeModel.dispose();
    userDetailsModel.dispose();
    filtersPopUpWarehouse2Model.dispose();
  }
}
