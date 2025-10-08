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
import 'filters_pop_up_calendar_model.dart';
export 'filters_pop_up_calendar_model.dart';

class FiltersPopUpCalendarWidget extends StatefulWidget {
  const FiltersPopUpCalendarWidget({super.key});

  @override
  State<FiltersPopUpCalendarWidget> createState() =>
      _FiltersPopUpCalendarWidgetState();
}

class _FiltersPopUpCalendarWidgetState
    extends State<FiltersPopUpCalendarWidget> {
  late FiltersPopUpCalendarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FiltersPopUpCalendarModel());

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

    // Restore saved filter values
    final savedFilters = FFAppState().calendarFilterValues;

    _model.orderNoTFTextController ??= TextEditingController();
    _model.orderNoTFFocusNode ??= FocusNode();
    if (savedFilters['orderNoTF'] != null) {
      _model.orderNoTFTextController.text = savedFilters['orderNoTF'];
    }

    _model.licenceTFTextController ??= TextEditingController();
    _model.licenceTFFocusNode ??= FocusNode();
    if (savedFilters['licenceTF'] != null) {
      _model.licenceTFTextController.text = savedFilters['licenceTF'];
    }

    // Restore dropdown values
    if (savedFilters['invStatusDD'] != null) {
      _model.invStatusDDValueController =
          FormFieldController<String>(savedFilters['invStatusDD']);
    }
    if (savedFilters['warehouseDD'] != null) {
      _model.warehouseDDValueController =
          FormFieldController<String>(savedFilters['warehouseDD']);
    }
    if (savedFilters['orderStatusDD'] != null) {
      _model.orderStatusDDValueController =
          FormFieldController<String>(savedFilters['orderStatusDD']);
    }
    if (savedFilters['flowDD'] != null) {
      _model.flowDDValueController =
          FormFieldController<String>(savedFilters['flowDD']);
    }
    if (savedFilters['improvementDD'] != null) {
      _model.improvementDDValueController =
          FormFieldController<String>(savedFilters['improvementDD']);
    }
    if (savedFilters['adminDD'] != null) {
      _model.adminDDValueController =
          FormFieldController<String>(savedFilters['adminDD']);
    }

    // Restore date pickers
    if (savedFilters['datePicked1'] != null) {
      _model.datePicked1 = savedFilters['datePicked1'];
    }
    if (savedFilters['datePicked2'] != null) {
      _model.datePicked2 = savedFilters['datePicked2'];
    }

    // Restore custom widget states
    if (savedFilters['clientApiB'] != null) {
      FFAppState().clientApiB = savedFilters['clientApiB'];
    }
    if (savedFilters['goodDescriptionApiB'] != null) {
      FFAppState().goodDescriptionApiB = savedFilters['goodDescriptionApiB'];
    }
    if (savedFilters['clientApiId'] != null) {
      FFAppState().clientApiId = savedFilters['clientApiId'];
    }
    if (savedFilters['goodDescriptionApiId'] != null) {
      FFAppState().goodDescriptionApiId = savedFilters['goodDescriptionApiId'];
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
                        FFAppState().showFiltersPopUpCalendar = false;
                        FFAppState().removeAtIndexFromFiltersSelectedCalendar(
                            valueOrDefault<int>(
                                  FFAppState().filtersSelectedCalendar.length,
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
                        'xzozg88n' /* Filter calendar */,
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
                          .filtersSelectedCalendar
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
                                    'znrh16lf' /* Warehouse */,
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
                                'wnigknou' /* Warehouse... */,
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
                          .filtersSelectedCalendar
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
                                    'ibw9upsi' /* Order no */,
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
                                    'b8kitnaf' /* Order no */,
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
                                    .orderNoTFTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      if (FFAppState()
                          .filtersSelectedCalendar
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
                                    'xtvgye10' /* Client */,
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
                      if (FFAppState().filtersSelectedCalendar.contains("flow"))
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
                                    'qre8e4pv' /* Flow */,
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
                                  '0pa5ffde' /* in */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'as2kpdnx' /* out */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'f2cvqq5f' /* / */,
                                )
                              ],
                              onChanged: (val) =>
                                  safeSetState(() => _model.flowDDValue = val),
                              width: valueOrDefault<double>(
                                _model.filtersWidth,
                                120.0,
                              ),
                              height: 48.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'qcuxls8u' /* Flow... */,
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
                          .filtersSelectedCalendar
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
                                      'y68eavea' /* Inventory status */,
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
                                  'q03t7u96' /* najava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'd21sjl3f' /* obdelava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  't9mzk66c' /* izdano */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'r4t24lx1' /* zaloga */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'asbxyfbb' /* brez izbire */,
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
                                'az0uj41g' /* Inv status... */,
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
                          .filtersSelectedCalendar
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
                                    'alpuwz6a' /* Order status */,
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
                                  '97oa4y8j' /* novo naročilo */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'owkt7a6v' /* priprava */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'akcrd3z2' /* izvajanje */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'mmh79d5y' /* zaključeno */,
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
                                'a83no5q7' /* Order status... */,
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
                          .filtersSelectedCalendar
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
                                    '4mdp80vo' /* Dates */,
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
                                              headerTextStyle: FlutterFlowTheme
                                                      .of(context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.openSans(
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
                                                    fontWeight: FontWeight.w600,
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
                                        } else if (_model.datePicked1 != null) {
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
                                        '032jvtku' /*  :  */,
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
                                              headerTextStyle: FlutterFlowTheme
                                                      .of(context)
                                                  .headlineLarge
                                                  .override(
                                                    font: GoogleFonts.openSans(
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
                                                    fontWeight: FontWeight.w600,
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
                                        } else if (_model.datePicked2 != null) {
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
                          .filtersSelectedCalendar
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
                                    'y3mxc9ha' /* Improvement */,
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
                                  'tjx28zkr' /* kont.-20" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '2wggnghd' /* kont.-40" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'ay57xy15' /* kont.-45" */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'yd3gm1gb' /* cerada */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'tiek1m5q' /* hladilnik */,
                                ),
                                FFLocalizations.of(context).getText(
                                  'aqdouee1' /* silos */,
                                ),
                                FFLocalizations.of(context).getText(
                                  '53qvvkar' /* / */,
                                )
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.improvementDDValue = val),
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
                                'b82t2okv' /* Improvement... */,
                              ),
                              searchHintText:
                                  FFLocalizations.of(context).getText(
                                'tqd85edq' /* Search for an item... */,
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
                          .filtersSelectedCalendar
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
                                    'p1g3p1fb' /* Admin */,
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
                                'giwc7ntm' /* Admin... */,
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
                          .filtersSelectedCalendar
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
                                    'qdvwifp9' /* Licence */,
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
                                    'i26b401b' /* Licence */,
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
                        await _model.filterAction(context);
                        await action_blocks.orderWarehouseAction(context);
                        safeSetState(() {});
                        _model.quantityOP = await actions.quantityBalanceAction(
                          FFAppState().calendarApiOPJsonList.toList(),
                        );
                        FFAppState().quantityBalance = _model.quantityOP!;
                        safeSetState(() {});

                        safeSetState(() {});
                      },
                      text: FFLocalizations.of(context).getText(
                        'vf7kmmwy' /* Search */,
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
                          _model.adminDDValueController?.reset();
                        });
                        safeSetState(() {
                          _model.licenceTFTextController?.clear();
                          _model.orderNoTFTextController?.clear();
                        });
                        FFAppState().goodDescriptionApiB = false;
                        FFAppState().clientApiB = false;
                        // Clear persisted filter values
                        FFAppState().calendarFilterValues = {};
                        FFAppState().calendarFilterColumns = [];
                        safeSetState(() {});
                        await _model.filterAction(context);
                        await action_blocks.orderWarehouseAction(context);
                        safeSetState(() {});
                        _model.quantityOP2 =
                            await actions.quantityBalanceAction(
                          FFAppState().calendarApiOPJsonList.toList(),
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
                        'iq3qlewh' /* Reset filters */,
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
