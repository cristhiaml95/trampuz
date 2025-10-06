import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_calendar_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/index.dart';
import 'calendar_widget.dart' show CalendarWidget;
import 'package:flutter/material.dart';

class CalendarModel extends FlutterFlowModel<CalendarWidget> {
  ///  Local state fields for this page.

  bool warehouseB = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (warehouse)] action in calendar widget.
  ApiCallResponse? warehouseApiCallOP;
  // Model for lightMode component.
  late LightModeModel lightModeModel;
  // Model for userDetails component.
  late UserDetailsModel userDetailsModel;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for warehouseDD widget.
  String? warehouseDDValue;
  FormFieldController<String>? warehouseDDValueController;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRowOP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRowOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in PlutoGridorderwarehouse widget.
  ApiCallResponse? refreshRow2OP;
  // Stores action output result for [Backend Call - Insert Row] action in PlutoGridorderwarehouse widget.
  OrderLevelRow? insertedRow2OP;
  // Model for filtersPopUp-Calendar component.
  late FiltersPopUpCalendarModel filtersPopUpCalendarModel;

  @override
  void initState(BuildContext context) {
    lightModeModel = createModel(context, () => LightModeModel());
    userDetailsModel = createModel(context, () => UserDetailsModel());
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    filtersPopUpCalendarModel =
        createModel(context, () => FiltersPopUpCalendarModel());
  }

  @override
  void dispose() {
    lightModeModel.dispose();
    userDetailsModel.dispose();
    filtersPopUpCalendarModel.dispose();
  }
}
