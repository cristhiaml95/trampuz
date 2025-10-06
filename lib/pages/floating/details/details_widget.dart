import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/floating/edit_details/edit_details_widget.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'details_model.dart';
export 'details_model.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({
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
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  late DetailsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.detailsActionB(context);
      safeSetState(() {});
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
            _model.requestCompleted1 = true;
            _model.requestLastUniqueKey1 = valueOrDefault<String>(
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
                              'ej3c0qzx' /* Details */,
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
                            'n91zm2rr' /* Orden No: */,
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
                            'pyz0k5rt' /* Select barcode... */,
                          ),
                          searchHintText: FFLocalizations.of(context).getText(
                            '34nyg3g4' /* Search for an item... */,
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
                                  _model.requestLastUniqueKey1);
                              _model.requestCompleted1 = false;
                            });
                            await _model.waitForRequestCompleted1();
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
                  Builder(
                    builder: (context) => Container(
                      width: double.infinity,
                      height: 480.0,
                      child: custom_widgets.DetailsPlutogridWidget(
                        width: double.infinity,
                        height: 480.0,
                        language: 'en',
                        data: FFAppState().detailsJsonList,
                        columns: functions.stringToJson('''[
  {
    "column_name": "packaging_description",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "warehouse_position_name",
    "ui_en": "Warehouse position",
    "ui_es": "Posición en almacén",
    "ui_sl": "Položaj v skladišču",
    "width": 180,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "barcode_list",
    "ui_en": "Barcode",
    "ui_es": "Código de barras",
    "ui_sl": "Črtna koda",
    "width": 160,
    "datatype": "List<String>",
    "filter": "contains"
  },
  {
    "column_name": "check",
    "ui_en": "Check",
    "ui_es": "Chequeo",
    "ui_sl": "Pregled",
    "width": 80,
    "datatype": "bool",
    "filter": "boolean"
  },
 
  {
    "column_name": "edit",
    "ui_en": "Edit",
    "ui_es": "Editar",
    "ui_sl": "Uredi",
    "width": 80,
    "datatype": "Icon",
    "filter": "none"
  },
  {
    "column_name": "delete",
    "ui_en": "Delete",
    "ui_es": "Eliminar",
    "ui_sl": "Izbriši",
    "width": 80,
    "datatype": "Icon",
    "filter": "none"
  }
]
'''),
                        flow: widget.flow,
                        editAction: () async {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: EditDetailsWidget(
                                  idDetailsP: FFAppState().detailsRow.id,
                                  warehouseId: widget.warehouseIdDetails!,
                                  flow: widget.flow!,
                                  refreshQueries: () async {
                                    FFAppState().clearDetailsViewCache();
                                    safeSetState(() {
                                      FFAppState().clearDetailsViewCacheKey(
                                          _model.requestLastUniqueKey);
                                      _model.requestCompleted = false;
                                    });
                                    await _model.waitForRequestCompleted();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        deleteAction: () async {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: SureQueryWidget(
                                  saveChangesP: () async {
                                    await DetailsTable().delete(
                                      matchingRows: (rows) => rows.eqOrNull(
                                        'id',
                                        FFAppState().detailsRow.id,
                                      ),
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Elimination'),
                                          content:
                                              Text('Row deleted successfully.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    safeSetState(() {
                                      FFAppState().clearDetailsViewCacheKey(
                                          _model.requestLastUniqueKey);
                                      _model.requestCompleted = false;
                                    });
                                    await _model.waitForRequestCompleted();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        checkAction: () async {
                          await DetailsTable().update(
                            data: {
                              'check': false,
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'id',
                              FFAppState().detailsRow.id,
                            ),
                          );
                          await _model.detailsActionB(context);
                          safeSetState(() {});
                        },
                        xAction: () async {
                          await DetailsTable().update(
                            data: {
                              'check': true,
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'id',
                              FFAppState().detailsRow.id,
                            ),
                          );
                          await _model.detailsActionB(context);
                          safeSetState(() {});
                        },
                      ),
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
