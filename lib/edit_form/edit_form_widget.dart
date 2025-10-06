import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/floating/associate_query/associate_query_widget.dart';
import '/pages/floating/details/details_widget.dart';
import '/pages/floating/documents/documents_widget.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'edit_form_model.dart';
export 'edit_form_model.dart';

class EditFormWidget extends StatefulWidget {
  const EditFormWidget({
    super.key,
    required this.orderJson,
    String? viewFrom,
  }) : this.viewFrom = viewFrom ?? 'view it is coming fom';

  final OrderWarehouseRowStruct? orderJson;
  final String viewFrom;

  static String routeName = 'editForm';
  static String routePath = '/editForm';

  @override
  State<EditFormWidget> createState() => _EditFormWidgetState();
}

class _EditFormWidgetState extends State<EditFormWidget> {
  late EditFormModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditFormModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          await action_blocks.exchangeTypeBlock(context);
          safeSetState(() {});
        }),
        Future(() async {
          if ((widget.orderJson?.flow == 'in') &&
              (widget.orderJson?.associatedOrder ==
                  '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')) {
            _model.outOrdersFromInEFOP =
                await TablesGroup.orderWarehouseTCall.call(
              orderWarehouseV: 'associated_order=eq.${widget.orderJson?.id}',
              userToken: currentJwtToken,
            );

            if ((_model.outOrdersFromInEFOP?.succeeded ?? true)) {
              FFAppState().editFormJsonList = functions
                  .joinJsons(widget.orderJson?.toMap(),
                      (_model.outOrdersFromInEFOP?.jsonBody ?? ''))!
                  .toList()
                  .cast<dynamic>();
              safeSetState(() {});
            }
          } else if (widget.orderJson?.flow == 'out') {
            _model.inOrderFromOutEFOP =
                await TablesGroup.orderWarehouseTCall.call(
              orderWarehouseV: 'id=eq.${widget.orderJson?.associatedOrder}',
              userToken: currentJwtToken,
            );

            if ((_model.inOrderFromOutEFOP?.succeeded ?? true)) {
              _model.outOrdersFromInFromOutEFOP =
                  await TablesGroup.orderWarehouseTCall.call(
                orderWarehouseV: 'associated_order=eq.${getJsonField(
                  (_model.inOrderFromOutEFOP?.jsonBody ?? ''),
                  r'''$[0].id
''',
                ).toString()}',
                userToken: currentJwtToken,
              );

              if ((_model.outOrdersFromInFromOutEFOP?.succeeded ?? true)) {
                FFAppState().editFormJsonList = functions
                    .joinJsons(
                        getJsonField(
                          (_model.inOrderFromOutEFOP?.jsonBody ?? ''),
                          r'''$[0]''',
                        ),
                        (_model.outOrdersFromInFromOutEFOP?.jsonBody ?? ''))!
                    .toList()
                    .cast<dynamic>();
                safeSetState(() {});
              }
            }
          } else if ((widget.orderJson?.flow == 'in') &&
              (widget.orderJson?.associatedOrder !=
                  '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')) {
            await Future.wait([
              Future(() async {
                _model.outPlusInOrdersFromInEFOP =
                    await TablesGroup.orderWarehouseTCall.call(
                  orderWarehouseV:
                      'associated_order=eq.${widget.orderJson?.associatedOrder}',
                  userToken: currentJwtToken,
                );
              }),
              Future(() async {
                _model.fatherOrderOP =
                    await TablesGroup.orderWarehouseTCall.call(
                  orderWarehouseV:
                      'id=eq.${widget.orderJson?.associatedOrder}',
                  userToken: currentJwtToken,
                );
              }),
            ]);
            if ((_model.outPlusInOrdersFromInEFOP?.succeeded ?? true) &&
                (_model.fatherOrderOP?.succeeded ?? true)) {
              FFAppState().editFormJsonList = functions
                  .joinJsons(
                      getJsonField(
                        (_model.fatherOrderOP?.jsonBody ?? ''),
                        r'''$[0]''',
                      ),
                      (_model.outPlusInOrdersFromInEFOP?.jsonBody ?? ''))!
                  .toList()
                  .cast<dynamic>();
              safeSetState(() {});
            }
          }

          _model.quantityBalance = await actions.quantityBalanceAction(
            FFAppState().editFormJsonList.toList(),
          );
          _model.quantityBalanceInt = _model.quantityBalance!;
          safeSetState(() {});
        }),
      ]);
    });

    _model.orderNoTFTextController ??=
        TextEditingController(text: widget.orderJson?.orderNo);
    _model.orderNoTFFocusNode ??= FocusNode();

    _model.intRefNoTFTextController ??=
        TextEditingController(text: widget.orderJson?.internalRefCustom);
    _model.intRefNoTFFocusNode ??= FocusNode();

    _model.intAccountingTFTextController ??=
        TextEditingController(text: widget.orderJson?.internalAccounting);
    _model.intAccountingTFFocusNode ??= FocusNode();

    _model.loadingSequenceTFTextController ??= TextEditingController(
        text: widget.orderJson?.loadingSequence.toString());
    _model.loadingSequenceTFFocusNode ??= FocusNode();

    _model.licencePlateTFTextController ??=
        TextEditingController(text: widget.orderJson?.licencePlate);
    _model.licencePlateTFFocusNode ??= FocusNode();

    _model.containerTFTextController ??=
        TextEditingController(text: widget.orderJson?.containerNo);
    _model.containerTFFocusNode ??= FocusNode();

    _model.unitTFTextController ??=
        TextEditingController(text: widget.orderJson?.unit.toString());
    _model.unitTFFocusNode ??= FocusNode();

    _model.weightTFTextController ??=
        TextEditingController(text: widget.orderJson?.weight.toString());
    _model.weightTFFocusNode ??= FocusNode();

    _model.quantityTFTextController ??=
        TextEditingController(text: widget.orderJson?.quantity.toString());
    _model.quantityTFFocusNode ??= FocusNode();

    _model.palletPositionTTextController ??= TextEditingController(
        text: widget.orderJson?.palletPosition.toString());
    _model.palletPositionTFocusNode ??= FocusNode();

    _model.comentTTextController ??=
        TextEditingController(text: widget.orderJson?.comment);
    _model.comentTFocusNode ??= FocusNode();

    _model.universalRefNumTFTextController ??=
        TextEditingController(text: widget.orderJson?.universalRefNo);
    _model.universalRefNumTFFocusNode ??= FocusNode();

    _model.fmsRefTFTextController ??=
        TextEditingController(text: widget.orderJson?.fmsRef);
    _model.fmsRefTFFocusNode ??= FocusNode();

    _model.loaRefDvhTFTextController ??=
        TextEditingController(text: widget.orderJson?.loadRefDvh);
    _model.loaRefDvhTFFocusNode ??= FocusNode();

    _model.barcodesTFTextController ??= TextEditingController();
    _model.barcodesTFFocusNode ??= FocusNode();

    _model.barcodes2TFTextController ??= TextEditingController(
        text: functions.joinStrings(widget.orderJson!.barcodes.toList()));
    _model.barcodes2TFFocusNode ??= FocusNode();

    _model.repeatedbarcodesTTextController ??= TextEditingController(
        text: functions
            .joinStrings(widget.orderJson!.repeatedBarcodes.toList()));
    _model.repeatedbarcodesTFocusNode ??= FocusNode();

    _model.nonExistentBarcodesTTextController ??= TextEditingController(
        text: functions.joinStrings(widget.orderJson!.noBarcodes.toList()));
    _model.nonExistentBarcodesTFocusNode ??= FocusNode();

    _model.taricCodeTFTextController ??=
        TextEditingController(text: widget.orderJson?.taricCode);
    _model.taricCodeTFFocusNode ??= FocusNode();

    _model.customPercentageTFTextController ??= TextEditingController(
        text: (100 * widget.orderJson!.customsPercentage).toString());
    _model.customPercentageTFFocusNode ??= FocusNode();

    _model.initCostTFTextController ??=
        TextEditingController(text: widget.orderJson?.initCost.toString());
    _model.initCostTFFocusNode ??= FocusNode();

    _model.quantityBalanceTFFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<InsuranceThresholdRow>>(
      future: InsuranceThresholdTable().querySingleRow(
        queryFn: (q) => q.order('created_at'),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<InsuranceThresholdRow> editFormInsuranceThresholdRowList =
            snapshot.data!;

        final editFormInsuranceThresholdRow =
            editFormInsuranceThresholdRowList.isNotEmpty
                ? editFormInsuranceThresholdRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: FutureBuilder<List<UsersRow>>(
                future: UsersTable().queryRows(
                  queryFn: (q) => q,
                ),
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
                  List<UsersRow> containerUsersRowList = snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: ((widget.orderJson?.flow ==
                                              'out') &&
                                          (widget.orderJson?.associatedOrder ==
                                              '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b'))
                                      ? null
                                      : () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: AssociateQueryWidget(
                                                    yesP: () async {
                                                      _model.insertedRowOP =
                                                          await OrderLevelTable()
                                                              .insert({
                                                        'order_no':
                                                            valueOrDefault<
                                                                String>(
                                                          widget.orderJson!
                                                              .orderNo
                                                              .substring(
                                                                  0,
                                                                  widget
                                                                          .orderJson!
                                                                          .orderNo
                                                                          .length -
                                                                      3),
                                                          '/',
                                                        ),
                                                        'quantity': 1,
                                                        'pallet_position':
                                                            widget.orderJson
                                                                ?.palletPosition,
                                                        'unit': widget
                                                            .orderJson?.details,
                                                        'weight': widget
                                                            .orderJson?.weight,
                                                        'good': widget
                                                            .orderJson?.good,
                                                        'good_description':
                                                            widget.orderJson
                                                                ?.goodDescription,
                                                        'packaging': widget
                                                            .orderJson
                                                            ?.packaging,
                                                        'barcodes': FFAppState()
                                                            .emptyList,
                                                        'no_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'received_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'repeated_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'container_no': widget
                                                            .orderJson
                                                            ?.containerNo,
                                                        'client': widget
                                                            .orderJson?.client,
                                                        'inv_status': 'najava',
                                                        'order_status':
                                                            'novo naročilo',
                                                        'admin': currentUserUid,
                                                        'warehouse': widget
                                                            .orderJson
                                                            ?.warehouse,
                                                        'fms_ref': widget
                                                            .orderJson?.fmsRef,
                                                        'load_ref_dvh': widget
                                                            .orderJson
                                                            ?.loadRefDvh,
                                                        'universal_ref_no':
                                                            widget.orderJson
                                                                ?.universalRefNo,
                                                        'documents':
                                                            FFAppState()
                                                                .emptyList,
                                                        'flow': 'out',
                                                        'eta_i': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'eta_f': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'arrival': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'start': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'stop': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'custom': widget
                                                            .orderJson?.custom,
                                                        'associated_order': () {
                                                          if (widget.orderJson
                                                                  ?.flow ==
                                                              'in') {
                                                            return ((widget.orderJson?.associatedOrder !=
                                                                            null &&
                                                                        widget.orderJson
                                                                                ?.associatedOrder !=
                                                                            '') &&
                                                                    (widget.orderJson
                                                                            ?.associatedOrder !=
                                                                        '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')
                                                                ? widget
                                                                    .orderJson
                                                                    ?.associatedOrder
                                                                : widget
                                                                    .orderJson
                                                                    ?.id);
                                                          } else if (widget
                                                                  .orderJson
                                                                  ?.flow ==
                                                              'out') {
                                                            return widget
                                                                .orderJson
                                                                ?.associatedOrder;
                                                          } else {
                                                            return '';
                                                          }
                                                        }(),
                                                        'taric_code': widget
                                                            .orderJson
                                                            ?.taricCode,
                                                        'customs_percentage':
                                                            widget.orderJson
                                                                ?.customsPercentage,
                                                        'euro_or_dolar': widget
                                                            .orderJson
                                                            ?.euroOrDolar,
                                                        'exchange_rate_used':
                                                            widget.orderJson
                                                                ?.exchangeRateUsed,
                                                        'init_cost': 0.0,
                                                        'exchanged_cost': 0.0,
                                                        'value_per_unit': 0.0,
                                                        'custom_percentage_per_cost':
                                                            0.0,
                                                        'acumulated_customs_percentages':
                                                            0.0,
                                                        'current_customs_warranty':
                                                            editFormInsuranceThresholdRow
                                                                ?.lastInsuranceThreshold,
                                                        'remaining_customs_threshold':
                                                            0.0,
                                                        'dolars': 0.0,
                                                        'euros': 0.0,
                                                        'internal_ref_custom':
                                                            '',
                                                        'weight_balance': 0.0,
                                                        'group_consumed_threshold':
                                                            0.0,
                                                      });
                                                      _model.refreshRowOP =
                                                          await TablesGroup
                                                              .refreshOrderLevelCalculatedColumnsCall
                                                              .call(
                                                        rowId: _model
                                                            .insertedRowOP?.id,
                                                        userToken:
                                                            currentJwtToken,
                                                      );

                                                      if ((_model.refreshRowOP
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'out row created!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Refresh row error.',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }

                                                      if ((widget.viewFrom ==
                                                              '/orderWarehouse') ||
                                                          (widget.viewFrom ==
                                                              '/')) {
                                                        context.pushNamed(
                                                            OrderWarehouseWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/warehouse2') {
                                                        context.pushNamed(
                                                            Warehouse2Widget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/customs') {
                                                        context.pushNamed(
                                                            CustomsViewWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/calendar') {
                                                        context.pushNamed(
                                                            CalendarWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/reports') {
                                                        context.pushNamed(
                                                            ReportsWidget
                                                                .routeName);
                                                      }
                                                    },
                                                    noP: () async {
                                                      _model.insertedRow2OP =
                                                          await OrderLevelTable()
                                                              .insert({
                                                        'order_no':
                                                            valueOrDefault<
                                                                String>(
                                                          widget.orderJson!
                                                              .orderNo
                                                              .substring(
                                                                  0,
                                                                  widget
                                                                          .orderJson!
                                                                          .orderNo
                                                                          .length -
                                                                      3),
                                                          '/',
                                                        ),
                                                        'quantity': 1,
                                                        'pallet_position':
                                                            widget.orderJson
                                                                ?.palletPosition,
                                                        'unit': widget
                                                            .orderJson?.details,
                                                        'weight': widget
                                                            .orderJson?.weight,
                                                        'good': widget
                                                            .orderJson?.good,
                                                        'good_description':
                                                            widget.orderJson
                                                                ?.goodDescription,
                                                        'packaging': widget
                                                            .orderJson
                                                            ?.packaging,
                                                        'barcodes': FFAppState()
                                                            .emptyList,
                                                        'no_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'received_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'repeated_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'container_no': widget
                                                            .orderJson
                                                            ?.containerNo,
                                                        'client': widget
                                                            .orderJson?.client,
                                                        'inv_status': 'najava',
                                                        'order_status':
                                                            'novo naročilo',
                                                        'admin': currentUserUid,
                                                        'warehouse': widget
                                                            .orderJson
                                                            ?.warehouse,
                                                        'fms_ref': widget
                                                            .orderJson?.fmsRef,
                                                        'load_ref_dvh': widget
                                                            .orderJson
                                                            ?.loadRefDvh,
                                                        'universal_ref_no':
                                                            widget.orderJson
                                                                ?.universalRefNo,
                                                        'documents':
                                                            FFAppState()
                                                                .emptyList,
                                                        'flow': 'out',
                                                        'eta_i': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'eta_f': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'arrival': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'start': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'stop': supaSerialize<
                                                                PostgresTime>(
                                                            PostgresTime(functions
                                                                .stringToDateTime(
                                                                    '00:00'))),
                                                        'custom': widget
                                                            .orderJson?.custom,
                                                        'associated_order':
                                                            '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b',
                                                        'taric_code': widget
                                                            .orderJson
                                                            ?.taricCode,
                                                        'customs_percentage':
                                                            widget.orderJson
                                                                ?.customsPercentage,
                                                        'euro_or_dolar': widget
                                                            .orderJson
                                                            ?.euroOrDolar,
                                                        'exchange_rate_used':
                                                            widget.orderJson
                                                                ?.exchangeRateUsed,
                                                        'init_cost': widget
                                                            .orderJson
                                                            ?.initCost,
                                                        'exchanged_cost':
                                                            widget.orderJson
                                                                ?.exchangedCost,
                                                        'value_per_unit':
                                                            widget.orderJson
                                                                ?.valuePerUnit,
                                                        'custom_percentage_per_cost':
                                                            widget.orderJson
                                                                ?.customPercentagePerCost,
                                                        'acumulated_customs_percentages':
                                                            widget.orderJson
                                                                ?.acumulatedCustomsPercentages,
                                                        'current_customs_warranty':
                                                            editFormInsuranceThresholdRow
                                                                ?.lastInsuranceThreshold,
                                                        'remaining_customs_threshold':
                                                            widget.orderJson
                                                                ?.remainingCustomsThreshold,
                                                        'dolars': 0.0,
                                                        'euros': 0.0,
                                                        'internal_ref_custom':
                                                            '',
                                                        'weight_balance': 0.0,
                                                        'group_consumed_threshold':
                                                            0.0,
                                                      });
                                                      _model.refreshRow2OP =
                                                          await TablesGroup
                                                              .refreshOrderLevelCalculatedColumnsCall
                                                              .call(
                                                        rowId: _model
                                                            .insertedRow2OP?.id,
                                                        userToken:
                                                            currentJwtToken,
                                                      );

                                                      if ((_model.refreshRow2OP
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'out row created!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Refresh row error.',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }

                                                      if ((widget.viewFrom ==
                                                              '/orderWarehouse') ||
                                                          (widget.viewFrom ==
                                                              '/')) {
                                                        context.pushNamed(
                                                            OrderWarehouseWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/warehouse2') {
                                                        context.pushNamed(
                                                            Warehouse2Widget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/customs') {
                                                        context.pushNamed(
                                                            CustomsViewWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/calendar') {
                                                        context.pushNamed(
                                                            CalendarWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/reports') {
                                                        context.pushNamed(
                                                            ReportsWidget
                                                                .routeName);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          safeSetState(() {});
                                        },
                                  text: FFLocalizations.of(context).getText(
                                    'riant0t5' /* CREATE - OUT ORDER */,
                                  ),
                                  icon: Icon(
                                    Icons.content_copy_sharp,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: ((widget.orderJson?.flow ==
                                              'out') &&
                                          (widget.orderJson?.associatedOrder ==
                                              '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b'))
                                      ? null
                                      : () async {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: SureQueryWidget(
                                                    saveChangesP: () async {
                                                      _model.insertedRowOPCopy =
                                                          await OrderLevelTable()
                                                              .insert({
                                                        'order_no':
                                                            valueOrDefault<
                                                                String>(
                                                          widget.orderJson!
                                                              .orderNo
                                                              .substring(
                                                                  0,
                                                                  widget
                                                                          .orderJson!
                                                                          .orderNo
                                                                          .length -
                                                                      3),
                                                          '/',
                                                        ),
                                                        'quantity': 1,
                                                        'pallet_position':
                                                            widget.orderJson
                                                                ?.palletPosition,
                                                        'unit': widget
                                                            .orderJson?.details,
                                                        'good': widget
                                                            .orderJson?.good,
                                                        'packaging': widget
                                                            .orderJson
                                                            ?.packaging,
                                                        'barcodes': FFAppState()
                                                            .emptyList,
                                                        'no_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'received_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'repeated_barcodes':
                                                            FFAppState()
                                                                .emptyList,
                                                        'client': widget
                                                            .orderJson?.client,
                                                        'order_status':
                                                            'novo naročilo',
                                                        'warehouse': widget
                                                            .orderJson
                                                            ?.warehouse,
                                                        'fms_ref': widget
                                                            .orderJson?.fmsRef,
                                                        'load_ref_dvh': widget
                                                            .orderJson
                                                            ?.loadRefDvh,
                                                        'universal_ref_no':
                                                            widget.orderJson
                                                                ?.universalRefNo,
                                                        'documents':
                                                            FFAppState()
                                                                .emptyList,
                                                        'flow': 'in',
                                                        'custom': widget
                                                            .orderJson?.custom,
                                                        'associated_order': () {
                                                          if (widget.orderJson
                                                                  ?.flow ==
                                                              'in') {
                                                            return ((widget.orderJson?.associatedOrder !=
                                                                            null &&
                                                                        widget.orderJson
                                                                                ?.associatedOrder !=
                                                                            '') &&
                                                                    (widget.orderJson
                                                                            ?.associatedOrder !=
                                                                        '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')
                                                                ? widget
                                                                    .orderJson
                                                                    ?.associatedOrder
                                                                : widget
                                                                    .orderJson
                                                                    ?.id);
                                                          } else if (widget
                                                                  .orderJson
                                                                  ?.flow ==
                                                              'out') {
                                                            return widget
                                                                .orderJson
                                                                ?.associatedOrder;
                                                          } else {
                                                            return '';
                                                          }
                                                        }(),
                                                        'taric_code': widget
                                                            .orderJson
                                                            ?.taricCode,
                                                        'customs_percentage':
                                                            widget.orderJson
                                                                ?.customsPercentage,
                                                        'exchange_rate_used':
                                                            widget.orderJson
                                                                ?.exchangeRateUsed,
                                                        'init_cost': 0.0,
                                                        'exchanged_cost': 0.0,
                                                        'value_per_unit': 0.0,
                                                        'custom_percentage_per_cost':
                                                            0.0,
                                                        'acumulated_customs_percentages':
                                                            0.0,
                                                        'current_customs_warranty':
                                                            editFormInsuranceThresholdRow
                                                                ?.lastInsuranceThreshold,
                                                        'remaining_customs_threshold':
                                                            0.0,
                                                        'dolars': 0.0,
                                                        'euros': 0.0,
                                                        'internal_ref_custom':
                                                            '',
                                                        'weight_balance': 0.0,
                                                        'group_consumed_threshold':
                                                            0.0,
                                                      });
                                                      _model.refreshRowOPCopy3 =
                                                          await TablesGroup
                                                              .refreshOrderLevelCalculatedColumnsCall
                                                              .call(
                                                        rowId: _model
                                                            .insertedRowOPCopy
                                                            ?.id,
                                                        userToken:
                                                            currentJwtToken,
                                                      );

                                                      if ((_model
                                                              .refreshRowOPCopy3
                                                              ?.succeeded ??
                                                          true)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'In row created!',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Refresh row error.',
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }

                                                      if ((widget.viewFrom ==
                                                              '/orderWarehouse') ||
                                                          (widget.viewFrom ==
                                                              '/')) {
                                                        context.pushNamed(
                                                            OrderWarehouseWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/warehouse2') {
                                                        context.pushNamed(
                                                            Warehouse2Widget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/customs') {
                                                        context.pushNamed(
                                                            CustomsViewWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/calendar') {
                                                        context.pushNamed(
                                                            CalendarWidget
                                                                .routeName);
                                                      } else if (widget
                                                              .viewFrom ==
                                                          '/reports') {
                                                        context.pushNamed(
                                                            ReportsWidget
                                                                .routeName);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          safeSetState(() {});
                                        },
                                  text: FFLocalizations.of(context).getText(
                                    'xc2ice4w' /* CREATE -IN ORDER */,
                                  ),
                                  icon: Icon(
                                    Icons.content_copy_sharp,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 1.0,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 32.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        8.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          860.0,
                                                                      height:
                                                                          306.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'p35ma2oq' /* Order no */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Container(
                                                                                          width: 220.0,
                                                                                          child: TextFormField(
                                                                                            controller: _model.orderNoTFTextController,
                                                                                            focusNode: _model.orderNoTFFocusNode,
                                                                                            autofocus: false,
                                                                                            obscureText: false,
                                                                                            decoration: InputDecoration(
                                                                                              isDense: true,
                                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              enabledBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: Color(0x00000000),
                                                                                                  width: 0.0,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                              ),
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                                  width: 0.0,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                              ),
                                                                                              errorBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                  width: 0.0,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                              ),
                                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                                borderSide: BorderSide(
                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                  width: 0.0,
                                                                                                ),
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                              ),
                                                                                              filled: true,
                                                                                              fillColor: Color(0xFFD1E5F6),
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                                  fontSize: 14.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                ),
                                                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                            validator: _model.orderNoTFTextControllerValidator.asValidator(context),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            't5e7aqi8' /* Client: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          child: custom_widgets.ClientTFDD(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            clientList: FFAppState().clientList,
                                                                                            borderWidth: 1.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            radiusTopLeft: 4.0,
                                                                                            radiusTopRight: 4.0,
                                                                                            radiusBottomLeft: 4.0,
                                                                                            radiusBottomRight: 4.0,
                                                                                            dropdownMaxHeight: 34.0,
                                                                                            initialText: widget.orderJson?.clientName,
                                                                                            initialId: widget.orderJson?.client,
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
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'icy19fot' /* Flow: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: FlutterFlowDropDown<String>(
                                                                                          controller: _model.flowDDValueController ??= FormFieldController<String>(
                                                                                            _model.flowDDValue ??= widget.orderJson?.flow,
                                                                                          ),
                                                                                          options: [
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'fqm22pzs' /* in */,
                                                                                            ),
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'fs6cejc5' /* out */,
                                                                                            )
                                                                                          ],
                                                                                          onChanged: (val) => safeSetState(() => _model.flowDDValue = val),
                                                                                          width: 200.0,
                                                                                          height: 36.0,
                                                                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                          icon: Icon(
                                                                                            Icons.keyboard_arrow_down_rounded,
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          elevation: 2.0,
                                                                                          borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                          borderWidth: 1.0,
                                                                                          borderRadius: 4.0,
                                                                                          margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                          hidesUnderline: true,
                                                                                          isSearchable: false,
                                                                                          isMultiSelect: false,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '3uam36q8' /* Estimated arrival: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 170.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                              child: AutoSizeText(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.estimatedArrival != null
                                                                                                      ? dateTimeFormat(
                                                                                                          "yMd",
                                                                                                          _model.estimatedArrival,
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        )
                                                                                                      : dateTimeFormat(
                                                                                                          "d/M/y",
                                                                                                          functions.parsePostgresTimestamp(widget.orderJson!.etaDate2),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                  'Select date',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              _model.estimatedArrival = await actions.selectDate(
                                                                                                context,
                                                                                              );

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'evbzfwpc' /*  */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.calendar_month,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: 36.0,
                                                                                              height: 36.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconAlignment: IconAlignment.start,
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: Colors.white,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 0.0,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 16.0)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'x6cazg9f' /* Order status: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.orderStatusDDValueController ??= FormFieldController<String>(
                                                                                          _model.orderStatusDDValue ??= widget.orderJson?.orderStatus,
                                                                                        ),
                                                                                        options: [
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'zcc13gj7' /* novo naročilo */,
                                                                                          ),
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '2uf6hfin' /* izvajanje */,
                                                                                          ),
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '17g7f98a' /* zaključeno */,
                                                                                          )
                                                                                        ],
                                                                                        onChanged: (val) => safeSetState(() => _model.orderStatusDDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: false,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'lydepu4j' /* Warehouse: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FutureBuilder<List<WarehousesRow>>(
                                                                                        future: WarehousesTable().queryRows(
                                                                                          queryFn: (q) => q,
                                                                                        ),
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
                                                                                          List<WarehousesRow> warehouseDDWarehousesRowList = snapshot.data!;

                                                                                          return FlutterFlowDropDown<String>(
                                                                                            controller: _model.warehouseDDValueController ??= FormFieldController<String>(
                                                                                              _model.warehouseDDValue ??= widget.orderJson?.warehouse,
                                                                                            ),
                                                                                            options: List<String>.from(warehouseDDWarehousesRowList.map((e) => e.id).toList()),
                                                                                            optionLabels: warehouseDDWarehousesRowList.map((e) => e.warehouse).toList(),
                                                                                            onChanged: (val) => safeSetState(() => _model.warehouseDDValue = val),
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            icon: Icon(
                                                                                              Icons.keyboard_arrow_down_rounded,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            elevation: 2.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                            borderWidth: 1.0,
                                                                                            borderRadius: 4.0,
                                                                                            margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                            hidesUnderline: true,
                                                                                            isSearchable: false,
                                                                                            isMultiSelect: false,
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'oahcxkmo' /* Creation date: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 170.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                              child: AutoSizeText(
                                                                                                _model.creationDate != null
                                                                                                    ? dateTimeFormat(
                                                                                                        "yMd",
                                                                                                        _model.creationDate,
                                                                                                        locale: FFLocalizations.of(context).languageCode,
                                                                                                      )
                                                                                                    : dateTimeFormat(
                                                                                                        "yMd",
                                                                                                        functions.parsePostgresTimestamp(widget.orderJson!.createdAt2),
                                                                                                        locale: FFLocalizations.of(context).languageCode,
                                                                                                      ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              _model.creationDate = await actions.selectDate(
                                                                                                context,
                                                                                              );

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'i6vs95ib' /*  */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.calendar_month,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: 36.0,
                                                                                              height: 36.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconAlignment: IconAlignment.start,
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                              iconColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: Colors.white,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 0.0,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 16.0)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'zrdnqyb3' /* Admin: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.adminDDValueController ??= FormFieldController<String>(
                                                                                          _model.adminDDValue ??= widget.orderJson?.admin,
                                                                                        ),
                                                                                        options: List<String>.from(containerUsersRowList.map((e) => e.id).toList()),
                                                                                        optionLabels: containerUsersRowList.map((e) => e.lastName).toList(),
                                                                                        onChanged: (val) => safeSetState(() => _model.adminDDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchHintText: FFLocalizations.of(context).getText(
                                                                                          'rlqjtc4b' /*  */,
                                                                                        ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: true,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '10h2hpka' /* Custom: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FutureBuilder<List<CustomsRow>>(
                                                                                        future: CustomsTable().queryRows(
                                                                                          queryFn: (q) => q,
                                                                                        ),
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
                                                                                          List<CustomsRow> customDDCustomsRowList = snapshot.data!;

                                                                                          return FlutterFlowDropDown<String>(
                                                                                            controller: _model.customDDValueController ??= FormFieldController<String>(
                                                                                              _model.customDDValue ??= widget.orderJson?.custom,
                                                                                            ),
                                                                                            options: List<String>.from(customDDCustomsRowList.map((e) => e.id).toList()),
                                                                                            optionLabels: customDDCustomsRowList.map((e) => e.custom).toList(),
                                                                                            onChanged: (val) => safeSetState(() => _model.customDDValue = val),
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            searchHintText: FFLocalizations.of(context).getText(
                                                                                              '65gey00l' /* Search for an item... */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.keyboard_arrow_down_rounded,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            elevation: 2.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                            borderWidth: 1.0,
                                                                                            borderRadius: 4.0,
                                                                                            margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                            hidesUnderline: true,
                                                                                            isSearchable: true,
                                                                                            isMultiSelect: false,
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: AutoSizeText(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'l6nrr7m1' /* Internal reference number cust... */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.intRefNoTFTextController,
                                                                                              focusNode: _model.intRefNoTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.intRefNoTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: AutoSizeText(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'd2zkrsus' /* Internal accounting: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.intAccountingTFTextController,
                                                                                              focusNode: _model.intAccountingTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.intAccountingTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: AutoSizeText(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'u7o35oz5' /* Documents: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Builder(
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
                                                                                                  insetPadding: EdgeInsets.zero,
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                  child: GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(dialogContext).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: DocumentsWidget(
                                                                                                      orderId: widget.orderJson!.id,
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          child: Container(
                                                                                            width: 218.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                width: 2.0,
                                                                                              ),
                                                                                            ),
                                                                                            child: Icon(
                                                                                              Icons.edit_document,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 16.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFB8E1F6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.announcement_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '5xqh9mmb' /* Announcement */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        8.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          860.0,
                                                                      height:
                                                                          306.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'xo6c2pvl' /* Inventory status: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: FlutterFlowDropDown<String>(
                                                                                          controller: _model.inventoryStatusDDValueController ??= FormFieldController<String>(
                                                                                            _model.inventoryStatusDDValue ??= widget.orderJson?.invStatus,
                                                                                          ),
                                                                                          options: [
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'dqgnwmgd' /* najava */,
                                                                                            ),
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'y332fji4' /* obdelava */,
                                                                                            ),
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '5xa85p2k' /* izdano */,
                                                                                            ),
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '7s4qp2ow' /* zaloga */,
                                                                                            )
                                                                                          ],
                                                                                          onChanged: (val) => safeSetState(() => _model.inventoryStatusDDValue = val),
                                                                                          width: 200.0,
                                                                                          height: 36.0,
                                                                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                          icon: Icon(
                                                                                            Icons.keyboard_arrow_down_rounded,
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          elevation: 2.0,
                                                                                          borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                          borderWidth: 1.0,
                                                                                          borderRadius: 4.0,
                                                                                          margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                          hidesUnderline: true,
                                                                                          isSearchable: false,
                                                                                          isMultiSelect: false,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'w9hz2gff' /* Announced time 1: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 168.0,
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                                border: Border.all(
                                                                                                  color: FlutterFlowTheme.of(context).accent1,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                              ),
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  valueOrDefault<String>(
                                                                                                    _model.announcedTime1 != null
                                                                                                        ? dateTimeFormat(
                                                                                                            "Hm",
                                                                                                            _model.announcedTime1,
                                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                                          )
                                                                                                        : dateTimeFormat(
                                                                                                            "Hm",
                                                                                                            functions.parsePostgresTimestamp(widget.orderJson!.etaI2),
                                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                                          ),
                                                                                                    'Select time',
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            FFButtonWidget(
                                                                                              onPressed: () async {
                                                                                                _model.announcedTime1 = await actions.selectTime(
                                                                                                  context,
                                                                                                );

                                                                                                safeSetState(() {});
                                                                                              },
                                                                                              text: FFLocalizations.of(context).getText(
                                                                                                'g5k2sbou' /*  */,
                                                                                              ),
                                                                                              icon: Icon(
                                                                                                Icons.calendar_month,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                              options: FFButtonOptions(
                                                                                                width: 36.0,
                                                                                                height: 36.0,
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                iconAlignment: IconAlignment.start,
                                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      color: Colors.white,
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                elevation: 0.0,
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 16.0)),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '4wbu8b97' /* Arrival: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 168.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                              child: AutoSizeText(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.arrivalTime != null
                                                                                                      ? dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          _model.arrivalTime,
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        )
                                                                                                      : dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          functions.parsePostgresTimestamp(widget.orderJson!.arrival2),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                  'Select time',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              _model.arrivalTime = await actions.selectTime(
                                                                                                context,
                                                                                              );

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'rqhn41x1' /*  */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.calendar_month,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: 36.0,
                                                                                              height: 36.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconAlignment: IconAlignment.start,
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: Colors.white,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 0.0,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 16.0)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'o33653rr' /* Loading gate: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FutureBuilder<List<LoadingGatesRow>>(
                                                                                        future: LoadingGatesTable().queryRows(
                                                                                          queryFn: (q) => q,
                                                                                        ),
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
                                                                                          List<LoadingGatesRow> loadingGateDDLoadingGatesRowList = snapshot.data!;

                                                                                          return FlutterFlowDropDown<String>(
                                                                                            controller: _model.loadingGateDDValueController ??= FormFieldController<String>(
                                                                                              _model.loadingGateDDValue ??= widget.orderJson?.loadingGate,
                                                                                            ),
                                                                                            options: List<String>.from(loadingGateDDLoadingGatesRowList.map((e) => e.id).toList()),
                                                                                            optionLabels: loadingGateDDLoadingGatesRowList.map((e) => e.ramp).toList(),
                                                                                            onChanged: (val) => safeSetState(() => _model.loadingGateDDValue = val),
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            icon: Icon(
                                                                                              Icons.keyboard_arrow_down_rounded,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            elevation: 2.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                            borderWidth: 1.0,
                                                                                            borderRadius: 4.0,
                                                                                            margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                            hidesUnderline: true,
                                                                                            isSearchable: false,
                                                                                            isMultiSelect: false,
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'fs3bib2p' /* Loading gate sequence: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.loadingSequenceTFTextController,
                                                                                              focusNode: _model.loadingSequenceTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.loadingSequenceTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'txvq28xk' /* Start (up/unload): */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 170.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.startTime != null
                                                                                                      ? dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          _model.startTime,
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        )
                                                                                                      : dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          functions.parsePostgresTimestamp(widget.orderJson!.start2),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                  'Select time',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              _model.startTime = await actions.selectTime(
                                                                                                context,
                                                                                              );

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'xiby4v3x' /*  */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.calendar_month,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: 36.0,
                                                                                              height: 36.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconAlignment: IconAlignment.start,
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: Colors.white,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 0.0,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 16.0)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'e7kuxjnl' /* Stop (up/unload): */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 170.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).accent1,
                                                                                                width: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.endTime != null
                                                                                                      ? dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          _model.endTime,
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        )
                                                                                                      : dateTimeFormat(
                                                                                                          "Hm",
                                                                                                          functions.parsePostgresTimestamp(widget.orderJson!.stop2),
                                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                                        ),
                                                                                                  'Select time',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          FFButtonWidget(
                                                                                            onPressed: () async {
                                                                                              _model.endTime = await actions.selectTime(
                                                                                                context,
                                                                                              );

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            text: FFLocalizations.of(context).getText(
                                                                                              'so066r6i' /*  */,
                                                                                            ),
                                                                                            icon: Icon(
                                                                                              Icons.calendar_month,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: 36.0,
                                                                                              height: 36.0,
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              iconAlignment: IconAlignment.start,
                                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: Colors.white,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 0.0,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 16.0)),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 16.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD0CCCC),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.timer_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'b9tuu7tv' /* Sequence, times */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 16.0))
                                                              .around(SizedBox(
                                                                  width: 16.0)),
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        8.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          860.0,
                                                                      height:
                                                                          376.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            40.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'xdjndp41' /* Licence plate No: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.licencePlateTFTextController,
                                                                                              focusNode: _model.licencePlateTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.licencePlateTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'cb2aepry' /* Improvement: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: FlutterFlowDropDown<String>(
                                                                                            controller: _model.improvementDDValueController ??= FormFieldController<String>(
                                                                                              _model.improvementDDValue ??= widget.orderJson?.improvement,
                                                                                            ),
                                                                                            options: [
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'zllit664' /* kont.-20" */,
                                                                                              ),
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'k3mnizes' /* kont.-40" */,
                                                                                              ),
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'f1siz9is' /* kont.-45" */,
                                                                                              ),
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'q2lbc0zu' /* cerada */,
                                                                                              ),
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '01kdxfmz' /* hladilnik */,
                                                                                              ),
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '8y6wmvw5' /* silos */,
                                                                                              )
                                                                                            ],
                                                                                            onChanged: (val) => safeSetState(() => _model.improvementDDValue = val),
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            icon: Icon(
                                                                                              Icons.keyboard_arrow_down_rounded,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            elevation: 2.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                            borderWidth: 1.0,
                                                                                            borderRadius: 4.0,
                                                                                            margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                            hidesUnderline: true,
                                                                                            isSearchable: false,
                                                                                            isMultiSelect: false,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '75pjdeo5' /* Container no: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.containerTFTextController,
                                                                                              focusNode: _model.containerTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.containerTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: AutoSizeText(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '8aidjqpy' /* Unit: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.unitTFTextController,
                                                                                              focusNode: _model.unitTFFocusNode,
                                                                                              autofocus: false,
                                                                                              readOnly: _model.barcodesCheckValue != null ? !_model.barcodesCheckValue! : false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              keyboardType: TextInputType.number,
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.unitTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: AutoSizeText(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'r13i81v0' /* Weight: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.weightTFTextController,
                                                                                              focusNode: _model.weightTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.weightTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 8.0)),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '7nsc6k9p' /* Quantity: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Container(
                                                                                                width: 220.0,
                                                                                                child: TextFormField(
                                                                                                  controller: _model.quantityTFTextController,
                                                                                                  focusNode: _model.quantityTFFocusNode,
                                                                                                  autofocus: false,
                                                                                                  obscureText: false,
                                                                                                  decoration: InputDecoration(
                                                                                                    isDense: true,
                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                                    ),
                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  keyboardType: TextInputType.number,
                                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                  validator: _model.quantityTFTextControllerValidator.asValidator(context),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'yeaed14k' /* Pallet position: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              child: TextFormField(
                                                                                                controller: _model.palletPositionTTextController,
                                                                                                focusNode: _model.palletPositionTFocusNode,
                                                                                                autofocus: false,
                                                                                                obscureText: false,
                                                                                                decoration: InputDecoration(
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).accent1,
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                                                validator: _model.palletPositionTTextControllerValidator.asValidator(context),
                                                                                                inputFormatters: [
                                                                                                  FilteringTextInputFormatter.allow(RegExp('^\\d*\\.?\\d*\$'))
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'wxzlnqbf' /* Pre-check: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  visualDensity: VisualDensity.compact,
                                                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                              ),
                                                                                              child: Checkbox(
                                                                                                value: _model.preCheckCBValue ??= widget.orderJson!.precheck,
                                                                                                onChanged: (newValue) async {
                                                                                                  safeSetState(() => _model.preCheckCBValue = newValue!);
                                                                                                },
                                                                                                side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                                    ? BorderSide(
                                                                                                        width: 2,
                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      )
                                                                                                    : null,
                                                                                                activeColor: FlutterFlowTheme.of(context).info,
                                                                                                checkColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: AutoSizeText(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '4e1cvs2n' /* Check: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Theme(
                                                                                              data: ThemeData(
                                                                                                checkboxTheme: CheckboxThemeData(
                                                                                                  visualDensity: VisualDensity.compact,
                                                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                ),
                                                                                                unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                              ),
                                                                                              child: Checkbox(
                                                                                                value: _model.checkCBValue ??= widget.orderJson!.checked,
                                                                                                onChanged: (newValue) async {
                                                                                                  safeSetState(() => _model.checkCBValue = newValue!);
                                                                                                },
                                                                                                side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                                    ? BorderSide(
                                                                                                        width: 2,
                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      )
                                                                                                    : null,
                                                                                                activeColor: FlutterFlowTheme.of(context).info,
                                                                                                checkColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 8.0)),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 16.0)),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Container(
                                                                                  width: 180.0,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: AutoSizeText(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      '4g6a9v3p' /* Comment: */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 658.0,
                                                                                  height: 100.0,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                  ),
                                                                                  child: TextFormField(
                                                                                    controller: _model.comentTTextController,
                                                                                    focusNode: _model.comentTFocusNode,
                                                                                    autofocus: false,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).accent1,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
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
                                                                                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    maxLines: 4,
                                                                                    validator: _model.comentTTextControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ].divide(SizedBox(height: 8.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFC2F6B8),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.directions_car,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'uacnewsy' /* Licence, quanitty */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        8.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          860.0,
                                                                      height:
                                                                          376.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'ligugf6y' /* Other manipulations: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: FutureBuilder<List<ManipulationsRow>>(
                                                                                          future: ManipulationsTable().queryRows(
                                                                                            queryFn: (q) => q,
                                                                                          ),
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
                                                                                            List<ManipulationsRow> otherManipulationsDDManipulationsRowList = snapshot.data!;

                                                                                            return FlutterFlowDropDown<String>(
                                                                                              controller: _model.otherManipulationsDDValueController ??= FormFieldController<String>(
                                                                                                _model.otherManipulationsDDValue ??= widget.orderJson?.otherManipulation,
                                                                                              ),
                                                                                              options: otherManipulationsDDManipulationsRowList.map((e) => e.manipulation).toList(),
                                                                                              onChanged: (val) => safeSetState(() => _model.otherManipulationsDDValue = val),
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              icon: Icon(
                                                                                                Icons.keyboard_arrow_down_rounded,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              elevation: 2.0,
                                                                                              borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                              borderWidth: 1.0,
                                                                                              borderRadius: 4.0,
                                                                                              margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                              hidesUnderline: true,
                                                                                              isSearchable: false,
                                                                                              isMultiSelect: false,
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '38nrigmd' /* Type of un/upload: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                      ),
                                                                                      Container(
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: FlutterFlowDropDown<String>(
                                                                                          controller: _model.loadingTypeDDValueController ??= FormFieldController<String>(
                                                                                            _model.loadingTypeDDValue ??= widget.orderJson?.loadingType,
                                                                                          ),
                                                                                          options: [
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '83ur13q8' /* viličar */,
                                                                                            ),
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '0vah8el6' /* ročno */,
                                                                                            )
                                                                                          ],
                                                                                          onChanged: (val) => safeSetState(() => _model.loadingTypeDDValue = val),
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                          icon: Icon(
                                                                                            Icons.keyboard_arrow_down_rounded,
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          elevation: 2.0,
                                                                                          borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                          borderWidth: 1.0,
                                                                                          borderRadius: 4.0,
                                                                                          margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                          hidesUnderline: true,
                                                                                          isSearchable: false,
                                                                                          isMultiSelect: false,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'wc9xhomy' /* Type of un/upload 2: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.loadingType2DDValueController ??= FormFieldController<String>(
                                                                                          _model.loadingType2DDValue ??= widget.orderJson?.loadingType2,
                                                                                        ),
                                                                                        options: [
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'rpbv21fo' /* viličar */,
                                                                                          ),
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'nl70dilf' /* ročno */,
                                                                                          )
                                                                                        ],
                                                                                        onChanged: (val) => safeSetState(() => _model.loadingType2DDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: false,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'jocyivud' /* Responsible: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.responsibleDDValueController ??= FormFieldController<String>(
                                                                                          _model.responsibleDDValue ??= widget.orderJson?.admin,
                                                                                        ),
                                                                                        options: List<String>.from(containerUsersRowList.map((e) => e.id).toList()),
                                                                                        optionLabels: containerUsersRowList.map((e) => e.lastName).toList(),
                                                                                        onChanged: (val) => safeSetState(() => _model.responsibleDDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchHintText: FFLocalizations.of(context).getText(
                                                                                          '9e38vwk7' /*  */,
                                                                                        ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: true,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '16na3oqv' /* Assistant 1: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.assistant1DDValueController ??= FormFieldController<String>(
                                                                                          _model.assistant1DDValue ??= widget.orderJson?.admin,
                                                                                        ),
                                                                                        options: List<String>.from(containerUsersRowList.map((e) => e.id).toList()),
                                                                                        optionLabels: containerUsersRowList.map((e) => e.lastName).toList(),
                                                                                        onChanged: (val) => safeSetState(() => _model.assistant1DDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchHintText: FFLocalizations.of(context).getText(
                                                                                          'cha0sezk' /*  */,
                                                                                        ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: true,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 180.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '0dhtifvc' /* Assistant 2: */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      FlutterFlowDropDown<String>(
                                                                                        controller: _model.assistant2DDValueController ??= FormFieldController<String>(
                                                                                          _model.assistant2DDValue ??= widget.orderJson?.admin,
                                                                                        ),
                                                                                        options: List<String>.from(containerUsersRowList.map((e) => e.id).toList()),
                                                                                        optionLabels: containerUsersRowList.map((e) => e.lastName).toList(),
                                                                                        onChanged: (val) => safeSetState(() => _model.assistant2DDValue = val),
                                                                                        width: 220.0,
                                                                                        height: 36.0,
                                                                                        searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                        searchHintText: FFLocalizations.of(context).getText(
                                                                                          'ceqo4vrm' /*  */,
                                                                                        ),
                                                                                        icon: Icon(
                                                                                          Icons.keyboard_arrow_down_rounded,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        elevation: 2.0,
                                                                                        borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                        borderWidth: 1.0,
                                                                                        borderRadius: 4.0,
                                                                                        margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                        hidesUnderline: true,
                                                                                        isSearchable: true,
                                                                                        isMultiSelect: false,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 8.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 16.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFD188EA),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.front_loader,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'ujth7i6r' /* Manipulations, load type */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 16.0))
                                                              .around(SizedBox(
                                                                  width: 16.0)),
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        8.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          860.0,
                                                                      height:
                                                                          536.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            40.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '7gy6tc9r' /* Universal ref No: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.universalRefNumTFTextController,
                                                                                              focusNode: _model.universalRefNumTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.universalRefNumTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'atq3v0jq' /* FMS ref: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.fmsRefTFTextController,
                                                                                              focusNode: _model.fmsRefTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.fmsRefTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'vya267g7' /* Load ref/dvh: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            child: TextFormField(
                                                                                              controller: _model.loaRefDvhTFTextController,
                                                                                              focusNode: _model.loaRefDvhTFFocusNode,
                                                                                              autofocus: false,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).accent1,
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderSide: BorderSide(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              validator: _model.loaRefDvhTFTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: AutoSizeText(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '2pyzpjsh' /* Good: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        FutureBuilder<List<GoodsRow>>(
                                                                                          future: GoodsTable().queryRows(
                                                                                            queryFn: (q) => q,
                                                                                          ),
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
                                                                                            List<GoodsRow> goodsDDGoodsRowList = snapshot.data!;

                                                                                            return FlutterFlowDropDown<String>(
                                                                                              controller: _model.goodsDDValueController ??= FormFieldController<String>(
                                                                                                _model.goodsDDValue ??= widget.orderJson?.good,
                                                                                              ),
                                                                                              options: List<String>.from(goodsDDGoodsRowList.map((e) => e.id).toList()),
                                                                                              optionLabels: goodsDDGoodsRowList.map((e) => e.item).toList(),
                                                                                              onChanged: (val) => safeSetState(() => _model.goodsDDValue = val),
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              searchHintText: FFLocalizations.of(context).getText(
                                                                                                'qso9uy3a' /*  */,
                                                                                              ),
                                                                                              icon: Icon(
                                                                                                Icons.keyboard_arrow_down_rounded,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              elevation: 2.0,
                                                                                              borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                              borderWidth: 1.0,
                                                                                              borderRadius: 4.0,
                                                                                              margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                              hidesUnderline: true,
                                                                                              isSearchable: true,
                                                                                              isMultiSelect: false,
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: AutoSizeText(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'eb67z9hu' /* Good description: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            child: custom_widgets.GoodDescriptionTFDD(
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              goodDescriptionList: FFAppState().goodDescriptionList,
                                                                                              borderWidth: 1.0,
                                                                                              borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              radiusTopLeft: 4.0,
                                                                                              radiusTopRight: 4.0,
                                                                                              radiusBottomLeft: 4.0,
                                                                                              radiusBottomRight: 4.0,
                                                                                              dropdownMaxHeight: 34.0,
                                                                                              initialText: widget.orderJson?.opisBlaga,
                                                                                              initialId: widget.orderJson?.goodDescription,
                                                                                              action: () async {
                                                                                                FFAppState().goodDescriptionApiB = true;
                                                                                                safeSetState(() {});
                                                                                                await action_blocks.goodDescriptionApiAction(context);
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
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 180.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: AutoSizeText(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'mdi3uwks' /* Packaging: */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Roboto',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: 220.0,
                                                                                          height: 36.0,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                            border: Border.all(
                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                              width: 1.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: FutureBuilder<List<PackagingRow>>(
                                                                                            future: PackagingTable().queryRows(
                                                                                              queryFn: (q) => q,
                                                                                            ),
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
                                                                                              List<PackagingRow> packagingDDPackagingRowList = snapshot.data!;

                                                                                              return FlutterFlowDropDown<String>(
                                                                                                controller: _model.packagingDDValueController ??= FormFieldController<String>(
                                                                                                  _model.packagingDDValue ??= widget.orderJson?.packaging,
                                                                                                ),
                                                                                                options: List<String>.from(packagingDDPackagingRowList.map((e) => e.id).toList()),
                                                                                                optionLabels: packagingDDPackagingRowList.map((e) => e.packaging).toList(),
                                                                                                onChanged: (val) => safeSetState(() => _model.packagingDDValue = val),
                                                                                                width: 220.0,
                                                                                                height: 36.0,
                                                                                                searchHintTextStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                searchHintText: FFLocalizations.of(context).getText(
                                                                                                  'tvjhe86k' /* Search for an item... */,
                                                                                                ),
                                                                                                icon: Icon(
                                                                                                  Icons.keyboard_arrow_down_rounded,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                elevation: 2.0,
                                                                                                borderColor: FlutterFlowTheme.of(context).accent1,
                                                                                                borderWidth: 1.0,
                                                                                                borderRadius: 4.0,
                                                                                                margin: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                hidesUnderline: true,
                                                                                                isSearchable: true,
                                                                                                isMultiSelect: false,
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 8.0)),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                            child: Container(
                                                                                              width: 180.0,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '2dxkqi3h' /* Barcodes: */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                  Theme(
                                                                                                    data: ThemeData(
                                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                                        visualDensity: VisualDensity.compact,
                                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                                        shape: RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                                        ),
                                                                                                      ),
                                                                                                      unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    ),
                                                                                                    child: Checkbox(
                                                                                                      value: _model.barcodesCheckValue ??= false,
                                                                                                      onChanged: (newValue) async {
                                                                                                        safeSetState(() => _model.barcodesCheckValue = newValue!);
                                                                                                      },
                                                                                                      side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                                          ? BorderSide(
                                                                                                              width: 2,
                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            )
                                                                                                          : null,
                                                                                                      activeColor: FlutterFlowTheme.of(context).info,
                                                                                                      checkColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              height: 260.0,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Stack(
                                                                                                children: [
                                                                                                  if (_model.barcodesCheckValue ?? true)
                                                                                                    Container(
                                                                                                      width: 220.0,
                                                                                                      child: TextFormField(
                                                                                                        controller: _model.barcodesTFTextController,
                                                                                                        focusNode: _model.barcodesTFFocusNode,
                                                                                                        autofocus: false,
                                                                                                        obscureText: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          isDense: true,
                                                                                                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                fontFamily: 'Roboto',
                                                                                                                letterSpacing: 0.0,
                                                                                                              ),
                                                                                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                fontFamily: 'Roboto',
                                                                                                                letterSpacing: 0.0,
                                                                                                              ),
                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                            borderSide: BorderSide(
                                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                                          ),
                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                            borderSide: BorderSide(
                                                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Roboto',
                                                                                                              letterSpacing: 0.0,
                                                                                                            ),
                                                                                                        maxLines: 18,
                                                                                                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                        validator: _model.barcodesTFTextControllerValidator.asValidator(context),
                                                                                                      ),
                                                                                                    ),
                                                                                                  if (!_model.barcodesCheckValue!)
                                                                                                    Container(
                                                                                                      width: 220.0,
                                                                                                      child: TextFormField(
                                                                                                        controller: _model.barcodes2TFTextController,
                                                                                                        focusNode: _model.barcodes2TFFocusNode,
                                                                                                        autofocus: false,
                                                                                                        readOnly: true,
                                                                                                        obscureText: false,
                                                                                                        decoration: InputDecoration(
                                                                                                          isDense: true,
                                                                                                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                fontFamily: 'Roboto',
                                                                                                                letterSpacing: 0.0,
                                                                                                              ),
                                                                                                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                fontFamily: 'Roboto',
                                                                                                                letterSpacing: 0.0,
                                                                                                              ),
                                                                                                          enabledBorder: OutlineInputBorder(
                                                                                                            borderSide: BorderSide(
                                                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                                          ),
                                                                                                          focusedBorder: OutlineInputBorder(
                                                                                                            borderSide: BorderSide(
                                                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Roboto',
                                                                                                              letterSpacing: 0.0,
                                                                                                            ),
                                                                                                        maxLines: 18,
                                                                                                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                        validator: _model.barcodes2TFTextControllerValidator.asValidator(context),
                                                                                                      ),
                                                                                                    ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 8.0)),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 16.0)),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 180.0,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        '2q7uvf6e' /* Repeated barcodes: */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 658.0,
                                                                                  height: 100.0,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                  ),
                                                                                  child: TextFormField(
                                                                                    controller: _model.repeatedbarcodesTTextController,
                                                                                    focusNode: _model.repeatedbarcodesTFocusNode,
                                                                                    autofocus: false,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).accent1,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
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
                                                                                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    maxLines: 4,
                                                                                    validator: _model.repeatedbarcodesTTextControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 180.0,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'k771zg40' /* Non-existent barcodes: */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 658.0,
                                                                                  height: 100.0,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                  ),
                                                                                  child: TextFormField(
                                                                                    controller: _model.nonExistentBarcodesTTextController,
                                                                                    focusNode: _model.nonExistentBarcodesTFocusNode,
                                                                                    autofocus: false,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).accent1,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
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
                                                                                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    maxLines: 4,
                                                                                    validator: _model.nonExistentBarcodesTTextControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ].divide(SizedBox(height: 8.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFF0A469),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.system_security_update_good,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'o8h14uy2' /* Goods, ref no, barcodes */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            8.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              860.0,
                                                                          height:
                                                                              536.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).accent1,
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              -1.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                16.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '5nirw5ip' /* Taric code: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              child: TextFormField(
                                                                                                controller: _model.taricCodeTFTextController,
                                                                                                focusNode: _model.taricCodeTFFocusNode,
                                                                                                autofocus: false,
                                                                                                obscureText: false,
                                                                                                decoration: InputDecoration(
                                                                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).accent1,
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                validator: _model.taricCodeTFTextControllerValidator.asValidator(context),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'q6jcs1pg' /* Customs %: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                          ),
                                                                                          Form(
                                                                                            key: _model.formKey,
                                                                                            autovalidateMode: AutovalidateMode.always,
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Container(
                                                                                                width: 220.0,
                                                                                                child: TextFormField(
                                                                                                  controller: _model.customPercentageTFTextController,
                                                                                                  focusNode: _model.customPercentageTFFocusNode,
                                                                                                  autofocus: false,
                                                                                                  obscureText: false,
                                                                                                  decoration: InputDecoration(
                                                                                                    labelText: FFLocalizations.of(context).getText(
                                                                                                      'pocise0n' /* Velue between 0 and 100 */,
                                                                                                    ),
                                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: FlutterFlowTheme.of(context).accent1,
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                                    ),
                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                      borderSide: BorderSide(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  validator: _model.customPercentageTFTextControllerValidator.asValidator(context),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'bpmbjzyh' /* Cost: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              child: TextFormField(
                                                                                                controller: _model.initCostTFTextController,
                                                                                                focusNode: _model.initCostTFFocusNode,
                                                                                                autofocus: false,
                                                                                                obscureText: false,
                                                                                                decoration: InputDecoration(
                                                                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).accent1,
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
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
                                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                                                validator: _model.initCostTFTextControllerValidator.asValidator(context),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '08wyvwkn' /* Quantity balance: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                                border: Border.all(
                                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    _model.quantityBalanceInt.toString(),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'we5y2zhm' /* Insurance Threshold: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              child: TextFormField(
                                                                                                controller: _model.quantityBalanceTFTextController ??= TextEditingController(
                                                                                                  text: editFormInsuranceThresholdRow?.lastInsuranceThreshold.toString(),
                                                                                                ),
                                                                                                focusNode: _model.quantityBalanceTFFocusNode,
                                                                                                autofocus: false,
                                                                                                readOnly: true,
                                                                                                obscureText: false,
                                                                                                decoration: InputDecoration(
                                                                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      width: 2.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      width: 2.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  errorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                                      width: 2.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                                      width: 2.0,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                  filled: true,
                                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                validator: _model.quantityBalanceTFTextControllerValidator.asValidator(context),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 8.0)),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'z4edj20n' /* Currency: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: 220.0,
                                                                                            height: 36.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: FlutterFlowChoiceChips(
                                                                                              options: [
                                                                                                ChipData(FFLocalizations.of(context).getText(
                                                                                                  'pn7uysyl' /* Dolar */,
                                                                                                )),
                                                                                                ChipData(FFLocalizations.of(context).getText(
                                                                                                  'hyw891z0' /* Euro */,
                                                                                                ))
                                                                                              ],
                                                                                              onChanged: (val) => safeSetState(() => _model.currencyCCValue = val?.firstOrNull),
                                                                                              selectedChipStyle: ChipStyle(
                                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                iconColor: FlutterFlowTheme.of(context).info,
                                                                                                iconSize: 16.0,
                                                                                                elevation: 0.0,
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                              unselectedChipStyle: ChipStyle(
                                                                                                backgroundColor: FlutterFlowTheme.of(context).accent4,
                                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Roboto',
                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                                iconColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                iconSize: 16.0,
                                                                                                elevation: 0.0,
                                                                                                borderColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                              ),
                                                                                              chipSpacing: 8.0,
                                                                                              rowSpacing: 8.0,
                                                                                              multiselect: false,
                                                                                              initialized: _model.currencyCCValue != null,
                                                                                              alignment: WrapAlignment.start,
                                                                                              controller: _model.currencyCCValueController ??= FormFieldController<List<String>>(
                                                                                                [
                                                                                                  widget.orderJson!.euroOrDolar
                                                                                                ],
                                                                                              ),
                                                                                              wrapped: true,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'jyjqxyg3' /* Exchange rate: */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                                border: Border.all(
                                                                                                  color: FlutterFlowTheme.of(context).accent1,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      widget.orderJson?.exchangeRateUsed.toString(),
                                                                                                      '0',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 180.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'toyo6lqp' /* Today exchange rate: */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Roboto',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                                Theme(
                                                                                                  data: ThemeData(
                                                                                                    checkboxTheme: CheckboxThemeData(
                                                                                                      visualDensity: VisualDensity.compact,
                                                                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                                      ),
                                                                                                    ),
                                                                                                    unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  ),
                                                                                                  child: Checkbox(
                                                                                                    value: _model.useTodayExchangeTypeCheckValue ??= widget.orderJson!.precheck,
                                                                                                    onChanged: (newValue) async {
                                                                                                      safeSetState(() => _model.useTodayExchangeTypeCheckValue = newValue!);
                                                                                                    },
                                                                                                    side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                                        ? BorderSide(
                                                                                                            width: 2,
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          )
                                                                                                        : null,
                                                                                                    activeColor: FlutterFlowTheme.of(context).info,
                                                                                                    checkColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Container(
                                                                                              width: 220.0,
                                                                                              height: 36.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                borderRadius: BorderRadius.circular(4.0),
                                                                                                border: Border.all(
                                                                                                  color: FlutterFlowTheme.of(context).accent1,
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFAppState().todayExchangeType.toString(),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Roboto',
                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 8.0)),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 16.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFF46D71),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.content_cut_outlined,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'ka4ecn1k' /* Customs */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Roboto',
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      32.0)),
                                                            ),
                                                          ]
                                                              .divide(SizedBox(
                                                                  width: 16.0))
                                                              .around(SizedBox(
                                                                  width: 16.0)),
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Container(
                                                                  width: FFAppState().navOpen == true
                                                                      ? (MediaQuery.sizeOf(context)
                                                                              .width -
                                                                          270)
                                                                      : (MediaQuery.sizeOf(context)
                                                                              .width -
                                                                          72),
                                                                  height: 300.0,
                                                                  child: custom_widgets
                                                                      .PlutoGridorderwarehouse(
                                                                    width: FFAppState().navOpen == true
                                                                        ? (MediaQuery.sizeOf(context).width -
                                                                            270)
                                                                        : (MediaQuery.sizeOf(context).width -
                                                                            72),
                                                                    height:
                                                                        300.0,
                                                                    data: FFAppState()
                                                                        .editFormJsonList,
                                                                    defaultColumnWidth:
                                                                        200.0,
                                                                    language:
                                                                        valueOrDefault<
                                                                            String>(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                      'es',
                                                                    ),
                                                                    columns: functions
                                                                        .stringToJson(
                                                                            '''[
  { "column_name": "icons", "ui_en": "", "ui_es": "", "ui_sl": "", "width": 80, "datatype": "Icon" },
  { "column_name": "edit", "ui_en": "Edit", "ui_es": "Edición", "ui_sl": "Urejanje", "width": 40, "datatype": "Icon" },
  { "column_name": "copy", "ui_en": "Copy", "ui_es": "Copiar", "ui_sl": "Kopiraj", "width": 40, "datatype": "Icon" },
  { "column_name": "pdf", "ui_en": "PDF", "ui_es": "PDF", "ui_sl": "PDF", "width": 40, "datatype": "Icon" },
  { "column_name": "details", "ui_en": "Details", "ui_es": "Detalles", "ui_sl": "Podrobnosti", "width": 40, "datatype": "Icon" },

  { "column_name": "order_no", "ui_en": "ORDER NR.", "ui_es": "N.º de orden", "ui_sl": "Št. naročila", "width": 180, "datatype": "String" },
  { "column_name": "flow", "ui_en": "input/output", "ui_es": "Flujo", "ui_sl": "Tok", "width": 100, "datatype": "String" },
  { "column_name": "eta_date", "ui_en": "estimated arrival", "ui_es": "Fecha de llegada", "ui_sl": "Datum prihoda", "width": 140, "datatype": "DateTime" },
  { "column_name": "improvement", "ui_en": "Improvement", "ui_es": "Mejora", "ui_sl": "Izboljšava", "width": 180, "datatype": "String" },
  { "column_name": "licence_plate", "ui_en": "Licence plate nr.", "ui_es": "Placa", "ui_sl": "Registrska številka", "width": 180, "datatype": "String" },
  { "column_name": "container_no", "ui_en": "Container No.", "ui_es": "N.º de contenedor", "ui_sl": "Št. zabojnika", "width": 180, "datatype": "String" },
  { "column_name": "quantity", "ui_en": "Quantit.", "ui_es": "Cantidad", "ui_sl": "Količina", "width": 120, "datatype": "int" },
  { "column_name": "pallet_position", "ui_en": "Pallet position", "ui_es": "Posición de pallet", "ui_sl": "Položaj palete", "width": 180, "datatype": "double" },
  { "column_name": "weight", "ui_en": "Weight", "ui_es": "Peso", "ui_sl": "Teža", "width": 120, "datatype": "int" },
  { "column_name": "item", "ui_en": "Good", "ui_es": "Mercancía", "ui_sl": "Blago", "width": 120, "datatype": "String" },
  { "column_name": "opis_blaga", "ui_en": "Good description", "ui_es": "Descripción de mercancía", "ui_sl": "Opis blaga", "width": 180, "datatype": "String" },
  { "column_name": "assistant1_name", "ui_en": "Assistant 1.", "ui_es": "Asistente 1", "ui_sl": "Pomočnik 1", "width": 180, "datatype": "String" },
  { "column_name": "responsible_name", "ui_en": "Responsable", "ui_es": "Responsable", "ui_sl": "Odgovorna oseba", "width": 180, "datatype": "String" },
  { "column_name": "admin_name", "ui_en": "ADMIN", "ui_es": "Administrador", "ui_sl": "Skrbnik", "width": 180, "datatype": "String" }
]

'''),
                                                                    viewName:
                                                                        'editForm',
                                                                    editAction:
                                                                        () async {
                                                                      FFAppState()
                                                                          .goodDescriptionList = [];
                                                                      FFAppState()
                                                                          .clientList = [];
                                                                      safeSetState(
                                                                          () {});
                                                                      FFAppState()
                                                                              .clientApiB =
                                                                          false;
                                                                      FFAppState()
                                                                              .clientApiId =
                                                                          FFAppState()
                                                                              .tablesRow
                                                                              .orderNo;
                                                                      FFAppState()
                                                                              .goodDescriptionApiId =
                                                                          FFAppState()
                                                                              .tablesRow
                                                                              .goodDescription;
                                                                      FFAppState()
                                                                              .goodDescriptionApiV =
                                                                          FFAppState()
                                                                              .tablesRow
                                                                              .opisBlaga;
                                                                      FFAppState()
                                                                              .clientApiV =
                                                                          FFAppState()
                                                                              .tablesRow
                                                                              .clientName;
                                                                      FFAppState()
                                                                          .addToGoodDescriptionList(
                                                                              GoodDescriptionRowStruct(
                                                                        id: FFAppState()
                                                                            .tablesRow
                                                                            .goodDescription,
                                                                        opisBlaga: FFAppState()
                                                                            .tablesRow
                                                                            .opisBlaga,
                                                                      ));
                                                                      FFAppState()
                                                                          .addToClientList(
                                                                              ClientRowStruct(
                                                                        id: FFAppState()
                                                                            .tablesRow
                                                                            .client,
                                                                        client: FFAppState()
                                                                            .tablesRow
                                                                            .clientName,
                                                                      ));
                                                                      safeSetState(
                                                                          () {});

                                                                      context
                                                                          .pushNamed(
                                                                        EditFormWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'orderJson':
                                                                              serializeParam(
                                                                            FFAppState().tablesRow,
                                                                            ParamType.DataStruct,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    copyAction:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: AssociateQueryWidget(
                                                                                yesP: () async {
                                                                                  _model.insertedRowEFOP = await OrderLevelTable().insert({
                                                                                    'order_no': valueOrDefault<String>(
                                                                                      FFAppState().tablesRow.orderNo.substring(0, FFAppState().tablesRow.orderNo.length - 3),
                                                                                      '/',
                                                                                    ),
                                                                                    'quantity': 1,
                                                                                    'pallet_position': FFAppState().tablesRow.palletPosition,
                                                                                    'unit': FFAppState().tablesRow.details,
                                                                                    'weight': FFAppState().tablesRow.weight,
                                                                                    'good': FFAppState().tablesRow.good,
                                                                                    'good_description': FFAppState().tablesRow.goodDescription,
                                                                                    'packaging': FFAppState().tablesRow.packaging,
                                                                                    'barcodes': FFAppState().emptyList,
                                                                                    'no_barcodes': FFAppState().emptyList,
                                                                                    'received_barcodes': FFAppState().emptyList,
                                                                                    'repeated_barcodes': FFAppState().emptyList,
                                                                                    'container_no': FFAppState().tablesRow.containerNo,
                                                                                    'client': FFAppState().tablesRow.client,
                                                                                    'inv_status': 'najava',
                                                                                    'order_status': 'novo naročilo',
                                                                                    'admin': currentUserUid,
                                                                                    'warehouse': FFAppState().tablesRow.warehouse,
                                                                                    'fms_ref': FFAppState().tablesRow.fmsRef,
                                                                                    'load_ref_dvh': FFAppState().tablesRow.loadRefDvh,
                                                                                    'universal_ref_no': FFAppState().tablesRow.universalRefNo,
                                                                                    'documents': FFAppState().emptyList,
                                                                                    'flow': 'out',
                                                                                    'eta_i': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'eta_f': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'arrival': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'start': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'stop': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'custom': FFAppState().tablesRow.custom,
                                                                                    'associated_order': FFAppState().tablesRow.id,
                                                                                    'taric_code': FFAppState().tablesRow.taricCode,
                                                                                    'customs_percentage': FFAppState().tablesRow.customsPercentage,
                                                                                    'euro_or_dolar': FFAppState().tablesRow.euroOrDolar,
                                                                                    'exchange_rate_used': FFAppState().tablesRow.exchangeRateUsed,
                                                                                    'init_cost': FFAppState().tablesRow.initCost,
                                                                                    'exchanged_cost': FFAppState().tablesRow.exchangedCost,
                                                                                    'value_per_unit': FFAppState().tablesRow.valuePerUnit,
                                                                                    'custom_percentage_per_cost': FFAppState().tablesRow.customPercentagePerCost,
                                                                                    'acumulated_customs_percentages': FFAppState().tablesRow.acumulatedCustomsPercentages,
                                                                                    'current_customs_warranty': FFAppState().tablesRow.currentCustomsWarranty,
                                                                                    'remaining_customs_threshold': FFAppState().tablesRow.remainingCustomsThreshold,
                                                                                    'dolars': 0.0,
                                                                                    'euros': 0.0,
                                                                                    'internal_ref_custom': '',
                                                                                    'weight_balance': 0.0,
                                                                                    'group_consumed_threshold': 0.0,
                                                                                  });
                                                                                  _model.refreshRowEFOP = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                    rowId: FFAppState().tablesRow.id,
                                                                                    userToken: currentJwtToken,
                                                                                  );

                                                                                  if (!(_model.refreshRowEFOP?.succeeded ?? true)) {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          'Refresh row error.',
                                                                                          style: TextStyle(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 12.0,
                                                                                          ),
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 4000),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                                noP: () async {
                                                                                  _model.insertedRow2EFOP = await OrderLevelTable().insert({
                                                                                    'order_no': valueOrDefault<String>(
                                                                                      FFAppState().tablesRow.orderNo.substring(0, FFAppState().tablesRow.orderNo.length - 3),
                                                                                      '/',
                                                                                    ),
                                                                                    'quantity': 1,
                                                                                    'pallet_position': FFAppState().tablesRow.palletPosition,
                                                                                    'unit': FFAppState().tablesRow.details,
                                                                                    'weight': FFAppState().tablesRow.weight,
                                                                                    'good': FFAppState().tablesRow.good,
                                                                                    'good_description': FFAppState().tablesRow.goodDescription,
                                                                                    'packaging': FFAppState().tablesRow.packaging,
                                                                                    'barcodes': FFAppState().emptyList,
                                                                                    'no_barcodes': FFAppState().emptyList,
                                                                                    'received_barcodes': FFAppState().emptyList,
                                                                                    'repeated_barcodes': FFAppState().emptyList,
                                                                                    'container_no': FFAppState().tablesRow.containerNo,
                                                                                    'client': FFAppState().tablesRow.client,
                                                                                    'inv_status': 'najava',
                                                                                    'order_status': 'novo naročilo',
                                                                                    'admin': currentUserUid,
                                                                                    'warehouse': FFAppState().tablesRow.warehouse,
                                                                                    'fms_ref': FFAppState().tablesRow.fmsRef,
                                                                                    'load_ref_dvh': FFAppState().tablesRow.loadRefDvh,
                                                                                    'universal_ref_no': FFAppState().tablesRow.universalRefNo,
                                                                                    'documents': FFAppState().emptyList,
                                                                                    'flow': 'out',
                                                                                    'eta_i': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'eta_f': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'arrival': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'start': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'stop': supaSerialize<PostgresTime>(PostgresTime(functions.stringToDateTime('00:00'))),
                                                                                    'custom': FFAppState().tablesRow.custom,
                                                                                    'associated_order': '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b',
                                                                                    'taric_code': FFAppState().tablesRow.taricCode,
                                                                                    'customs_percentage': FFAppState().tablesRow.customsPercentage,
                                                                                    'euro_or_dolar': FFAppState().tablesRow.euroOrDolar,
                                                                                    'exchange_rate_used': FFAppState().tablesRow.exchangeRateUsed,
                                                                                    'init_cost': FFAppState().tablesRow.initCost,
                                                                                    'exchanged_cost': FFAppState().tablesRow.exchangedCost,
                                                                                    'value_per_unit': FFAppState().tablesRow.valuePerUnit,
                                                                                    'custom_percentage_per_cost': FFAppState().tablesRow.customPercentagePerCost,
                                                                                    'acumulated_customs_percentages': FFAppState().tablesRow.acumulatedCustomsPercentages,
                                                                                    'current_customs_warranty': FFAppState().tablesRow.currentCustomsWarranty,
                                                                                    'remaining_customs_threshold': FFAppState().tablesRow.remainingCustomsThreshold,
                                                                                    'dolars': 0.0,
                                                                                    'euros': 0.0,
                                                                                    'internal_ref_custom': '',
                                                                                    'weight_balance': 0.0,
                                                                                    'group_consumed_threshold': 0.0,
                                                                                  });
                                                                                  _model.refreshRow2EFOP = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                    rowId: FFAppState().tablesRow.id,
                                                                                    userToken: currentJwtToken,
                                                                                  );

                                                                                  if (!(_model.refreshRow2EFOP?.succeeded ?? true)) {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          'Refresh row error.',
                                                                                          style: TextStyle(
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 12.0,
                                                                                          ),
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 4000),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    pdfAction:
                                                                        () async {
                                                                      await actions
                                                                          .getPDF(
                                                                        FFAppState()
                                                                            .tablesRow
                                                                            .toMap(),
                                                                      );
                                                                    },
                                                                    detailsAction:
                                                                        () async {
                                                                      FFAppState()
                                                                          .clearDetailsViewCache();
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: DetailsWidget(
                                                                                orderId: FFAppState().tablesRow.id,
                                                                                orderNo: FFAppState().tablesRow.orderNo,
                                                                                warehouseIdDetails: FFAppState().tablesRow.warehouse,
                                                                                flow: FFAppState().tablesRow.flow,
                                                                                associatedOrder: FFAppState().tablesRow.associatedOrder,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    deleteAction:
                                                                        () async {},
                                                                    cellSelectAction:
                                                                        () async {},
                                                                    documentsAction:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: DocumentsWidget(
                                                                                orderId: FFAppState().tablesRow.id,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    filtersAction:
                                                                        () async {},
                                                                    gridStateAction:
                                                                        () async {
                                                                      await UsersTable()
                                                                          .update(
                                                                        data: {
                                                                          'last_grid_state':
                                                                              FFAppState().plutogridTableInfo,
                                                                        },
                                                                        matchingRows:
                                                                            (rows) =>
                                                                                rows.eqOrNull(
                                                                          'id',
                                                                          currentUserUid,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await actions
                                                                  .getPDF(
                                                                widget
                                                                    .orderJson!
                                                                    .toMap(),
                                                              );
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'szmwfduf' /* print PDF */,
                                                            ),
                                                            icon: Icon(
                                                              Icons
                                                                  .print_outlined,
                                                              size: 24.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: 60.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                            ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              context.safePop();
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '0lcne31l' /* Cancel */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: 60.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent1,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                          Builder(
                                                            builder: (context) =>
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                if (_model.customDDValue ==
                                                                        '756a1fad-8f1e-43d4-ad2a-00ffdca46299'
                                                                    ? ((_model.currencyCCValue !=
                                                                                null &&
                                                                            _model.currencyCCValue !=
                                                                                '') &&
                                                                        (_model.currencyCCValue !=
                                                                            '/'))
                                                                    : true) {
                                                                  _model
                                                                      .unitLast = _model.unitTFTextController.text !=
                                                                              ''
                                                                      ? int.parse(_model
                                                                          .unitTFTextController
                                                                          .text)
                                                                      : widget
                                                                          .orderJson!
                                                                          .unit;
                                                                  _model.numberOfBarcodes = functions
                                                                      .splitBarcodes(_model
                                                                          .barcodesTFTextController
                                                                          .text)
                                                                      .length;
                                                                  safeSetState(
                                                                      () {});
                                                                  if (_model
                                                                          .unitLast >=
                                                                      _model
                                                                          .numberOfBarcodes) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(dialogContext).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                SureQueryWidget(
                                                                              saveChangesP: () async {
                                                                                _model.initCost = await actions.enforceDouble(
                                                                                  _model.initCostTFTextController.text,
                                                                                );
                                                                                if (_model.barcodesCheckValue!) {
                                                                                  await OrderLevelTable().update(
                                                                                    data: {
                                                                                      'inv_status': _model.inventoryStatusDDValue != null && _model.inventoryStatusDDValue != '' ? _model.inventoryStatusDDValue : widget.orderJson?.invStatus,
                                                                                      'order_no': _model.orderNoTFTextController.text != '' ? _model.orderNoTFTextController.text : widget.orderJson?.orderNo,
                                                                                      'flow': _model.flowDDValue != null && _model.flowDDValue != '' ? _model.flowDDValue : widget.orderJson?.flow,
                                                                                      'order_status': _model.orderStatusDDValue != null && _model.orderStatusDDValue != '' ? _model.orderStatusDDValue : widget.orderJson?.orderStatus,
                                                                                      'admin': _model.adminDDValue != null && _model.adminDDValue != '' ? _model.adminDDValue : widget.orderJson?.admin,
                                                                                      'warehouse': _model.warehouseDDValue != null && _model.warehouseDDValue != '' ? _model.warehouseDDValue : widget.orderJson?.warehouse,
                                                                                      'eta_date': supaSerialize<DateTime>(_model.estimatedArrival != null ? _model.estimatedArrival : functions.parsePostgresTimestamp(widget.orderJson!.etaDate2)),
                                                                                      'eta_i': supaSerialize<PostgresTime>(PostgresTime(_model.announcedTime1 != null ? _model.announcedTime1 : functions.parsePostgresTimestamp(widget.orderJson!.etaI2))),
                                                                                      'arrival': supaSerialize<PostgresTime>(PostgresTime(_model.arrivalTime != null ? _model.arrivalTime : functions.parsePostgresTimestamp(widget.orderJson!.arrival2))),
                                                                                      'loading_gate': _model.loadingGateDDValue != null && _model.loadingGateDDValue != '' ? _model.loadingGateDDValue : widget.orderJson?.loadingGateRamp,
                                                                                      'loading_sequence': _model.loadingSequenceTFTextController.text != '' ? int.tryParse(_model.loadingSequenceTFTextController.text) : widget.orderJson?.loadingSequence,
                                                                                      'start': supaSerialize<PostgresTime>(PostgresTime(_model.startTime != null ? _model.startTime : functions.parsePostgresTimestamp(widget.orderJson!.start2))),
                                                                                      'stop': supaSerialize<PostgresTime>(PostgresTime(_model.endTime != null ? _model.endTime : functions.parsePostgresTimestamp(widget.orderJson!.stop2))),
                                                                                      'licence_plate': _model.licencePlateTFTextController.text != '' ? _model.licencePlateTFTextController.text : widget.orderJson?.licencePlate,
                                                                                      'quantity': _model.quantityTFTextController.text != '' ? int.tryParse(_model.quantityTFTextController.text) : widget.orderJson?.quantity,
                                                                                      'unit': _model.unitTFTextController.text != '' ? int.tryParse(_model.unitTFTextController.text) : widget.orderJson?.unit,
                                                                                      'weight': _model.weightTFTextController.text != '' ? int.tryParse(_model.weightTFTextController.text) : widget.orderJson?.weight,
                                                                                      'container_no': _model.containerTFTextController.text != '' ? _model.containerTFTextController.text : widget.orderJson?.containerNo,
                                                                                      'custom': _model.customDDValue != null && _model.customDDValue != '' ? _model.customDDValue : widget.orderJson?.custom,
                                                                                      'responsible': _model.responsibleDDValue != null && _model.responsibleDDValue != '' ? _model.responsibleDDValue : widget.orderJson?.responsible,
                                                                                      'assistant1': _model.assistant1DDValue != null && _model.assistant1DDValue != '' ? _model.assistant1DDValue : widget.orderJson?.assistant1,
                                                                                      'assistant2': _model.assistant2DDValue != null && _model.assistant2DDValue != '' ? _model.assistant2DDValue : widget.orderJson?.assistant2,
                                                                                      'fms_ref': _model.fmsRefTFTextController.text != '' ? _model.fmsRefTFTextController.text : widget.orderJson?.fmsRef,
                                                                                      'load_ref_dvh': _model.loaRefDvhTFTextController.text != '' ? _model.loaRefDvhTFTextController.text : widget.orderJson?.loadRefDvh,
                                                                                      'universal_ref_no': _model.universalRefNumTFTextController.text != '' ? _model.universalRefNumTFTextController.text : widget.orderJson?.universalRefNo,
                                                                                      'comment': _model.comentTTextController.text != '' ? _model.comentTTextController.text : widget.orderJson?.comment,
                                                                                      'loading_type': _model.loadingTypeDDValue != null && _model.loadingTypeDDValue != '' ? _model.loadingTypeDDValue : widget.orderJson?.loadingType,
                                                                                      'loading_type2': _model.loadingType2DDValue != null && _model.loadingType2DDValue != '' ? _model.loadingType2DDValue : widget.orderJson?.loadingType2,
                                                                                      'internal_accounting': _model.intAccountingTFTextController.text != '' ? _model.intAccountingTFTextController.text : widget.orderJson?.internalAccounting,
                                                                                      'internal_ref_custom': _model.intRefNoTFTextController.text != '' ? _model.intRefNoTFTextController.text : widget.orderJson?.internalRefCustom,
                                                                                      'client': FFAppState().clientApiB ? FFAppState().clientApiId : widget.orderJson?.client,
                                                                                      'improvement': _model.improvementDDValue != null && _model.improvementDDValue != '' ? _model.improvementDDValue : widget.orderJson?.improvement,
                                                                                      'other_manipulation': _model.otherManipulationsDDValue != null && _model.otherManipulationsDDValue != '' ? _model.otherManipulationsDDValue : widget.orderJson?.otherManipulation,
                                                                                      'good': _model.goodsDDValue != null && _model.goodsDDValue != '' ? _model.goodsDDValue : widget.orderJson?.good,
                                                                                      'good_description': FFAppState().goodDescriptionApiB ? FFAppState().goodDescriptionApiId : widget.orderJson?.goodDescription,
                                                                                      'packaging': _model.packagingDDValue != null && _model.packagingDDValue != '' ? _model.packagingDDValue : widget.orderJson?.packaging,
                                                                                      'checked': _model.checkCBValue != null ? _model.checkCBValue : widget.orderJson?.checked,
                                                                                      'precheck': _model.preCheckCBValue != null ? _model.preCheckCBValue : widget.orderJson?.precheck,
                                                                                      'received_barcodes': functions.splitBarcodes(_model.barcodesTFTextController.text),
                                                                                      'barcodes': FFAppState().emptyList,
                                                                                      'no_barcodes': FFAppState().emptyList,
                                                                                      'repeated_barcodes': FFAppState().emptyList,
                                                                                      'pallet_position': _model.palletPositionTTextController.text != '' ? double.tryParse(_model.palletPositionTTextController.text) : widget.orderJson?.palletPosition,
                                                                                      'created_at': supaSerialize<DateTime>(_model.creationDate != null ? _model.creationDate : functions.parsePostgresTimestamp(widget.orderJson!.createdAt2)),
                                                                                      'taric_code': _model.taricCodeTFTextController.text != '' ? _model.taricCodeTFTextController.text : widget.orderJson?.taricCode,
                                                                                      'customs_percentage': _model.customPercentageTFTextController.text != '' ? (double.parse(_model.customPercentageTFTextController.text) / 100) : widget.orderJson?.customsPercentage,
                                                                                      'init_cost': _model.initCostTFTextController.text != ''
                                                                                          ? valueOrDefault<double>(
                                                                                              _model.initCost,
                                                                                              0.0,
                                                                                            )
                                                                                          : widget.orderJson?.initCost,
                                                                                      'euro_or_dolar': _model.currencyCCValue != null && _model.currencyCCValue != '' ? _model.currencyCCValue : widget.orderJson?.euroOrDolar,
                                                                                      'exchange_rate_used': _model.useTodayExchangeTypeCheckValue! ? FFAppState().todayExchangeType : widget.orderJson?.exchangeRateUsed,
                                                                                    },
                                                                                    matchingRows: (rows) => rows.eqOrNull(
                                                                                      'id',
                                                                                      widget.orderJson?.id,
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  await OrderLevelTable().update(
                                                                                    data: {
                                                                                      'inv_status': _model.inventoryStatusDDValue != null && _model.inventoryStatusDDValue != '' ? _model.inventoryStatusDDValue : widget.orderJson?.invStatus,
                                                                                      'order_no': _model.orderNoTFTextController.text != '' ? _model.orderNoTFTextController.text : widget.orderJson?.orderNo,
                                                                                      'flow': _model.flowDDValue != null && _model.flowDDValue != '' ? _model.flowDDValue : widget.orderJson?.flow,
                                                                                      'order_status': _model.orderStatusDDValue != null && _model.orderStatusDDValue != '' ? _model.orderStatusDDValue : widget.orderJson?.orderStatus,
                                                                                      'admin': _model.adminDDValue != null && _model.adminDDValue != '' ? _model.adminDDValue : widget.orderJson?.admin,
                                                                                      'warehouse': _model.warehouseDDValue != null && _model.warehouseDDValue != '' ? _model.warehouseDDValue : widget.orderJson?.warehouse,
                                                                                      'eta_date': supaSerialize<DateTime>(_model.estimatedArrival != null ? _model.estimatedArrival : functions.parsePostgresTimestamp(widget.orderJson!.etaDate2)),
                                                                                      'eta_i': supaSerialize<PostgresTime>(PostgresTime(_model.announcedTime1 != null ? _model.announcedTime1 : functions.parsePostgresTimestamp(widget.orderJson!.etaI2))),
                                                                                      'arrival': supaSerialize<PostgresTime>(PostgresTime(_model.arrivalTime != null ? _model.arrivalTime : functions.parsePostgresTimestamp(widget.orderJson!.arrival2))),
                                                                                      'loading_gate': _model.loadingGateDDValue != null && _model.loadingGateDDValue != '' ? _model.loadingGateDDValue : widget.orderJson?.loadingGateRamp,
                                                                                      'loading_sequence': _model.loadingSequenceTFTextController.text != '' ? int.tryParse(_model.loadingSequenceTFTextController.text) : widget.orderJson?.loadingSequence,
                                                                                      'start': supaSerialize<PostgresTime>(PostgresTime(_model.startTime != null ? _model.startTime : functions.parsePostgresTimestamp(widget.orderJson!.start2))),
                                                                                      'stop': supaSerialize<PostgresTime>(PostgresTime(_model.endTime != null ? _model.endTime : functions.parsePostgresTimestamp(widget.orderJson!.stop2))),
                                                                                      'licence_plate': _model.licencePlateTFTextController.text != '' ? _model.licencePlateTFTextController.text : widget.orderJson?.licencePlate,
                                                                                      'quantity': _model.quantityTFTextController.text != '' ? int.tryParse(_model.quantityTFTextController.text) : widget.orderJson?.quantity,
                                                                                      'pallet_position': _model.palletPositionTTextController.text != '' ? double.tryParse(_model.palletPositionTTextController.text) : widget.orderJson?.palletPosition,
                                                                                      'weight': _model.weightTFTextController.text != '' ? int.tryParse(_model.weightTFTextController.text) : widget.orderJson?.weight,
                                                                                      'container_no': _model.containerTFTextController.text != '' ? _model.containerTFTextController.text : widget.orderJson?.containerNo,
                                                                                      'custom': _model.customDDValue != null && _model.customDDValue != '' ? _model.customDDValue : widget.orderJson?.custom,
                                                                                      'responsible': _model.responsibleDDValue != null && _model.responsibleDDValue != '' ? _model.responsibleDDValue : widget.orderJson?.responsible,
                                                                                      'assistant1': _model.assistant1DDValue != null && _model.assistant1DDValue != '' ? _model.assistant1DDValue : widget.orderJson?.assistant1,
                                                                                      'assistant2': _model.assistant2DDValue != null && _model.assistant2DDValue != '' ? _model.assistant2DDValue : widget.orderJson?.assistant2,
                                                                                      'fms_ref': _model.fmsRefTFTextController.text != '' ? _model.fmsRefTFTextController.text : widget.orderJson?.fmsRef,
                                                                                      'load_ref_dvh': _model.loaRefDvhTFTextController.text != '' ? _model.loaRefDvhTFTextController.text : widget.orderJson?.loadRefDvh,
                                                                                      'universal_ref_no': _model.universalRefNumTFTextController.text != '' ? _model.universalRefNumTFTextController.text : widget.orderJson?.universalRefNo,
                                                                                      'comment': _model.comentTTextController.text != '' ? _model.comentTTextController.text : widget.orderJson?.comment,
                                                                                      'loading_type': _model.loadingTypeDDValue != null && _model.loadingTypeDDValue != '' ? _model.loadingTypeDDValue : widget.orderJson?.loadingType,
                                                                                      'loading_type2': _model.loadingType2DDValue != null && _model.loadingType2DDValue != '' ? _model.loadingType2DDValue : widget.orderJson?.loadingType2,
                                                                                      'internal_accounting': _model.intAccountingTFTextController.text != '' ? _model.intAccountingTFTextController.text : widget.orderJson?.internalAccounting,
                                                                                      'internal_ref_custom': _model.intRefNoTFTextController.text != '' ? _model.intRefNoTFTextController.text : widget.orderJson?.internalRefCustom,
                                                                                      'client': FFAppState().clientApiB ? FFAppState().clientApiId : widget.orderJson?.client,
                                                                                      'improvement': _model.improvementDDValue != null && _model.improvementDDValue != '' ? _model.improvementDDValue : widget.orderJson?.improvement,
                                                                                      'other_manipulation': _model.otherManipulationsDDValue != null && _model.otherManipulationsDDValue != '' ? _model.otherManipulationsDDValue : widget.orderJson?.otherManipulation,
                                                                                      'good': _model.goodsDDValue != null && _model.goodsDDValue != '' ? _model.goodsDDValue : widget.orderJson?.good,
                                                                                      'good_description': FFAppState().goodDescriptionApiB ? FFAppState().goodDescriptionApiId : widget.orderJson?.goodDescription,
                                                                                      'packaging': _model.packagingDDValue != null && _model.packagingDDValue != '' ? _model.packagingDDValue : widget.orderJson?.packaging,
                                                                                      'checked': _model.checkCBValue != null ? _model.checkCBValue : widget.orderJson?.checked,
                                                                                      'precheck': _model.preCheckCBValue != null ? _model.preCheckCBValue : widget.orderJson?.precheck,
                                                                                      'barcodes': FFAppState().emptyList,
                                                                                      'no_barcodes': FFAppState().emptyList,
                                                                                      'repeated_barcodes': FFAppState().emptyList,
                                                                                      'created_at': supaSerialize<DateTime>(_model.creationDate != null ? _model.creationDate : functions.parsePostgresTimestamp(widget.orderJson!.createdAt2)),
                                                                                      'taric_code': _model.taricCodeTFTextController.text != '' ? _model.taricCodeTFTextController.text : widget.orderJson?.taricCode,
                                                                                      'customs_percentage': _model.customPercentageTFTextController.text != '' ? (double.parse(_model.customPercentageTFTextController.text) / 100) : widget.orderJson?.customsPercentage,
                                                                                      'init_cost': _model.initCostTFTextController.text != ''
                                                                                          ? valueOrDefault<double>(
                                                                                              _model.initCost,
                                                                                              0.0,
                                                                                            )
                                                                                          : widget.orderJson?.initCost,
                                                                                      'euro_or_dolar': _model.currencyCCValue != null && _model.currencyCCValue != '' ? _model.currencyCCValue : widget.orderJson?.euroOrDolar,
                                                                                      'exchange_rate_used': _model.useTodayExchangeTypeCheckValue! ? FFAppState().todayExchangeType : widget.orderJson?.exchangeRateUsed,
                                                                                    },
                                                                                    matchingRows: (rows) => rows.eqOrNull(
                                                                                      'id',
                                                                                      widget.orderJson?.id,
                                                                                    ),
                                                                                  );
                                                                                }

                                                                                _model.refreshRowOPCopy = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                  rowId: widget.orderJson?.id,
                                                                                  userToken: currentJwtToken,
                                                                                );

                                                                                if ((_model.refreshRowOPCopy?.succeeded ?? true)) {
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'Refresh row error.',
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          fontSize: 12.0,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 4000),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        safeSetState(() =>
                                                                            _model.sureQueryOP =
                                                                                value));

                                                                    if (_model
                                                                        .sureQueryOP!) {
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'The value of unit is less than the number of barcodes.',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            Duration(milliseconds: 4000),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondary,
                                                                      ),
                                                                    );
                                                                  }

                                                                  if ((widget.viewFrom ==
                                                                          '/orderWarehouse') ||
                                                                      (widget.viewFrom ==
                                                                          '/')) {
                                                                    context.pushNamed(
                                                                        OrderWarehouseWidget
                                                                            .routeName);
                                                                  } else if (widget
                                                                          .viewFrom ==
                                                                      '/warehouse2') {
                                                                    context.pushNamed(
                                                                        Warehouse2Widget
                                                                            .routeName);
                                                                  } else if (widget
                                                                          .viewFrom ==
                                                                      '/customs') {
                                                                    context.pushNamed(
                                                                        CustomsViewWidget
                                                                            .routeName);
                                                                  } else if (widget
                                                                          .viewFrom ==
                                                                      '/calendar') {
                                                                    context.pushNamed(
                                                                        CalendarWidget
                                                                            .routeName);
                                                                  } else if (widget
                                                                          .viewFrom ==
                                                                      '/reports') {
                                                                    context.pushNamed(
                                                                        ReportsWidget
                                                                            .routeName);
                                                                  }
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Please choose currency.',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondary,
                                                                    ),
                                                                  );
                                                                }

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                'ol5m20hz' /* UPDATE RECORD */,
                                                              ),
                                                              icon: Icon(
                                                                Icons
                                                                    .save_outlined,
                                                                size: 24.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 60.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .success,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 32.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 32.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 32.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
