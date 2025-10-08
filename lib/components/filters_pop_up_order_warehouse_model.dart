import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'filters_pop_up_order_warehouse_widget.dart'
    show FiltersPopUpOrderWarehouseWidget;
import 'package:flutter/material.dart';

class FiltersPopUpOrderWarehouseModel
    extends FlutterFlowModel<FiltersPopUpOrderWarehouseWidget> {
  ///  Local state fields for this component.

  double filtersWidth = 240.0;

  String? barcodeFilteres;

  UsersRow? users;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in filtersPopUp-OrderWarehouse widget.
  List<UsersRow>? usersOP;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode;
  TextEditingController? orderNoTFTextController;
  String? Function(BuildContext, String?)? orderNoTFTextControllerValidator;
  // State field(s) for invStatusDD widget.
  String? invStatusDDValue;
  FormFieldController<String>? invStatusDDValueController;
  // State field(s) for warehouseDD widget.
  String? warehouseDDValue;
  FormFieldController<String>? warehouseDDValueController;
  // State field(s) for orderStatusDD widget.
  String? orderStatusDDValue;
  FormFieldController<String>? orderStatusDDValueController;
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
  // State field(s) for packagingDD widget.
  String? packagingDDValue;
  FormFieldController<String>? packagingDDValueController;
  // State field(s) for palletPositionTF widget.
  FocusNode? palletPositionTFFocusNode;
  TextEditingController? palletPositionTFTextController;
  String? Function(BuildContext, String?)?
      palletPositionTFTextControllerValidator;
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
  // State field(s) for customDD widget.
  String? customDDValue;
  FormFieldController<String>? customDDValueController;
  // State field(s) for intCustomTF widget.
  FocusNode? intCustomTFFocusNode;
  TextEditingController? intCustomTFTextController;
  String? Function(BuildContext, String?)? intCustomTFTextControllerValidator;
  // State field(s) for goodDD widget.
  String? goodDDValue;
  FormFieldController<String>? goodDDValueController;
  // State field(s) for assistant1DD widget.
  String? assistant1DDValue;
  FormFieldController<String>? assistant1DDValueController;
  // State field(s) for assistant2DD widget.
  String? assistant2DDValue;
  FormFieldController<String>? assistant2DDValueController;
  // State field(s) for adminDD widget.
  String? adminDDValue;
  FormFieldController<String>? adminDDValueController;
  // State field(s) for barcodesTF widget.
  FocusNode? barcodesTFFocusNode;
  TextEditingController? barcodesTFTextController;
  String? Function(BuildContext, String?)? barcodesTFTextControllerValidator;
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

    palletPositionTFFocusNode?.dispose();
    palletPositionTFTextController?.dispose();

    universalRefNumTFFocusNode?.dispose();
    universalRefNumTFTextController?.dispose();

    fMSrefTFFocusNode?.dispose();
    fMSrefTFTextController?.dispose();

    loadRefDvhTFFocusNode?.dispose();
    loadRefDvhTFTextController?.dispose();

    intCustomTFFocusNode?.dispose();
    intCustomTFTextController?.dispose();

    barcodesTFFocusNode?.dispose();
    barcodesTFTextController?.dispose();
  }

  /// Action blocks.
  Future filterAction(BuildContext context) async {
    List<String>? filteredColumns;

    // Guardar valores de filtros para persistencia
    FFAppState().orderWarehouseFilterValues = {
      'orderNoTF': orderNoTFTextController.text,
      'invStatusDD': invStatusDDValue,
      'warehouseDD': warehouseDDValue,
      'orderStatusDD': orderStatusDDValue,
      'flowDD': flowDDValue,
      'licenceTF': licenceTFTextController.text,
      'improvementDD': improvementDDValue,
      'containerNoTF': containerNoTFTextController.text,
      'packagingDD': packagingDDValue,
      'palletPositionTF': palletPositionTFTextController.text,
      'universalRefNumTF': universalRefNumTFTextController.text,
      'fMSrefTF': fMSrefTFTextController.text,
      'loadRefDvhTF': loadRefDvhTFTextController.text,
      'customDD': customDDValue,
      'intCustomTF': intCustomTFTextController.text,
      'goodDD': goodDDValue,
      'assistant1DD': assistant1DDValue,
      'assistant2DD': assistant2DDValue,
      'adminDD': adminDDValue,
      'barcodesTF': barcodesTFTextController.text,
      'datePicked1': datePicked1,
      'datePicked2': datePicked2,
      'clientApiB': FFAppState().clientApiB,
      'clientApiId': FFAppState().clientApiId,
      'clientApiV': FFAppState().clientApiV,
      'goodDescriptionApiB': FFAppState().goodDescriptionApiB,
      'goodDescriptionApiId': FFAppState().goodDescriptionApiId,
    };

    FFAppState().orderWarehouseApiV = 'is_deleted=eq.false';
    FFAppState().orderWarehouseApiV = (String var1) {
      return var1 +
          '&order=crono.desc.nullslast&availability=neq.consumed&is_deleted=eq.false&limit=50&custom_name=neq.CARINSKI%20POSTOPEK';
    }(FFAppState().orderWarehouseApiV);
    if (orderNoTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&order_no=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, orderNoTFTextController.text);
    }
    if (invStatusDDValue != null && invStatusDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&inv_status=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, invStatusDDValue!);
    }
    if (FFAppState().clientApiB) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&client=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, FFAppState().clientApiId);
    }
    if (warehouseDDValue != null && warehouseDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&warehouse_name=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, warehouseDDValue!);
    }
    if (orderStatusDDValue != null && orderStatusDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&order_status=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, orderStatusDDValue!);
    }
    if (flowDDValue != null && flowDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&flow=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, flowDDValue!);
    }
    if (licenceTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&licence_plate=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, licenceTFTextController.text);
    }
    if (improvementDDValue != null && improvementDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&improvement=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, improvementDDValue!);
    }
    if (containerNoTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&container_no=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, containerNoTFTextController.text);
    }
    if (palletPositionTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&pallet_position=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, palletPositionTFTextController.text);
    }
    if (universalRefNumTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&universal_ref_no=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, universalRefNumTFTextController.text);
    }
    if (fMSrefTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&fms_ref=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, fMSrefTFTextController.text);
    }
    if (loadRefDvhTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&load_ref_dvh=ilike.*' + var2 + '*';
      }(FFAppState().orderWarehouseApiV, loadRefDvhTFTextController.text);
    }
    if (customDDValue != null && customDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&custom_name=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, customDDValue!);
    }
    if (intCustomTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&internal_ref_custom=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, intCustomTFTextController.text);
    }
    if (goodDDValue != null && goodDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&item=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, goodDDValue!);
    }
    if (FFAppState().goodDescriptionApiB) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&good_description=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, FFAppState().goodDescriptionApiId);
    }
    if (assistant1DDValue != null && assistant1DDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&assistant1=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, assistant1DDValue!);
    }
    if (assistant2DDValue != null && assistant2DDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&assistant2=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, assistant2DDValue!);
    }
    if (adminDDValue != null && adminDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&admin=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, adminDDValue!);
    }
    if (barcodesTFTextController.text != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&barcode_list=cs.{' + var2 + '}';
      }(FFAppState().orderWarehouseApiV, barcodesTFTextController.text);
    }
    if (datePicked1 != null) {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&eta_date=gte.' + var2;
      }(
          FFAppState().orderWarehouseApiV,
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
          FFAppState().orderWarehouseApiV,
          dateTimeFormat(
            "yyyy-MM-dd",
            datePicked2,
            locale: FFLocalizations.of(context).languageCode,
          ));
    }
    if (packagingDDValue != null && packagingDDValue != '') {
      FFAppState().orderWarehouseApiV = (String var1, String var2) {
        return var1 + '&packaging_name=eq.' + var2;
      }(FFAppState().orderWarehouseApiV, packagingDDValue!);
    }
    filteredColumns = await actions.getFilteredColumnNamesFromUrl(
      FFAppState().orderWarehouseApiV,
    );
    FFAppState().orderWarehouseFilteredColumns =
        filteredColumns.toList().cast<String>();
    FFAppState().update(() {});
  }
}
