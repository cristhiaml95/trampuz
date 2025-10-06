import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_reports_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/index.dart';
import 'reports_widget.dart' show ReportsWidget;
import 'package:flutter/material.dart';

class ReportsModel extends FlutterFlowModel<ReportsWidget> {
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

  int selectedIndex = 0;

  bool orderNoB = false;

  bool clientB = false;

  bool flowB = false;

  bool invStatusB = false;

  bool warehouseB = false;

  bool orderStatusB = false;

  bool licenceB = false;

  bool improvementB = false;

  bool palletPositionB = false;

  bool universalRefNumB = false;

  bool fmsRefB = false;

  bool loadRefDvhB = false;

  bool customB = false;

  bool goodB = false;

  bool goodDescriptionB = false;

  bool assistant1B = false;

  bool assistant2B = false;

  bool assistant3B = false;

  bool assistant4B = false;

  bool assistant5B = false;

  bool assistant6B = false;

  bool adminB = false;

  bool barcodeB = false;

  bool intCustomB = false;

  bool containerNoB = false;

  bool rowPerPageB = true;

  int counter = 0;

  DateTime? dateArrival1;

  DateTime? dateArrival2;

  bool dateArrivalB = false;

  bool quantityB = false;

  bool packagingB = false;

  bool weightB = false;

  bool manipulationB = false;

  bool loadingTypeB = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (packaging)] action in reports widget.
  ApiCallResponse? packagingApiOP;
  // Stores action output result for [Backend Call - API (manipulation)] action in reports widget.
  ApiCallResponse? manipulationApiOP;
  // Model for lightMode component.
  late LightModeModel lightModeModel;
  // Model for userDetails component.
  late UserDetailsModel userDetailsModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRowOP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRowOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRow2OP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRow2OP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse2 widget.
  ApiCallResponse? refreshRowOP2;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse2 widget.
  OrderLevelRow? insertedRowOP1;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse2 widget.
  ApiCallResponse? refreshRow2OP2;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse2 widget.
  OrderLevelRow? insertedRow2OP1;
  // Model for filtersPopUp-Reports component.
  late FiltersPopUpReportsModel filtersPopUpReportsModel;

  @override
  void initState(BuildContext context) {
    lightModeModel = createModel(context, () => LightModeModel());
    userDetailsModel = createModel(context, () => UserDetailsModel());
    filtersPopUpReportsModel =
        createModel(context, () => FiltersPopUpReportsModel());
  }

  @override
  void dispose() {
    lightModeModel.dispose();
    userDetailsModel.dispose();
    tabBarController?.dispose();
    filtersPopUpReportsModel.dispose();
  }
}
