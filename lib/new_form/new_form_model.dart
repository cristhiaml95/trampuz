import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'new_form_widget.dart' show NewFormWidget;
import 'package:flutter/material.dart';

class NewFormModel extends FlutterFlowModel<NewFormWidget> {
  ///  Local state fields for this page.

  int unitLast = 0;

  int numberOfBarcodes = 0;

  List<String> barcodesList = [];
  void addToBarcodesList(String item) => barcodesList.add(item);
  void removeFromBarcodesList(String item) => barcodesList.remove(item);
  void removeAtIndexFromBarcodesList(int index) => barcodesList.removeAt(index);
  void insertAtIndexInBarcodesList(int index, String item) =>
      barcodesList.insert(index, item);
  void updateBarcodesListAtIndex(int index, Function(String) updateFn) =>
      barcodesList[index] = updateFn(barcodesList[index]);

  List<String> pdfLinks = [];
  void addToPdfLinks(String item) => pdfLinks.add(item);
  void removeFromPdfLinks(String item) => pdfLinks.remove(item);
  void removeAtIndexFromPdfLinks(int index) => pdfLinks.removeAt(index);
  void insertAtIndexInPdfLinks(int index, String item) =>
      pdfLinks.insert(index, item);
  void updatePdfLinksAtIndex(int index, Function(String) updateFn) =>
      pdfLinks[index] = updateFn(pdfLinks[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  Stream<List<InsuranceThresholdRow>>? newFormSupabaseStream;
  // State field(s) for orderNoTF widget.
  FocusNode? orderNoTFFocusNode;
  TextEditingController? orderNoTFTextController;
  String? Function(BuildContext, String?)? orderNoTFTextControllerValidator;
  // State field(s) for flowDD widget.
  String? flowDDValue;
  FormFieldController<String>? flowDDValueController;
  // Stores action output result for [Custom Action - selectDate] action in Button widget.
  DateTime? estimatedArrivalTime;
  // State field(s) for orderStatusDD widget.
  String? orderStatusDDValue;
  FormFieldController<String>? orderStatusDDValueController;
  // State field(s) for warehouseDD widget.
  String? warehouseDDValue;
  FormFieldController<String>? warehouseDDValueController;
  // State field(s) for adminDD widget.
  String? adminDDValue;
  FormFieldController<String>? adminDDValueController;
  // State field(s) for customDD widget.
  String? customDDValue;
  FormFieldController<String>? customDDValueController;
  Stream<List<CustomsRow>>? customDDSupabaseStream;
  // State field(s) for intRefNoTF widget.
  FocusNode? intRefNoTFFocusNode;
  TextEditingController? intRefNoTFTextController;
  String? Function(BuildContext, String?)? intRefNoTFTextControllerValidator;
  // State field(s) for intAccountingTF widget.
  FocusNode? intAccountingTFFocusNode;
  TextEditingController? intAccountingTFTextController;
  String? Function(BuildContext, String?)?
      intAccountingTFTextControllerValidator;
  // State field(s) for inventoryStatusDD widget.
  String? inventoryStatusDDValue;
  FormFieldController<String>? inventoryStatusDDValueController;
  // Stores action output result for [Custom Action - selectTime] action in Button widget.
  DateTime? announcedTime1;
  // Stores action output result for [Custom Action - selectTime] action in Button widget.
  DateTime? arrivalTime;
  // State field(s) for loadingGateDD widget.
  String? loadingGateDDValue;
  FormFieldController<String>? loadingGateDDValueController;
  // State field(s) for loadingSequenceTF widget.
  FocusNode? loadingSequenceTFFocusNode;
  TextEditingController? loadingSequenceTFTextController;
  String? Function(BuildContext, String?)?
      loadingSequenceTFTextControllerValidator;
  // Stores action output result for [Custom Action - selectTime] action in Button widget.
  DateTime? startTime;
  // Stores action output result for [Custom Action - selectTime] action in Button widget.
  DateTime? endTime;
  // State field(s) for licencePlateTF widget.
  FocusNode? licencePlateTFFocusNode;
  TextEditingController? licencePlateTFTextController;
  String? Function(BuildContext, String?)?
      licencePlateTFTextControllerValidator;
  // State field(s) for improvementDD widget.
  String? improvementDDValue;
  FormFieldController<String>? improvementDDValueController;
  // State field(s) for containerTF widget.
  FocusNode? containerTFFocusNode;
  TextEditingController? containerTFTextController;
  String? Function(BuildContext, String?)? containerTFTextControllerValidator;
  // State field(s) for unitTF widget.
  FocusNode? unitTFFocusNode;
  TextEditingController? unitTFTextController;
  String? Function(BuildContext, String?)? unitTFTextControllerValidator;
  // State field(s) for weightTF widget.
  FocusNode? weightTFFocusNode;
  TextEditingController? weightTFTextController;
  String? Function(BuildContext, String?)? weightTFTextControllerValidator;
  // State field(s) for quantityTF widget.
  FocusNode? quantityTFFocusNode;
  TextEditingController? quantityTFTextController;
  String? Function(BuildContext, String?)? quantityTFTextControllerValidator;
  // State field(s) for palletPositionT widget.
  FocusNode? palletPositionTFocusNode;
  TextEditingController? palletPositionTTextController;
  String? Function(BuildContext, String?)?
      palletPositionTTextControllerValidator;
  // State field(s) for preCheckCB widget.
  bool? preCheckCBValue;
  // State field(s) for checkCB widget.
  bool? checkCBValue;
  // State field(s) for comentT widget.
  FocusNode? comentTFocusNode;
  TextEditingController? comentTTextController;
  String? Function(BuildContext, String?)? comentTTextControllerValidator;
  // State field(s) for otherManipulationsDD widget.
  String? otherManipulationsDDValue;
  FormFieldController<String>? otherManipulationsDDValueController;
  // State field(s) for loadingTypeDD widget.
  String? loadingTypeDDValue;
  FormFieldController<String>? loadingTypeDDValueController;
  // State field(s) for loadingType2DD widget.
  String? loadingType2DDValue;
  FormFieldController<String>? loadingType2DDValueController;
  // State field(s) for responsibleDD widget.
  String? responsibleDDValue;
  FormFieldController<String>? responsibleDDValueController;
  // State field(s) for assistant1DD widget.
  String? assistant1DDValue;
  FormFieldController<String>? assistant1DDValueController;
  // State field(s) for assistant2DD widget.
  String? assistant2DDValue;
  FormFieldController<String>? assistant2DDValueController;
  // State field(s) for universalRefNumTF widget.
  FocusNode? universalRefNumTFFocusNode;
  TextEditingController? universalRefNumTFTextController;
  String? Function(BuildContext, String?)?
      universalRefNumTFTextControllerValidator;
  // State field(s) for fmsRefTF widget.
  FocusNode? fmsRefTFFocusNode;
  TextEditingController? fmsRefTFTextController;
  String? Function(BuildContext, String?)? fmsRefTFTextControllerValidator;
  // State field(s) for LoaRefDvhTF widget.
  FocusNode? loaRefDvhTFFocusNode;
  TextEditingController? loaRefDvhTFTextController;
  String? Function(BuildContext, String?)? loaRefDvhTFTextControllerValidator;
  // State field(s) for goodsDD widget.
  String? goodsDDValue;
  FormFieldController<String>? goodsDDValueController;
  // State field(s) for packagingDD widget.
  String? packagingDDValue;
  FormFieldController<String>? packagingDDValueController;
  // State field(s) for barcodesTF widget.
  FocusNode? barcodesTFFocusNode;
  TextEditingController? barcodesTFTextController;
  String? Function(BuildContext, String?)? barcodesTFTextControllerValidator;
  // State field(s) for repeatedbarcodesT widget.
  FocusNode? repeatedbarcodesTFocusNode;
  TextEditingController? repeatedbarcodesTTextController;
  String? Function(BuildContext, String?)?
      repeatedbarcodesTTextControllerValidator;
  // State field(s) for nonExistentBarcodesT widget.
  FocusNode? nonExistentBarcodesTFocusNode;
  TextEditingController? nonExistentBarcodesTTextController;
  String? Function(BuildContext, String?)?
      nonExistentBarcodesTTextControllerValidator;
  // State field(s) for taricCodeTF widget.
  FocusNode? taricCodeTFFocusNode;
  TextEditingController? taricCodeTFTextController;
  String? Function(BuildContext, String?)? taricCodeTFTextControllerValidator;
  // State field(s) for customPercentageTF widget.
  FocusNode? customPercentageTFFocusNode;
  TextEditingController? customPercentageTFTextController;
  String? Function(BuildContext, String?)?
      customPercentageTFTextControllerValidator;
  String? _customPercentageTFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'f6hy2l2o' /* Velue between 0 and 100 is req... */,
      );
    }

