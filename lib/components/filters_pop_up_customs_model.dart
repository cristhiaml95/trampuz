import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'filters_pop_up_customs_widget.dart' show FiltersPopUpCustomsWidget;
import 'package:flutter/material.dart';

class FiltersPopUpCustomsModel
    extends FlutterFlowModel<FiltersPopUpCustomsWidget> {
  ///  Local state fields for this component.

  double filtersWidth = 240.0;

  String? barcodeFilteres;

  UsersRow? users;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in filtersPopUp-Customs widget.
  List<UsersRow>? usersOP;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode;
  TextEditingController? orderNoTFTextController;
  String? Function(BuildContext, String?)? orderNoTFTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for flowDD widget.
  String? flowDDValue;
  FormFieldController<String>? flowDDValueController;
  // State field(s) for licenceTF widget.
  FocusNode? licenceTFFocusNode;
  TextEditingController? licenceTFTextController;
  String? Function(BuildContext, String?)? licenceTFTextControllerValidator;
  // State field(s) for improvementDD widget.
  String? improvementDDValue;
  FormFieldController<String>? improvementDDValueController;
  // State field(s) for containerNoTF widget.
  FocusNode? containerNoTFFocusNode;
  TextEditingController? containerNoTFTextController;
  String? Function(BuildContext, String?)? containerNoTFTextControllerValidator;
  // State field(s) for FMSrefTF widget.
  FocusNode? fMSrefTFFocusNode;
  TextEditingController? fMSrefTFTextController;
  String? Function(BuildContext, String?)? fMSrefTFTextControllerValidator;
  // State field(s) for loadRefDvhTF widget.
  FocusNode? loadRefDvhTFFocusNode;
  TextEditingController? loadRefDvhTFTextController;
  String? Function(BuildContext, String?)? loadRefDvhTFTextControllerValidator;
  // State field(s) for UniversalRefNumTF widget.
  FocusNode? universalRefNumTFFocusNode;
  TextEditingController? universalRefNumTFTextController;
  String? Function(BuildContext, String?)?
      universalRefNumTFTextControllerValidator;
  // State field(s) for packagingDD widget.
  String? packagingDDValue;
  FormFieldController<String>? packagingDDValueController;
  // State field(s) for warehouseDD widget.
  String? warehouseDDValue;
  FormFieldController<String>? warehouseDDValueController;
  // State field(s) for intCustomTF widget.
  FocusNode? intCustomTFFocusNode;
  TextEditingController? intCustomTFTextController;
  String? Function(BuildContext, String?)? intCustomTFTextControllerValidator;
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

    containerNoTFFocusNode?.dispose();
    containerNoTFTextController?.dispose();

    fMSrefTFFocusNode?.dispose();
    fMSrefTFTextController?.dispose();

    loadRefDvhTFFocusNode?.dispose();
    loadRefDvhTFTextController?.dispose();

    universalRefNumTFFocusNode?.dispose();
    universalRefNumTFTextController?.dispose();

    intCustomTFFocusNode?.dispose();
    intCustomTFTextController?.dispose();
  }

  /// Action blocks.
  Future filterAction(BuildContext context) async {
    List<String>? filteredColumns;

    FFAppState().customsApiV = '';
    FFAppState().customsApiV = (String var1) {
      return var1 +
          '&order=crono.desc.nullslast&availability=neq.consumed&is_deleted=eq.false&limit=50&custom=eq.756a1fad-8f1e-43d4-ad2a-00ffdca46299';
    }(FFAppState().customsApiV);
    if (orderNoTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&order_no=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, orderNoTFTextController.text);
    }
    if (FFAppState().clientApiB) {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&client=eq.' + var2;
      }(FFAppState().customsApiV, FFAppState().clientApiId);
    }
    if (warehouseDDValue != null && warehouseDDValue != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&warehouse_name=eq.' + var2;
      }(FFAppState().customsApiV, warehouseDDValue!);
    }
    if (flowDDValue != null && flowDDValue != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&flow=eq.' + var2;
      }(FFAppState().customsApiV, flowDDValue!);
    }
    if (licenceTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&licence_plate=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, licenceTFTextController.text);
    }
    if (improvementDDValue != null && improvementDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().customsApiV, improvementDDValue!);
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().customsApiV, improvementDDValue!);
    }
    if (containerNoTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&container_no=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, containerNoTFTextController.text);
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&container_no=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, containerNoTFTextController.text);
    }
    if (universalRefNumTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&universal_ref_no=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, universalRefNumTFTextController.text);
    }
    if (fMSrefTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&fms_ref=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, fMSrefTFTextController.text);
    }
    if (loadRefDvhTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&load_ref_dvh=ilike.*' + var2 + '*';
      }(FFAppState().customsApiV, loadRefDvhTFTextController.text);
    }
    if (intCustomTFTextController.text != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&internal_ref_custom=eq.' + var2;
      }(FFAppState().customsApiV, intCustomTFTextController.text);
    }
    if (FFAppState().goodDescriptionApiB) {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&good_description=eq.' + var2;
      }(FFAppState().customsApiV, FFAppState().goodDescriptionApiId);
    }
    if (datePicked1 != null) {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&eta_date=gte.' + var2;
      }(
          FFAppState().customsApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked1,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (datePicked2 != null) {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&eta_date=lte.' + var2;
      }(
          FFAppState().customsApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked2,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (packagingDDValue != null && packagingDDValue != '') {
      FFAppState().customsApiV = (String var1, String var2) {
        return var1 + '&packaging_name=eq.' + var2;
      }(FFAppState().customsApiV, packagingDDValue!);
    }
    filteredColumns = await actions.getFilteredColumnNamesFromUrl(
      FFAppState().customsApiV,
    );
    FFAppState().customsFilteredColumns =
        filteredColumns.toList().cast<String>();
    FFAppState().update(() {});
  }
}
