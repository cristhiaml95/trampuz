import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'filters_pop_up_calendar_widget.dart' show FiltersPopUpCalendarWidget;
import 'package:flutter/material.dart';

class FiltersPopUpCalendarModel
    extends FlutterFlowModel<FiltersPopUpCalendarWidget> {
  ///  Local state fields for this component.

  double filtersWidth = 240.0;

  String? barcodeFilteres;

  UsersRow? users;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in filtersPopUp-Calendar widget.
  List<UsersRow>? usersOP;
  // State field(s) for warehouseDD widget.
  String? warehouseDDValue;
  FormFieldController<String>? warehouseDDValueController;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode;
  TextEditingController? orderNoTFTextController;
  String? Function(BuildContext, String?)? orderNoTFTextControllerValidator;
  // State field(s) for flowDD widget.
  String? flowDDValue;
  FormFieldController<String>? flowDDValueController;
  // State field(s) for invStatusDD widget.
  String? invStatusDDValue;
  FormFieldController<String>? invStatusDDValueController;
  // State field(s) for orderStatusDD widget.
  String? orderStatusDDValue;
  FormFieldController<String>? orderStatusDDValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for improvementDD widget.
  String? improvementDDValue;
  FormFieldController<String>? improvementDDValueController;
  // State field(s) for adminDD widget.
  String? adminDDValue;
  FormFieldController<String>? adminDDValueController;
  // State field(s) for licenceTF widget.
  FocusNode? licenceTFFocusNode;
  TextEditingController? licenceTFTextController;
  String? Function(BuildContext, String?)? licenceTFTextControllerValidator;
  // Stores action output result for [Custom Action - quantityBalanceAction] action in Button widget.
  int? quantityOP;
  // Stores action output result for [Custom Action - quantityBalanceAction] action in Button widget.
  int? quantityOP2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    orderNoTFFocusNode?.dispose();
    orderNoTFTextController?.dispose();

    licenceTFFocusNode?.dispose();
    licenceTFTextController?.dispose();
  }

  /// Action blocks.
  Future filterAction(BuildContext context) async {
    List<String>? filteredColumns;

    FFAppState().calendarApiV = '';
    FFAppState().calendarApiV = (String var1) {
      return var1 + '&limit=50&is_deleted=eq.false';
    }(FFAppState().calendarApiV);
    if (orderNoTFTextController.text != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&order_no=ilike.*' + var2 + '*';
      }(FFAppState().calendarApiV, orderNoTFTextController.text);
    }
    if (invStatusDDValue != null && invStatusDDValue != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&inv_status=eq.' + var2;
      }(FFAppState().calendarApiV, invStatusDDValue!);
    }
    if (FFAppState().clientApiB) {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&client=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, FFAppState().clientApiId);
    }
    if (warehouseDDValue != null && warehouseDDValue != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&warehouse_name=eq.' + var2;
      }(FFAppState().calendarApiV, warehouseDDValue!);
    }
    if (orderStatusDDValue != null && orderStatusDDValue != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&order_status=eq.' + var2;
      }(FFAppState().calendarApiV, orderStatusDDValue!);
    }
    if (flowDDValue != null && flowDDValue != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&flow=eq.' + var2;
      }(FFAppState().calendarApiV, flowDDValue!);
    }
    if (licenceTFTextController.text != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&licence_plate=ilike.*' + var2 + '*';
      }(FFAppState().calendarApiV, licenceTFTextController.text);
    }
    if (improvementDDValue != null && improvementDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().calendarApiV, improvementDDValue!);
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().calendarApiV, improvementDDValue!);
    }
    if (FFAppState().goodDescriptionApiB) {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&good_description=eq.' + var2;
      }(FFAppState().calendarApiV, FFAppState().goodDescriptionApiId);
    }
    if (adminDDValue != null && adminDDValue != '') {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&admin=eq.' + var2;
      }(FFAppState().calendarApiV, adminDDValue!);
    }
    if (datePicked1 != null) {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&eta_date=gte.' + var2;
      }(
          FFAppState().calendarApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked1,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (datePicked2 != null) {
      FFAppState().calendarApiV = (String var1, String var2) {
        return var1 + '&eta_date=lte.' + var2;
      }(
          FFAppState().calendarApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked2,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    filteredColumns = await actions.getFilteredColumnNamesFromUrl(
      FFAppState().calendarApiV,
    );
    FFAppState().calendarFilterColumns =
        filteredColumns.toList().cast<String>();
    FFAppState().update(() {});
  }
}