    if (!RegExp(
            '^(?:0+|0*(?:100(?:[.,]0+)?|(?:\\d{1,2})(?:[.,]\\d+)?|[.,]\\d+))\$')
        .hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'ay7ro51w' /* Velue between 0 and 100 is req... */,
      );
    }
    return null;
  }

  // State field(s) for initCostTF widget.
  FocusNode? initCostTFFocusNode;
  TextEditingController? initCostTFTextController;
  String? Function(BuildContext, String?)? initCostTFTextControllerValidator;
  // State field(s) for currencyCC widget.
  FormFieldController<List<String>>? currencyCCValueController;
  String? get currencyCCValue => currencyCCValueController?.value?.firstOrNull;
  set currencyCCValue(String? val) =>
      currencyCCValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  bool? sureQueryOP;
  // Stores action output result for [Backend Call - API (refreshOrderLevelCalculatedColumns)] action in Button widget.
  ApiCallResponse? refreshRowOP;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  OrderLevelRow? insertedRowOP;
  // Stores action output result for [Custom Action - enforceDouble] action in Button widget.
  double? initCost;

  @override
  void initState(BuildContext context) {
    customPercentageTFTextControllerValidator =
        _customPercentageTFTextControllerValidator;
  }

  @override
  void dispose() {
    orderNoTFFocusNode?.dispose();
    orderNoTFTextController?.dispose();

    intRefNoTFFocusNode?.dispose();
    intRefNoTFTextController?.dispose();

    intAccountingTFFocusNode?.dispose();
    intAccountingTFTextController?.dispose();

    loadingSequenceTFFocusNode?.dispose();
    loadingSequenceTFTextController?.dispose();

    licencePlateTFFocusNode?.dispose();
    licencePlateTFTextController?.dispose();

    containerTFFocusNode?.dispose();
    containerTFTextController?.dispose();

    unitTFFocusNode?.dispose();
    unitTFTextController?.dispose();

    weightTFFocusNode?.dispose();
    weightTFTextController?.dispose();

    quantityTFFocusNode?.dispose();
    quantityTFTextController?.dispose();

    palletPositionTFocusNode?.dispose();
    palletPositionTTextController?.dispose();

    comentTFocusNode?.dispose();
    comentTTextController?.dispose();

    universalRefNumTFFocusNode?.dispose();
    universalRefNumTFTextController?.dispose();

    fmsRefTFFocusNode?.dispose();
    fmsRefTFTextController?.dispose();

    loaRefDvhTFFocusNode?.dispose();
    loaRefDvhTFTextController?.dispose();

    barcodesTFFocusNode?.dispose();
    barcodesTFTextController?.dispose();

    repeatedbarcodesTFocusNode?.dispose();
    repeatedbarcodesTTextController?.dispose();

    nonExistentBarcodesTFocusNode?.dispose();
    nonExistentBarcodesTTextController?.dispose();

    taricCodeTFFocusNode?.dispose();
    taricCodeTFTextController?.dispose();

    customPercentageTFFocusNode?.dispose();
    customPercentageTFTextController?.dispose();

    initCostTFFocusNode?.dispose();
    initCostTFTextController?.dispose();
  }
}
