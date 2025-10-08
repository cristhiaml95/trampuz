import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filters_pop_up_warehouse2_model.dart';
export 'filters_pop_up_warehouse2_model.dart';

class FiltersPopUpWarehouse2Widget extends StatefulWidget {
  const FiltersPopUpWarehouse2Widget({super.key});

  @override
  State<FiltersPopUpWarehouse2Widget> createState() =>
      _FiltersPopUpWarehouse2WidgetState();
}

class _FiltersPopUpWarehouse2WidgetState
    extends State<FiltersPopUpWarehouse2Widget> {
  late FiltersPopUpWarehouse2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FiltersPopUpWarehouse2Model());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          _model.usersOP = await UsersTable().queryRows(
            queryFn: (q) => q,
          );
        }(),
      );
    });

    _model.orderNoTFTextController ??= TextEditingController();
    _model.orderNoTFFocusNode ??= FocusNode();

    _model.licenceTFTextController ??= TextEditingController();
    _model.licenceTFFocusNode ??= FocusNode();

    _model.containerNoTFTextController ??= TextEditingController();
    _model.containerNoTFFocusNode ??= FocusNode();

    _model.palletPositionTFTextController ??= TextEditingController();
    _model.palletPositionTFFocusNode ??= FocusNode();

    _model.universalRefNumTFTextController ??= TextEditingController();
    _model.universalRefNumTFFocusNode ??= FocusNode();

    _model.fMSrefTFTextController ??= TextEditingController();
    _model.fMSrefTFFocusNode ??= FocusNode();

    _model.loadRefDvhTFTextController ??= TextEditingController();
    _model.loadRefDvhTFFocusNode ??= FocusNode();

    _model.intCustomTFTextController ??= TextEditingController();
    _model.intCustomTFFocusNode ??= FocusNode();

    _model.barcodesTFTextController ??= TextEditingController();
    _model.barcodesTFFocusNode ??= FocusNode();

    // Restaurar valores guardados de filtros
    final saved = FFAppState().warehouse2FilterValues;
    if (saved.isNotEmpty) {
      _model.orderNoTFTextController?.text = saved['orderNoTF'] ?? '';
      _model.licenceTFTextController?.text = saved['licenceTF'] ?? '';
      _model.containerNoTFTextController?.text = saved['containerNoTF'] ?? '';
      _model.palletPositionTFTextController?.text =
          saved['palletPositionTF'] ?? '';
      _model.universalRefNumTFTextController?.text =
          saved['universalRefNumTF'] ?? '';
      _model.fMSrefTFTextController?.text = saved['fMSrefTF'] ?? '';
      _model.loadRefDvhTFTextController?.text = saved['loadRefDvhTF'] ?? '';
      _model.intCustomTFTextController?.text = saved['intCustomTF'] ?? '';
      _model.barcodesTFTextController?.text = saved['barcodesTF'] ?? '';
      _model.datePicked1 = saved['datePicked1'];
      _model.datePicked2 = saved['datePicked2'];

      // Inicializar FormFieldControllers de dropdowns con valores guardados
      _model.invStatusDDValueController =
          FormFieldController<String>(saved['invStatusDD']);
      _model.warehouseDDValueController =
          FormFieldController<String>(saved['warehouseDD']);
      _model.orderStatusDDValueController =
          FormFieldController<String>(saved['orderStatusDD']);
      _model.flowDDValueController =
          FormFieldController<String>(saved['flowDD']);
      _model.improvementDDValueController =
          FormFieldController<String>(saved['improvementDD']);
      _model.packagingDDValueController =
          FormFieldController<String>(saved['packagingDD']);
      _model.customDDValueController =
          FormFieldController<String>(saved['customDD']);
      _model.goodDDValueController =
          FormFieldController<String>(saved['goodDD']);
      _model.assistant1DDValueController =
          FormFieldController<String>(saved['assistant1DD']);
      _model.assistant2DDValueController =
          FormFieldController<String>(saved['assistant2DD']);
      _model.adminDDValueController =
          FormFieldController<String>(saved['adminDD']);

      // Restaurar valores de custom widgets
      if (saved['clientApiB'] == true) {
        FFAppState().clientApiB = saved['clientApiB'] ?? false;
        FFAppState().clientApiId = saved['clientApiId'] ?? '';
        FFAppState().clientApiV = saved['clientApiV'] ?? '';
      }
      if (saved['goodDescriptionApiB'] == true) {
        FFAppState().goodDescriptionApiB =
            saved['goodDescriptionApiB'] ?? false;
        FFAppState().goodDescriptionApiId = saved['goodDescriptionApiId'] ?? '';
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Material(
      color: Colors.transparent,
      elevation: 16.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 280.0,
        height: 230.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
              spreadRadius: 4.0,
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().showFiltersPopUpWarehouse2 = false;
                        FFAppState().removeAtIndexFromFiltersSelectedWarehouse2(
                            valueOrDefault<int>(
                                  FFAppState().filtersSelectedWarehouse2.length,
                                  0,
                                ) -
                                1);
                        FFAppState().update(() {});
                      },
                      child: Icon(
                        Icons.close_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'irgv8mk6' /* Filter warehouse2 */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Roboto',
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("order_no"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.feed,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'z9f6zp50' /* Order no */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.orderNoTFTextController,
                                focusNode: _model.orderNoTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'e94w74j9' /* Order no */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .orderNoTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("client_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.person,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'xtcgg2hp' /* Client */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: 150.0,
                              height: 48.0,
                              child: custom_widgets.ClientTFDD(
                                width: 150.0,
                                height: 48.0,
                                clientList: FFAppState().clientList,
                                borderWidth: 1.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).accent1,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                radiusTopLeft: 4.0,
                                radiusTopRight: 4.0,
                                radiusBottomLeft: 4.0,
                                radiusBottomRight: 4.0,
                                dropdownMaxHeight: 46.0,
                                action: () async {
                                  FFAppState().clientApiB = true;
                                  safeSetState(() {});
                                  await action_blocks.clientApiAction(context);
                                  safeSetState(() {});
                                },
                                resetAction: () async {
                                  FFAppState().clientApiB = false;
                                  FFAppState().clientApiId = '';
                                  FFAppState().clientApiV = '';
                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("inv_status"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.inventory_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '4rwo974e' /* Inventory status */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.invStatusDDValueController ??=
                                  FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  'a6jqx3xg' /* najava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'vuae1npv' /* obdelava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'bdu6t0xf' /* izdano */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'y9vii32h' /* zaloga */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'ryj3sx9i' /* brez izbire */,
                                )
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.invStatusDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '9q194mmg' /* Inv status... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("warehouse_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.warehouse_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ngfvnx3a' /* Warehouse */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.warehouseDDValueController ??=
                                  FormFieldController<String>(null),
                              options: FFAppState().warehouseList,
                              onChanged: (val) => safeSetState(
                                  () => _model.warehouseDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'fbwk2eb1' /* Warehouse... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("order_status"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.note_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'fosada66' /* Order status */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller:
                                  _model.orderStatusDDValueController ??=
                                      FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  '7mt5192y' /* novo naročilo */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'xuvy61hp' /* priprava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'z6d6f7a0' /* izvajanje */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'h90stdsz' /* zaključeno */,
                                )
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.orderStatusDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'vf4gwvpi' /* Order status... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("eta_date"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'hucfmlhy' /* Dates */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            if (FFAppState()
                                .filtersSelectedOrderwarehouse
                                .contains("eta_date"))
                              Container(
                                width: valueOrDefault<double>(
                                  _model.filtersWidth,
                                  120.0,
                                ),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).accent1,
                                    width: 1.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final _datePicked1Date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: getCurrentTimestamp,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2050),
                                            builder: (context, child) {
                                              return wrapInMaterialDatePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );

                                          if (_datePicked1Date != null) {
                                            safeSetState(() {
                                              _model.datePicked1 = DateTime(
                                                _datePicked1Date.year,
                                                _datePicked1Date.month,
                                                _datePicked1Date.day,
                                              );
                                            });
                                          } else if (_model.datePicked1 !=
                                              null) {
                                            safeSetState(() {
                                              _model.datePicked1 =
                                                  getCurrentTimestamp;
                                            });
                                          }

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: AutoSizeText(
                                            valueOrDefault<String>(
                                              _model.datePicked1 != null
                                                  ? valueOrDefault<String>(
                                                      dateTimeFormat(
                                                        "d/M",
                                                        _model.datePicked1,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      'd1',
                                                    )
                                                  : 'd1',
                                              'd1',
                                            ),
                                            minFontSize: 6.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'rut16gvt' /*  :  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final _datePicked2Date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: getCurrentTimestamp,
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2050),
                                            builder: (context, child) {
                                              return wrapInMaterialDatePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );

                                          if (_datePicked2Date != null) {
                                            safeSetState(() {
                                              _model.datePicked2 = DateTime(
                                                _datePicked2Date.year,
                                                _datePicked2Date.month,
                                                _datePicked2Date.day,
                                              );
                                            });
                                          } else if (_model.datePicked2 !=
                                              null) {
                                            safeSetState(() {
                                              _model.datePicked2 =
                                                  getCurrentTimestamp;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: AutoSizeText(
                                            valueOrDefault<String>(
                                              _model.datePicked2 != null
                                                  ? valueOrDefault<String>(
                                                      dateTimeFormat(
                                                        "d/M",
                                                        _model.datePicked2,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      'd2',
                                                    )
                                                  : 'd2',
                                              'd2',
                                            ),
                                            minFontSize: 6.0,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("flow"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.loop_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '7mig9sam' /* Flow */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.flowDDValueController ??=
                                  FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  'pm15yd41' /* in */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '1ssmqwop' /* out */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'qaa3brb2' /* / */,
                                )
                              ],
                              onChanged: (val) =>
                                  safeSetState(() => _model.flowDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '3780sm2b' /* Flow... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("licence_plate"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.call_to_action,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'n2ysjg34' /* Licence */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.licenceTFTextController,
                                focusNode: _model.licenceTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    '2n8gfvay' /* Licence */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .licenceTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("improvement"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.upgrade_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'cflpz8ug' /* Improvement */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller:
                                  _model.improvementDDValueController ??=
                                      FormFieldController<String>(null),
                              options: [
                                FFLocalizations.of(context).getText(
                                  '0bmyexge' /* kont.-20" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'k4gbg7rq' /* kont.-40" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'y8bnb6r4' /* kont.-45" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'uadzr2va' /* cerada */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'prwrhneb' /* hladilnik */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'rgnztqkq' /* silos */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '8zgsjqcq' /* / */,
                                )
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.improvementDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 48.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'rw0jpd1m' /* Improvement... */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                'x218m80p' /* Search for an item... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("container_no"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'oeq2bawt' /* Container */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.containerNoTFTextController,
                                focusNode: _model.containerNoTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    '9iyewsnl' /* Container no */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .containerNoTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("packaging_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.pages,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '7j25m0zi' /* Packaging */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.packagingDDValueController ??=
                                  FormFieldController<String>(null),
                              options: FFAppState().packagingList,
                              onChanged: (val) => safeSetState(
                                  () => _model.packagingDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'yyz35ptp' /* Packaging... */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                'uq9j36mh' /* Search for an item... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("pallet_position"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.settings_input_composite_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'zvvqqw4h' /* Pallet position */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller:
                                    _model.palletPositionTFTextController,
                                focusNode: _model.palletPositionTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'q2g3nydw' /* Pallet position */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .palletPositionTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("universal_ref_no"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.recommend,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ad4tz59a' /* Universal ref */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller:
                                    _model.universalRefNumTFTextController,
                                focusNode: _model.universalRefNumTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'hmy93n8p' /* Universal ref num */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .universalRefNumTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("fms_ref"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.recommend,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'fbf472vj' /* FMS ref */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.fMSrefTFTextController,
                                focusNode: _model.fMSrefTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'omgf2y6f' /* FMS ref */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .fMSrefTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("load_ref_dvh"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.recommend,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'r6e8uqkr' /* Load ref */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.loadRefDvhTFTextController,
                                focusNode: _model.loadRefDvhTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    '6zz6lxft' /* Load ref dvh */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .loadRefDvhTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("custom_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.content_cut_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '0l8vap15' /* Custom */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.customDDValueController ??=
                                  FormFieldController<String>(null),
                              options: FFAppState().customList,
                              onChanged: (val) => safeSetState(
                                  () => _model.customDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'vc5g53is' /* Custom... */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                'pjszqmsb' /* Search for an item... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("internal_ref_custom"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.content_cut_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '30b2y6rf' /* Int custom */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.intCustomTFTextController,
                                focusNode: _model.intCustomTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'qgah646m' /* Int custom */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .intCustomTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("item"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.security_update_good,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '7m9sok4b' /* Good */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.goodDDValueController ??=
                                  FormFieldController<String>(null),
                              options: FFAppState().goodsList,
                              onChanged: (val) =>
                                  safeSetState(() => _model.goodDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '7ppupt80' /* Good... */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                'jf0gnovj' /* Search for an item... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("opis_blaga"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.security_update_good,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'uznat6ma' /* Good description */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 48.0,
                              child: custom_widgets.GoodDescriptionTFDD(
                                width: valueOrDefault<double>(
                                  _model.filtersWidth,
                                  120.0,
                                ),
                                height: 48.0,
                                goodDescriptionList:
                                    FFAppState().goodDescriptionList,
                                borderWidth: 1.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).accent1,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                radiusTopLeft: 4.0,
                                radiusTopRight: 4.0,
                                radiusBottomLeft: 4.0,
                                radiusBottomRight: 4.0,
                                dropdownMaxHeight: 46.0,
                                action: () async {
                                  FFAppState().goodDescriptionApiB = true;
                                  safeSetState(() {});
                                  await action_blocks
                                      .goodDescriptionApiAction(context);
                                  safeSetState(() {});
                                },
                                resetAction: () async {
                                  FFAppState().goodDescriptionApiB = false;
                                  safeSetState(() {});
                                  FFAppState().goodDescriptionApiV = '';
                                  FFAppState().goodDescriptionApiId = '';
                                  safeSetState(() {});
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("assistant1_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.assist_walker,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ckhll3nh' /* Assistant 1 */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.assistant1DDValueController ??=
                                  FormFieldController<String>(
                                _model.assistant1DDValue ??= '',
                              ),
                              options: List<String>.from(
                                  _model.usersOP!.map((e) => e.id).toList()),
                              optionLabels:
                                  _model.usersOP!.map((e) => e.name).toList(),
                              onChanged: (val) => safeSetState(
                                  () => _model.assistant1DDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 48.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '1335lksi' /* Assistant 1... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("assistant2_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.assist_walker,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'flecrlqb' /* Assistant 2 */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.assistant2DDValueController ??=
                                  FormFieldController<String>(
                                _model.assistant2DDValue ??= '',
                              ),
                              options: List<String>.from(
                                  _model.usersOP!.map((e) => e.id).toList()),
                              optionLabels:
                                  _model.usersOP!.map((e) => e.name).toList(),
                              onChanged: (val) => safeSetState(
                                  () => _model.assistant2DDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'tfsyb03k' /* Assistant 2... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("admin_name"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.man,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'j0xlaaiq' /* Admin */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.adminDDValueController ??=
                                  FormFieldController<String>(
                                _model.adminDDValue ??= '',
                              ),
                              options: List<String>.from(_model.usersOP!
                                  .where((e) => e.userType == 'administrator')
                                  .toList()
                                  .map((e) => e.id)
                                  .toList()),
                              optionLabels: _model.usersOP!
                                  .where((e) => e.userType == 'administrator')
                                  .toList()
                                  .map((e) => e.name)
                                  .toList(),
                              onChanged: (val) =>
                                  safeSetState(() => _model.adminDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 50.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'bnylikx0' /* Admin... */,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: 4.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedWarehouse2
                          .contains("barcode"))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.qr_code_2,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'fbspepwu' /* Barcodes */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              child: TextFormField(
                                controller: _model.barcodesTFTextController,
                                focusNode: _model.barcodesTFFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    'ma2yj487' /* Barcode */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .barcodesTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        await _model.filterActionWarehouse2(context);
                        await action_blocks.orderWarehouseAction(context);
                        safeSetState(() {});
                        _model.barcodeFilteres =
                            _model.barcodesTFTextController.text;
                        safeSetState(() {});
                        _model.quantityOP = await actions.quantityBalanceAction(
                          FFAppState().warehouse2ApiOPJsonList.toList(),
                        );
                        FFAppState().quantityBalance = _model.quantityOP!;
                        safeSetState(() {});

                        safeSetState(() {});
                      },
                      text: FFLocalizations.of(context).getText(
                        'fr7srevj' /* Search */,
                      ),
                      icon: Icon(
                        Icons.search_sharp,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 28.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        await action_blocks.startingPage(context);
                        safeSetState(() {
                          _model.invStatusDDValueController?.reset();
                          _model.warehouseDDValueController?.reset();
                          _model.orderStatusDDValueController?.reset();
                          _model.flowDDValueController?.reset();
                          _model.improvementDDValueController?.reset();
                          _model.packagingDDValueController?.reset();
                          _model.customDDValueController?.reset();
                          _model.goodDDValueController?.reset();
                          _model.assistant1DDValueController?.reset();
                          _model.assistant2DDValueController?.reset();
                          _model.adminDDValueController?.reset();
                        });
                        safeSetState(() {
                          _model.orderNoTFTextController?.clear();
                          _model.licenceTFTextController?.clear();
                          _model.containerNoTFTextController?.clear();
                          _model.palletPositionTFTextController?.clear();
                          _model.universalRefNumTFTextController?.clear();
                          _model.fMSrefTFTextController?.clear();
                          _model.loadRefDvhTFTextController?.clear();
                          _model.intCustomTFTextController?.clear();
                          _model.barcodesTFTextController?.clear();
                        });
                        FFAppState().goodDescriptionApiB = false;
                        FFAppState().clientApiB = false;
                        FFAppState().warehouse2FilterValues = {};
                        FFAppState().warehouse2FilterdColumns = [];
                        safeSetState(() {});
                        await _model.filterActionWarehouse2(context);
                        await action_blocks.orderWarehouseAction(context);
                        safeSetState(() {});
                        _model.barcodeFilteres =
                            _model.barcodesTFTextController.text;
                        safeSetState(() {});
                        _model.quantityOP2 =
                            await actions.quantityBalanceAction(
                          FFAppState().warehouse2ApiOPJsonList.toList(),
                        );
                        FFAppState().quantityBalance = _model.quantityOP2!;
                        safeSetState(() {});
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Filters updated.',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                height: 0.25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(milliseconds: 500),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );

                        safeSetState(() {});
                      },
                      text: FFLocalizations.of(context).getText(
                        '2jk9dgyw' /* Reset filters */,
                      ),
                      icon: Icon(
                        Icons.restart_alt,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        height: 28.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).warning,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
