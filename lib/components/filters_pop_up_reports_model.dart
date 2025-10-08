import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'filters_pop_up_reports_widget.dart' show FiltersPopUpReportsWidget;
import 'package:flutter/material.dart';

class FiltersPopUpReportsModel
    extends FlutterFlowModel<FiltersPopUpReportsWidget> {
  ///  Local state fields for this component.

  double filtersWidth = 120.0;

  String? barcodeFilteres;

  UsersRow? users;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in filtersPopUp-Reports widget.
  List<UsersRow>? usersOP;
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
  // State field(s) for UniversalRefNumTF widget.
  FocusNode? universalRefNumTFFocusNode;
  TextEditingController? universalRefNumTFTextController;
  String? Function(BuildContext, String?)?
      universalRefNumTFTextControllerValidator;
  // State field(s) for FMSrefTF widget.
  FocusNode? fMSrefTFFocusNode;
  TextEditingController? fMSrefTFTextController;
  String? Function(BuildContext, String?)? fMSrefTFTextControllerValidator;
  // State field(s) for loadRefDvhTF widget.
  FocusNode? loadRefDvhTFFocusNode;
  TextEditingController? loadRefDvhTFTextController;
  String? Function(BuildContext, String?)? loadRefDvhTFTextControllerValidator;
  // State field(s) for packagingDD widget.
  String? packagingDDValue;
  FormFieldController<String>? packagingDDValueController;
  // State field(s) for goodDD widget.
  String? goodDDValue;
  FormFieldController<String>? goodDDValueController;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode;
  TextEditingController? orderNoTFTextController;
  String? Function(BuildContext, String?)? orderNoTFTextControllerValidator;
  // State field(s) for customDD widget.
  String? customDDValue;
  FormFieldController<String>? customDDValueController;
  // State field(s) for intCustomTF widget.
  FocusNode? intCustomTFFocusNode;
  TextEditingController? intCustomTFTextController;
  String? Function(BuildContext, String?)? intCustomTFTextControllerValidator;
  // State field(s) for invStatusDD widget.
  String? invStatusDDValue;
  FormFieldController<String>? invStatusDDValueController;
  // Stores action output result for [Custom Action - quantityBalanceAction] action in Button widget.
  int? quantityOP;
  // Stores action output result for [Custom Action - quantityBalanceAction] action in Button widget.
  int? quantityOP2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    licenceTFFocusNode?.dispose();
    licenceTFTextController?.dispose();

    containerNoTFFocusNode?.dispose();
    containerNoTFTextController?.dispose();

    universalRefNumTFFocusNode?.dispose();
    universalRefNumTFTextController?.dispose();

    fMSrefTFFocusNode?.dispose();
    fMSrefTFTextController?.dispose();

    loadRefDvhTFFocusNode?.dispose();
    loadRefDvhTFTextController?.dispose();

    orderNoTFFocusNode?.dispose();
    orderNoTFTextController?.dispose();

    intCustomTFFocusNode?.dispose();
    intCustomTFTextController?.dispose();
  }

  /// Action blocks.
  Future filterAction(BuildContext context) async {
    List<String>? filteredColumns;

    // Save filter values for persistence
    FFAppState().reportsFilterValues = {
      'orderNoTF': orderNoTFTextController.text,
      'invStatusDD': invStatusDDValue,
      'flowDD': flowDDValue,
      'licenceTF': licenceTFTextController.text,
      'improvementDD': improvementDDValue,
      'containerNoTF': containerNoTFTextController.text,
      'universalRefNumTF': universalRefNumTFTextController.text,
      'fMSrefTF': fMSrefTFTextController.text,
      'loadRefDvhTF': loadRefDvhTFTextController.text,
      'customDD': customDDValue,
      'intCustomTF': intCustomTFTextController.text,
      'goodDD': goodDDValue,
      'datePicked1': datePicked1,
      'datePicked2': datePicked2,
      'packagingDD': packagingDDValue,
      'clientApiB': FFAppState().clientApiB,
      'goodDescriptionApiB': FFAppState().goodDescriptionApiB,
      'clientApiId': FFAppState().clientApiId,
      'goodDescriptionApiId': FFAppState().goodDescriptionApiId,
    };

    FFAppState().reportsApiV = '';
    FFAppState().reportsApiV = (String var1) {
      return var1 + '&limit=50&is_deleted=eq.false';
    }(FFAppState().reportsApiV);
    if (orderNoTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&order_no=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, orderNoTFTextController.text);
    }
    if (invStatusDDValue != null && invStatusDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&inv_status=eq.' + var2;
      }(FFAppState().reportsApiV, invStatusDDValue!);
    }
    if (FFAppState().clientApiB) {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&client=eq.' + var2;
      }(FFAppState().reportsApiV, FFAppState().clientApiId);
    }
    if (flowDDValue != null && flowDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&flow=eq.' + var2;
      }(FFAppState().reportsApiV, flowDDValue!);
    }
    if (licenceTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&licence_plate=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, licenceTFTextController.text);
    }
    if (improvementDDValue != null && improvementDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().reportsApiV, improvementDDValue!);
    }
    if (containerNoTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&container_no=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, containerNoTFTextController.text);
    }
    if (universalRefNumTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&universal_ref_no=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, universalRefNumTFTextController.text);
    }
    if (fMSrefTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&fms_ref=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, fMSrefTFTextController.text);
    }
    if (loadRefDvhTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&load_ref_dvh=ilike.*' + var2 + '*';
      }(FFAppState().reportsApiV, loadRefDvhTFTextController.text);
    }
    if (customDDValue != null && customDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&custom_name=eq.' + var2;
      }(FFAppState().reportsApiV, customDDValue!);
    }
    if (intCustomTFTextController.text != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&internal_ref_custom=eq.' + var2;
      }(FFAppState().customsApiV, intCustomTFTextController.text);
    }
    if (goodDDValue != null && goodDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&item=eq.' + var2;
      }(FFAppState().reportsApiV, goodDDValue!);
    }
    if (FFAppState().goodDescriptionApiB) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&good_description=eq.' + var2;
      }(FFAppState().reportsApiV, FFAppState().goodDescriptionApiId);
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&good_description=eq.' + var2;
      }(FFAppState().reportsApiV, FFAppState().goodDescriptionApiId);
    }
    if (datePicked1 != null) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&eta_date=gte.' + var2;
      }(
          FFAppState().reportsApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked1,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (datePicked2 != null) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&eta_date=lte.' + var2;
      }(
          FFAppState().reportsApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked2,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (packagingDDValue != null && packagingDDValue != '') {
      FFAppState().reportsApiV = (String var1, String var2) {
        return var1 + '&packaging_name=eq.' + var2;
      }(FFAppState().reportsApiV, packagingDDValue!);
    }
    filteredColumns = await actions.getFilteredColumnNamesFromUrl(
      FFAppState().reportsApiV,
    );
    FFAppState().reportsFilteredColumns =
        filteredColumns.toList().cast<String>();
    FFAppState().update(() {});
  }
}
