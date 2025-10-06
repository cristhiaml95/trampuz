import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_order_warehouse_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/index.dart';
import 'order_warehouse_widget.dart' show OrderWarehouseWidget;
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderWarehouseModel extends FlutterFlowModel<OrderWarehouseWidget> {
  ///  Local state fields for this page.

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

  String? selectedIndexID;

  int count = 0;

  String choiceChipSelected = 'all';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - quantityBalanceAction] action in order_warehouse widget.
  int? quantityOP;
  // Model for lightMode component.
  late LightModeModel lightModeModel;
  // Model for userDetails component.
  late UserDetailsModel userDetailsModel;
  // State field(s) for stateGridDD widget.
  String? stateGridDDValue;
  FormFieldController<String>? stateGridDDValueController;
  // Stores action output result for [Custom Action - updateCurrentGridState] action in stateGridDD widget.
  List<dynamic>? updateGrid;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRowOP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRowOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRow2OP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRow2OP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRowOPCopy;
  // Model for filtersPopUp-OrderWarehouse component.
  late FiltersPopUpOrderWarehouseModel filtersPopUpOrderWarehouseModel;
  // State field(s) for onlineSW widget.
  bool? onlineSWValue;
  // State field(s) for rowsQuantityTF widget.
  FocusNode? rowsQuantityTFFocusNode;
  TextEditingController? rowsQuantityTFTextController;
  String? Function(BuildContext, String?)?
      rowsQuantityTFTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - updateAvailability] action in ChoiceChips widget.
  String? newOrderWarehouseApiV;

  @override
  void initState(BuildContext context) {
    lightModeModel = createModel(context, () => LightModeModel());
    userDetailsModel = createModel(context, () => UserDetailsModel());
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
    filtersPopUpOrderWarehouseModel =
        createModel(context, () => FiltersPopUpOrderWarehouseModel());
  }

  @override
  void dispose() {
    lightModeModel.dispose();
    userDetailsModel.dispose();
    filtersPopUpOrderWarehouseModel.dispose();
    rowsQuantityTFFocusNode?.dispose();
    rowsQuantityTFTextController?.dispose();
  }
}
