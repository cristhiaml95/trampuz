import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/floating/edit_details/edit_details_widget.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'details_copy_model.dart';
export 'details_copy_model.dart';

class DetailsCopyWidget extends StatefulWidget {
  const DetailsCopyWidget({
    super.key,
    String? orderId,
    String? orderNo,
    required this.warehouseIdDetails,
    this.detailsKey,
    this.barcode,
    required this.flow,
    required this.associatedOrder,
  })  : this.orderId = orderId ?? 'brez izbire',
        this.orderNo = orderNo ?? 'brez izbire';

  final String orderId;
  final String orderNo;
  final String? warehouseIdDetails;
  final String? detailsKey;
  final String? barcode;
  final String? flow;
  final String? associatedOrder;

  @override
  State<DetailsCopyWidget> createState() => _DetailsCopyWidgetState();
}

class _DetailsCopyWidgetState extends State<DetailsCopyWidget> {
  late DetailsCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailsCopyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.detailsViewApiOP = await TablesGroup.detailsViewCall.call(
        orderId: widget.orderId,
        userToken: currentJwtToken,
      );

      if ((_model.detailsViewApiOP?.succeeded ?? true)) {
        FFAppState().detailsJsonList =
            (_model.detailsViewApiOP?.jsonBody ?? '').toList().cast<dynamic>();
        safeSetState(() {});
      }
    });

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

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: FutureBuilder<List<DetailsViewRow>>(
        future: FFAppState()
            .detailsView(
          uniqueQueryKey: valueOrDefault<String>(
            widget.detailsKey,
            'detailsDefKey',
          ),
          requestFn: () => DetailsViewTable().queryRows(
            queryFn: (q) => q.eqOrNull(
              'order_id',
              widget.orderId,
            ),
          ),
        )
            .then((result) {
          try {
            _model.requestCompleted = true;
            _model.requestLastUniqueKey = valueOrDefault<String>(
              widget.detailsKey,
              'detailsDefKey',
            );
          } finally {}
          return result;
        }),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          List<DetailsViewRow> detailsContainerDetailsViewRowList =
              snapshot.data!;

          return Container(
            width: 1000.0,
            height: 600.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(28.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 8.0,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              28.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'ouh0nuof' /* Details */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (widget.flow == 'out') {
                              _model.refreshAssociatedOrderOP =
                                  await TablesGroup
                                      .refreshOrderLevelCalculatedColumnsCall
                                      .call(
                                rowId: widget.associatedOrder,
                                userToken: currentJwtToken,
                              );

                              if (!(_model
                                      .refreshAssociatedOrderOP?.succeeded ??
                                  true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Refresh row error.',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                              }
                            }
                            _model.refreshRowOP = await TablesGroup
                                .refreshOrderLevelCalculatedColumnsCall
                                .call(
                              rowId: widget.orderId,
                              userToken: currentJwtToken,
                            );

                            if ((_model.refreshRowOP?.succeeded ?? true)) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Refresh row error.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }

                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.close_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'j4kri4ar' /* Orden No: */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: Text(
                            widget.orderNo,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        FlutterFlowDropDown<String>(
                          controller: _model.barcodeDDValueController ??=
                              FormFieldController<String>(null),
                          options: functions.noRepeated(() {
                            if (widget.flow == 'in') {
                              return detailsContainerDetailsViewRowList
                                  .map((e) => e.barcode)
                                  .withoutNulls
                                  .toList();
                            } else if (widget.flow == 'out') {
                              return detailsContainerDetailsViewRowList
                                  .map((e) => e.barcodeOut)
                                  .withoutNulls
                                  .toList();
                            } else {
                              return FFAppState().emptyList;
                            }
                          }()
                              .toList()),
                          onChanged: (val) =>
                              safeSetState(() => _model.barcodeDDValue = val),
                          width: 300.0,
                          height: 50.0,
                          searchHintTextStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                          searchTextStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: FFLocalizations.of(context).getText(
                            's1tvllxj' /* Select barcode... */,
                          ),
                          searchHintText: FFLocalizations.of(context).getText(
                            '0ml3x8q3' /* Search for an item... */,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 4.0),
                          hidesUnderline: true,
                          isOverButton: true,
                          isSearchable: true,
                          isMultiSelect: false,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            safeSetState(() {
                              _model.barcodeDDValueController?.reset();
                            });
                            safeSetState(() {
                              FFAppState().clearDetailsViewCacheKey(
                                  _model.requestLastUniqueKey);
                              _model.requestCompleted = false;
                            });
                            await _model.waitForRequestCompleted();
                          },
                          child: Icon(
                            Icons.refresh_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Builder(
                      builder: (context) {
                        final containerVar = detailsContainerDetailsViewRowList
                            .where((e) => () {
                                  if (widget.flow == 'in') {
                                    return (_model.barcodeDDValue != null &&
                                            _model.barcodeDDValue != ''
                                        ? (_model.barcodeDDValue == e.barcode)
                                        : true);
                                  } else if (widget.flow == 'out') {
                                    return (_model.barcodeDDValue != null &&
                                            _model.barcodeDDValue != ''
                                        ? (_model.barcodeDDValue ==
                                            e.barcodeOut)
                                        : true);
                                  } else {
                                    return true;
                                  }
                                }())
                            .toList();

                        return Container(
                          width: 1180.0,
                          height: 600.0,
                          child: DataTable2(
                            columns: [
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2.0, 0.0, 2.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: AutoSizeText(
                                            FFLocalizations.of(context).getText(
                                              'xcxrnmtz' /* Packaging */,
                                            ),
                                            textAlign: TextAlign.center,
                                            minFontSize: 6.0,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2.0, 0.0, 2.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: AutoSizeText(
                                            FFLocalizations.of(context).getText(
                                              '2x2w6o2g' /* Warehouse position */,
                                            ),
                                            textAlign: TextAlign.center,
                                            minFontSize: 6.0,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2.0, 0.0, 2.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: AutoSizeText(
                                            FFLocalizations.of(context).getText(
                                              'nov10dl4' /* Barcode */,
                                            ),
                                            textAlign: TextAlign.center,
                                            minFontSize: 6.0,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: AutoSizeText(
                                      FFLocalizations.of(context).getText(
                                        '74spupa0' /* Check */,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      minFontSize: 6.0,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                fixedWidth: 40.0,
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: AutoSizeText(
                                      FFLocalizations.of(context).getText(
                                        '008g0zam' /* Row */,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      minFontSize: 6.0,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                fixedWidth: 40.0,
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: AutoSizeText(
                                      FFLocalizations.of(context).getText(
                                        'snybh5y6' /* Edit */,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      minFontSize: 6.0,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                fixedWidth: 40.0,
                              ),
                              DataColumn2(
                                label: DefaultTextStyle.merge(
                                  softWrap: true,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: AutoSizeText(
                                      FFLocalizations.of(context).getText(
                                        'xrwvu6ag' /* Delete */,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      minFontSize: 6.0,
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                fixedWidth: 50.0,
                              ),
                            ],
                            rows: containerVar
                                .mapIndexed((containerVarIndex,
                                        containerVarItem) =>
                                    [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: SelectionArea(
                                            child: AutoSizeText(
                                          containerVarItem
                                              .packagingDescription!,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          minFontSize: 6.0,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color: widget.barcode !=
                                                            null &&
                                                        widget.barcode != ''
                                                    ? (containerVarItem
                                                                .barcode ==
                                                            widget.barcode
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: SelectionArea(
                                            child: AutoSizeText(
                                          containerVarItem
                                              .warehousePositionName!,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          minFontSize: 6.0,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color: widget.barcode !=
                                                            null &&
                                                        widget.barcode != ''
                                                    ? (containerVarItem
                                                                .barcode ==
                                                            widget.barcode
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: SelectionArea(
                                            child: AutoSizeText(
                                          valueOrDefault<String>(
                                            () {
                                              if (widget.flow == 'in') {
                                                return containerVarItem.barcode;
                                              } else if (widget.flow ==
                                                  'out') {
                                                return containerVarItem
                                                    .barcodeOut;
                                              } else {
                                                return '/';
                                              }
                                            }(),
                                            '/',
                                          ),
                                          textAlign: TextAlign.center,
                                          minFontSize: 6.0,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color: widget.barcode !=
                                                            null &&
                                                        widget.barcode != ''
                                                    ? (containerVarItem
                                                                .barcode ==
                                                            widget.barcode
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primary
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          children: [
                                            if (valueOrDefault<bool>(
                                              containerVarItem.check,
                                              true,
                                            ))
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await DetailsTable().update(
                                                    data: {
                                                      'check': false,
                                                    },
                                                    matchingRows: (rows) =>
                                                        rows.eqOrNull(
                                                      'id',
                                                      containerVarItem.id,
                                                    ),
                                                  );
                                                  FFAppState()
                                                      .clearDetailsViewCache();
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearDetailsViewCacheKey(
                                                            _model
                                                                .requestLastUniqueKey);
                                                    _model.requestCompleted =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForRequestCompleted();
                                                },
                                                child: Icon(
                                                  Icons.check_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .success,
                                                  size: 24.0,
                                                ),
                                              ),
                                            if (!valueOrDefault<bool>(
                                              containerVarItem.check,
                                              false,
                                            ))
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await DetailsTable().update(
                                                    data: {
                                                      'check': true,
                                                    },
                                                    matchingRows: (rows) =>
                                                        rows.eqOrNull(
                                                      'id',
                                                      containerVarItem.id,
                                                    ),
                                                  );
                                                  FFAppState()
                                                      .clearDetailsViewCache();
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearDetailsViewCacheKey(
                                                            _model
                                                                .requestLastUniqueKey);
                                                    _model.requestCompleted =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForRequestCompleted();
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          (containerVarIndex + 1).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Builder(
                                          builder: (context) => InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: EditDetailsWidget(
                                                      idDetailsP:
                                                          containerVarItem.id!,
                                                      warehouseId: widget
                                                          .warehouseIdDetails!,
                                                      flow: widget.flow!,
                                                      refreshQueries: () async {
                                                        FFAppState()
                                                            .clearDetailsViewCache();
                                                        safeSetState(() {
                                                          FFAppState()
                                                              .clearDetailsViewCacheKey(
                                                                  _model
                                                                      .requestLastUniqueKey);
                                                          _model.requestCompleted =
                                                              false;
                                                        });
                                                        await _model
                                                            .waitForRequestCompleted();
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.edit_square,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Builder(
                                          builder: (context) => InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (dialogContext) {
                                                  return Dialog(
                                                    elevation: 0,
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        AlignmentDirectional(
                                                                0.0, 0.0)
                                                            .resolve(
                                                                Directionality.of(
                                                                    context)),
                                                    child: SureQueryWidget(
                                                      saveChangesP: () async {
                                                        await DetailsTable()
                                                            .delete(
                                                          matchingRows:
                                                              (rows) =>
                                                                  rows.eqOrNull(
                                                            'id',
                                                            containerVarItem.id,
                                                          ),
                                                        );
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Elimination'),
                                                              content: Text(
                                                                  'Row deleted successfully.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        safeSetState(() {
                                                          FFAppState()
                                                              .clearDetailsViewCacheKey(
                                                                  _model
                                                                      .requestLastUniqueKey);
                                                          _model.requestCompleted =
                                                              false;
                                                        });
                                                        await _model
                                                            .waitForRequestCompleted();
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete_forever,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .warning,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].map((c) => DataCell(c)).toList())
                                .map((e) => DataRow(cells: e))
                                .toList(),
                            headingRowColor: WidgetStateProperty.all(
                              FlutterFlowTheme.of(context).primaryBackground,
                            ),
                            headingRowHeight: 56.0,
                            dataRowColor: WidgetStateProperty.all(
                              FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            dataRowHeight: 40.0,
                            border: TableBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            dividerThickness: 1.0,
                            columnSpacing: 0.0,
                            showBottomBorder: true,
                            minWidth: 49.0,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
