import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_order_warehouse_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
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
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_warehouse_model.dart';
export 'order_warehouse_model.dart';

class OrderWarehouseWidget extends StatefulWidget {
  const OrderWarehouseWidget({
    super.key,
    String? orderWarehouseTablesKey,
    int? numberOfRows,
  })  : this.orderWarehouseTablesKey =
            orderWarehouseTablesKey ?? 'orderWarehouseTablesDefKey',
        this.numberOfRows = numberOfRows ?? 100;

  final String orderWarehouseTablesKey;
  final int numberOfRows;

  static String routeName = 'order_warehouse';
  static String routePath = '/orderWarehouse';

  @override
  State<OrderWarehouseWidget> createState() => _OrderWarehouseWidgetState();
}

class _OrderWarehouseWidgetState extends State<OrderWarehouseWidget>
    with TickerProviderStateMixin {
  late OrderWarehouseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderWarehouseModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          await action_blocks.startingPage(context);
          safeSetState(() {});
        }),
        Future(() async {
          await actions.desconectar(
            'order_level',
          );
          await Future.delayed(
            Duration(
              milliseconds: 1000,
            ),
          );
          await actions.conectar(
            'order_level',
            'orderWarehouse',
          );
        }),
        Future(() async {
          // Si hay filtros guardados, mantener el query existente, sino crear uno nuevo
          if (FFAppState().orderWarehouseFilterValues.isEmpty) {
            FFAppState().orderWarehouseApiV = 'is_deleted=eq.false';
            safeSetState(() {});
            FFAppState().orderWarehouseApiV = (String var1) {
              return var1 +
                  '&order=crono.desc.nullslast&availability=neq.consumed&is_deleted=eq.false&limit=50&custom=neq.756a1fad-8f1e-43d4-ad2a-00ffdca46299';
            }(FFAppState().orderWarehouseApiV);
          }
          // Si hay filtros guardados, orderWarehouseApiV ya tiene el query correcto
          await action_blocks.orderWarehouseAction(context);
          safeSetState(() {});
          _model.quantityOP = await actions.quantityBalanceAction(
            FFAppState().orderWarehouseApiOPJsonList.toList(),
          );
          FFAppState().quantityBalance = _model.quantityOP!;
          safeSetState(() {});
        }),
        Future(() async {
          await action_blocks.exchangeTypeBlock(context);
        }),
      ]);
    });

    _model.onlineSWValue = true;
    _model.rowsQuantityTFTextController ??=
        TextEditingController(text: FFAppState().maxNumRows);
    _model.rowsQuantityTFFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 0.5,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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

    return FutureBuilder<List<UsersRow>>(
      future: FFAppState().users2(
        uniqueQueryKey: valueOrDefault<String>(
          widget.orderWarehouseTablesKey,
          'orderWarehouseUsersDefKey',
        ),
        requestFn: () => UsersTable().queryRows(
          queryFn: (q) => q,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
        List<UsersRow> orderWarehouseUsersRowList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: FFAppState().navOpen == true ? 270.0 : 72.0,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(0.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Image.asset(
                                      'assets/images/logo_image.png',
                                      width: 32.0,
                                      height: 32.0,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  if (FFAppState().navOpen == true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Image.asset(
                                            'assets/images/logo.png',
                                            height: 28.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 12.0,
                              thickness: 2.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context
                                            .pushNamed(ReportsWidget.routeName);
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: double.infinity,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 6.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.chartLine,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'lylin1wr' /* Reports */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: double.infinity,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .accent4,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 6.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.boxesStacked,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 20.0,
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'j602wsdt' /* Order warehouse */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                            Warehouse2Widget.routeName);
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: double.infinity,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 6.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.warehouse,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'u09580ec' /* Warehouse 2 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                            CalendarWidget.routeName);
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: double.infinity,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 6.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.calendarDays,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'kgotqw8e' /* Calendar */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                            CustomsViewWidget.routeName);
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        width: double.infinity,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 6.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.stamp,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '6hqs0t4w' /* Customs */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (FFAppState().navOpen == true)
                                        Container(
                                          width: 24.0,
                                          height: 14.0,
                                          decoration: BoxDecoration(),
                                        ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'fyhezuql' /* Settings */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      if (FFAppState().navOpen == true)
                                        Expanded(
                                          child: Container(
                                            width: 100.0,
                                            height: 14.0,
                                            decoration: BoxDecoration(),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (orderWarehouseUsersRowList
                                          .where((e) => e.id == currentUserUid)
                                          .toList()
                                          .firstOrNull
                                          ?.userType ==
                                      'superadmin')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context
                                              .pushNamed(UsersWidget.routeName);
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeInOut,
                                          width: double.infinity,
                                          height: 44.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 6.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 24.0,
                                                ),
                                                if (FFAppState().navOpen ==
                                                    true)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8q9xj2n2' /* Users */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (orderWarehouseUsersRowList
                                          .where((e) => e.id == currentUserUid)
                                          .toList()
                                          .firstOrNull
                                          ?.userType ==
                                      'superadmin')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              ExploreWidget.routeName);
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeInOut,
                                          width: double.infinity,
                                          height: 44.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 6.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.ellipsis,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 20.0,
                                                ),
                                                if (FFAppState().navOpen ==
                                                    true)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'j7p06qzs' /* Explore */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: Container(
                                      width: 50.0,
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                  if (FFAppState().navOpen == true)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FlutterFlowLanguageSelector(
                                        width: 200.0,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .tertiary,
                                        borderColor: Colors.transparent,
                                        dropdownIconColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        borderRadius: 12.0,
                                        textStyle: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13.0,
                                        ),
                                        hideFlags: false,
                                        flagSize: 24.0,
                                        flagTextGap: 16.0,
                                        currentLanguage:
                                            FFLocalizations.of(context)
                                                .languageCode,
                                        languages: FFLocalizations.languages(),
                                        onChanged: (lang) =>
                                            setAppLanguage(context, lang),
                                      ),
                                    ),
                                  if (FFAppState().navOpen == true)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.lightModeModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: LightModeWidget(),
                                      ),
                                    ),
                                ].divide(SizedBox(height: 12.0)),
                              ),
                            ),
                            Divider(
                              height: 12.0,
                              thickness: 2.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            wrapWithModel(
                              model: _model.userDetailsModel,
                              updateCallback: () => safeSetState(() {}),
                              child: UserDetailsWidget(
                                userDetail: orderWarehouseUsersRowList
                                    .where((e) => e.id == currentUserUid)
                                    .toList()
                                    .firstOrNull!,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (FFAppState().navOpen == true)
                                    Expanded(
                                      child: Container(
                                        width: 100.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (FFAppState().navOpen == true) {
                                        FFAppState().navOpen = false;
                                        safeSetState(() {});
                                        if (animationsMap[
                                                'iconOnActionTriggerAnimation'] !=
                                            null) {
                                          animationsMap[
                                                  'iconOnActionTriggerAnimation']!
                                              .controller
                                              .forward(from: 0.0);
                                        }
                                      } else {
                                        FFAppState().navOpen = true;
                                        safeSetState(() {});
                                        if (animationsMap[
                                                'iconOnActionTriggerAnimation'] !=
                                            null) {
                                          animationsMap[
                                                  'iconOnActionTriggerAnimation']!
                                              .controller
                                              .reverse();
                                        }
                                      }
                                    },
                                    child: Icon(
                                      Icons.menu_open_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 24.0,
                                    ),
                                  ).animateOnActionTrigger(
                                    animationsMap[
                                        'iconOnActionTriggerAnimation']!,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if ((orderWarehouseUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'superadmin') ||
                      (orderWarehouseUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'administrator'))
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                      maxWidth: double.infinity,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 200.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 4.0, 12.0, 4.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'n93kx1hi' /* Order warehouse V4.2 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 28.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                't3kkdl4l' /* Movements */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'lajbsmm6' /* Below are the details of your ... */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'm92wo0i8' /* Updates: */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        FFAppState()
                                                                            .updates
                                                                            .toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '807ab1w8' /* Quantity balance: */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        FFAppState()
                                                                            .quantityBalance
                                                                            .toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            fontSize:
                                                                                24.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final fixedColumnsVar =
                                                                _model
                                                                    .fixedColumns
                                                                    .toList();

                                                            return SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Container(
                                                                width: 400.0,
                                                                height: 68.0,
                                                                child:
                                                                    DataTable2(
                                                                  columns: [
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            FFLocalizations.of(context).getText(
                                                                              'p1aro1bt' /* Inventory status */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                1.0,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 10.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            FFLocalizations.of(context).getText(
                                                                              'ipet2wod' /* Order No. */,
                                                                            ),
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                1.0,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 10.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            FFLocalizations.of(context).getText(
                                                                              'jwvc4zl3' /* Client */,
                                                                            ),
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                1.0,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataColumn2(
                                                                      label: DefaultTextStyle
                                                                          .merge(
                                                                        softWrap:
                                                                            true,
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              AutoSizeText(
                                                                            FFLocalizations.of(context).getText(
                                                                              'usjnsdde' /* Available quantity */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            maxLines:
                                                                                2,
                                                                            minFontSize:
                                                                                1.0,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  rows: fixedColumnsVar
                                                                      .mapIndexed((fixedColumnsVarIndex, fixedColumnsVarItem) => [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: AutoSizeText(
                                                                                valueOrDefault<String>(
                                                                                  fixedColumnsVarItem.invStatus,
                                                                                  'brez izbire',
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                minFontSize: 1.0,
                                                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 10.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: AutoSizeText(
                                                                                valueOrDefault<String>(
                                                                                  fixedColumnsVarItem.orderNo,
                                                                                  'brez izbire',
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                minFontSize: 1.0,
                                                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 10.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: AutoSizeText(
                                                                                valueOrDefault<String>(
                                                                                  fixedColumnsVarItem.client,
                                                                                  'brez izbire',
                                                                                ).maybeHandleOverflow(
                                                                                  maxChars: 20,
                                                                                  replacement: '…',
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                minFontSize: 1.0,
                                                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: AutoSizeText(
                                                                                valueOrDefault<String>(
                                                                                  fixedColumnsVarItem.availableQuantity.toString(),
                                                                                  '0',
                                                                                ).maybeHandleOverflow(
                                                                                  maxChars: 20,
                                                                                  replacement: '…',
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                                maxLines: 2,
                                                                                minFontSize: 1.0,
                                                                                style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ].map((c) => DataCell(c)).toList())
                                                                      .map((e) => DataRow(cells: e))
                                                                      .toList(),
                                                                  headingRowColor:
                                                                      WidgetStateProperty
                                                                          .all(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  headingRowHeight:
                                                                      40.0,
                                                                  dataRowColor:
                                                                      WidgetStateProperty
                                                                          .all(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  dataRowHeight:
                                                                      28.0,
                                                                  border:
                                                                      TableBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                  dividerThickness:
                                                                      2.0,
                                                                  columnSpacing:
                                                                      0.0,
                                                                  showBottomBorder:
                                                                      true,
                                                                  minWidth:
                                                                      49.0,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 8.0, 0.0, 0.0),
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .stateGridDDValueController ??=
                                                FormFieldController<String>(
                                              _model.stateGridDDValue ??= () {
                                                // Obtener activeId de la vista orderWarehouse
                                                try {
                                                  final plutogrid = FFAppState()
                                                      .plutogridTableInfo;
                                                  if (plutogrid.isNotEmpty) {
                                                    final viewEntry =
                                                        plutogrid.firstWhere(
                                                      (e) =>
                                                          e is Map &&
                                                          e['view'] ==
                                                              'orderWarehouse',
                                                      orElse: () =>
                                                          <String, dynamic>{},
                                                    );
                                                    if (viewEntry is Map &&
                                                        viewEntry.containsKey(
                                                            'activeId')) {
                                                      return viewEntry[
                                                                  'activeId']
                                                              ?.toString() ??
                                                          '';
                                                    }
                                                  }
                                                } catch (e) {
                                                  debugPrint(
                                                      'Error getting activeId: $e');
                                                }
                                                return '';
                                              }(),
                                            ),
                                            options: () {
                                              final result = List<String>.from(
                                                  functions.getListFromJsonPath(
                                                          FFAppState()
                                                              .plutogridTableInfo
                                                              .toList(),
                                                          '\$[?(@.view==\"orderWarehouse\")].states[*].id') ??
                                                      []);
                                              debugPrint(
                                                  '🔍 Dropdown options (IDs): $result');
                                              debugPrint(
                                                  '📊 plutogridTableInfo: ${FFAppState().plutogridTableInfo}');
                                              return result;
                                            }(),
                                            optionLabels:
                                                functions.getListFromJsonPath(
                                                        FFAppState()
                                                            .plutogridTableInfo
                                                            .toList(),
                                                        '\$[?(@.view==\"orderWarehouse\")].states[*].name') ??
                                                    [],
                                            onChanged: (val) async {
                                              safeSetState(() => _model
                                                  .stateGridDDValue = val);
                                              _model.updateGrid = await actions
                                                  .updateCurrentGridState(
                                                _model.stateGridDDValue,
                                                FFAppState()
                                                    .plutogridTableInfo
                                                    .toList(),
                                              );
                                              FFAppState().plutogridTableInfo =
                                                  _model.updateGrid!
                                                      .toList()
                                                      .cast<dynamic>();

                                              // Leer grid_state_list actual de la DB antes de guardar
                                              final userRow =
                                                  await UsersTable().queryRows(
                                                queryFn: (q) => q.eqOrNull(
                                                  'id',
                                                  currentUserUid,
                                                ),
                                              );

                                              List<dynamic> dbGridStateList =
                                                  [];
                                              if (userRow.isNotEmpty) {
                                                final raw =
                                                    userRow.first.gridStateList;
                                                dbGridStateList =
                                                    List<dynamic>.from(raw);
                                              }

                                              // Mergear: reemplazar solo la vista orderWarehouse
                                              final currentViewData =
                                                  FFAppState()
                                                      .plutogridTableInfo
                                                      .firstWhere(
                                                        (e) =>
                                                            e is Map &&
                                                            e['view'] ==
                                                                'orderWarehouse',
                                                        orElse: () =>
                                                            <String, dynamic>{},
                                                      );

                                              if (currentViewData is Map &&
                                                  currentViewData.isNotEmpty) {
                                                final idx = dbGridStateList
                                                    .indexWhere((e) =>
                                                        e is Map &&
                                                        e['view'] ==
                                                            'orderWarehouse');

                                                if (idx >= 0) {
                                                  dbGridStateList[idx] =
                                                      currentViewData;
                                                } else {
                                                  dbGridStateList
                                                      .add(currentViewData);
                                                }
                                              }

                                              // Persistir merged list a DB
                                              await UsersTable().update(
                                                data: {
                                                  'grid_state_list':
                                                      dbGridStateList,
                                                  'current_grid_set':
                                                      FFAppState()
                                                          .currentGridSet,
                                                },
                                                matchingRows: (rows) =>
                                                    rows.eqOrNull(
                                                  'id',
                                                  currentUserUid,
                                                ),
                                              );

                                              safeSetState(() {});
                                            },
                                            width: 200.0,
                                            height: 40.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'j3zffrgj' /* Select grid */,
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent4,
                                            borderWidth: 0.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxWidth: double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).height - 218,
                                      600.0,
                                    ),
                                    child: Stack(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      children: [
                                        Builder(
                                          builder: (context) => Container(
                                            width: FFAppState().navOpen == true
                                                ? (MediaQuery.sizeOf(context)
                                                        .width -
                                                    270)
                                                : (MediaQuery.sizeOf(context)
                                                        .width -
                                                    72),
                                            height: FFAppState().filterBool
                                                ? valueOrDefault<double>(
                                                    MediaQuery.sizeOf(context)
                                                            .height -
                                                        260,
                                                    600.0,
                                                  )
                                                : valueOrDefault<double>(
                                                    MediaQuery.sizeOf(context)
                                                            .height -
                                                        213,
                                                    600.0,
                                                  ),
                                            child: custom_widgets
                                                .PlutoGridorderwarehouse(
                                              width: FFAppState().navOpen ==
                                                      true
                                                  ? (MediaQuery.sizeOf(context)
                                                          .width -
                                                      270)
                                                  : (MediaQuery.sizeOf(context)
                                                          .width -
                                                      72),
                                              height: FFAppState().filterBool
                                                  ? valueOrDefault<double>(
                                                      MediaQuery.sizeOf(context)
                                                              .height -
                                                          260,
                                                      600.0,
                                                    )
                                                  : valueOrDefault<double>(
                                                      MediaQuery.sizeOf(context)
                                                              .height -
                                                          213,
                                                      600.0,
                                                    ),
                                              data: FFAppState()
                                                  .orderWarehouseApiOPJsonList,
                                              defaultColumnWidth: 200.0,
                                              language: valueOrDefault<String>(
                                                FFLocalizations.of(context)
                                                    .languageCode,
                                                'es',
                                              ),
                                              columns:
                                                  functions.stringToJson('''[
  {
    "column_name": "icons",
    "ui_en": "",
    "ui_es": "",
    "ui_sl": "",
    "width": 80,
    "datatype": "Icon"
  },
  {
    "column_name": "edit",
    "ui_en": "Edit",
    "ui_es": "Edición",
    "ui_sl": "Urejanje",
    "width": 40,
    "datatype": "Icon"
  },
  {
    "column_name": "copy",
    "ui_en": "Copy",
    "ui_es": "Copiar",
    "ui_sl": "Kopiraj",
    "width": 40,
    "datatype": "Icon"
  },
  {
    "column_name": "pdf",
    "ui_en": "PDF",
    "ui_es": "PDF",
    "ui_sl": "PDF",
    "width": 40,
    "datatype": "Icon"
  },
  {
    "column_name": "details",
    "ui_en": "Details",
    "ui_es": "Detalles",
    "ui_sl": "Podrobnosti",
    "width": 40,
    "datatype": "Icon"
  },
  {
    "column_name": "order_no",
    "ui_en": "Order No.",
    "ui_es": "N.º de orden",
    "ui_sl": "Št. naročila",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "inv_status",
    "ui_en": "Inv status",
    "ui_es": "Estado inv.",
    "ui_sl": "Status inv.",
    "width": 140,
    "datatype": "String"
  },
  {
    "column_name": "acepted",
    "ui_en": "Accept",
    "ui_es": "Aceptar",
    "ui_sl": "Sprejeto",
    "width": 100,
    "datatype": "bool"
  },
  {
    "column_name": "precheck",
    "ui_en": "Pre-Check",
    "ui_es": "Pre-chequeo",
    "ui_sl": "Predhodni pregled",
    "width": 140,
    "datatype": "bool"
  },
  {
    "column_name": "checked",
    "ui_en": "Check",
    "ui_es": "Chequeo",
    "ui_sl": "Pregledano",
    "width": 100,
    "datatype": "bool"
  },
  {
    "column_name": "warehouse_name",
    "ui_en": "Warehouse",
    "ui_es": "Almacén",
    "ui_sl": "Skladišče",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "order_status",
    "ui_en": "Order status",
    "ui_es": "Estado del pedido",
    "ui_sl": "Status naročila",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival Date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 140,
    "datatype": "DateTime"
  },
  {
    "column_name": "flow",
    "ui_en": "Flow",
    "ui_es": "Flujo",
    "ui_sl": "Tok",
    "width": 100,
    "datatype": "String"
  },
  {
    "column_name": "licence_plate",
    "ui_en": "Licence",
    "ui_es": "Placa",
    "ui_sl": "Registrska številka",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "improvement",
    "ui_en": "Improvement",
    "ui_es": "Mejora",
    "ui_sl": "Izboljšava",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 120,
    "datatype": "int"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 120,
    "datatype": "int"
  },
  {
    "column_name": "pallet_position",
    "ui_en": "Pallet position",
    "ui_es": "Posición de pallet",
    "ui_sl": "Položaj palete",
    "width": 180,
    "datatype": "double"
  },
  {
    "column_name": "universal_ref_no",
    "ui_en": "Universal ref num",
    "ui_es": "N.º de ref. universal",
    "ui_sl": "Univerzalna referenca",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "fms_ref",
    "ui_en": "FMS ref",
    "ui_es": "Ref. FMS",
    "ui_sl": "FMS referenca",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "load_ref_dvh",
    "ui_en": "Load ref DVH",
    "ui_es": "Ref. carga DVH",
    "ui_sl": "Referenca nalaganja DVH",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "custom_name",
    "ui_en": "Custom",
    "ui_es": "Aduana",
    "ui_sl": "Carina",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "internal_ref_custom",
    "ui_en": "Int custom",
    "ui_es": "Ref. aduana interna",
    "ui_sl": "Notranja carinska referenca",
    "width": 140,
    "datatype": "String"
  },
  {
    "column_name": "comment",
    "ui_en": "Comment",
    "ui_es": "Comentario",
    "ui_sl": "Komentar",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 140,
    "datatype": "List<String>"
  },
  {
    "column_name": "item",
    "ui_en": "Item",
    "ui_es": "Ítem",
    "ui_sl": "Element",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "opis_blaga",
    "ui_en": "Description",
    "ui_es": "Descripción",
    "ui_sl": "Opis",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "loading_type",
    "ui_en": "Type of un/upload",
    "ui_es": "Tipo de carga/descarga",
    "ui_sl": "Tip nakladanja/razkladanja",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "other_manipulation",
    "ui_en": "Other manipulations",
    "ui_es": "Otras manipulaciones",
    "ui_sl": "Drugi postopki",
    "width": 200,
    "datatype": "String"
  },
  {
    "column_name": "responsible_name",
    "ui_en": "Responsible",
    "ui_es": "Responsable",
    "ui_sl": "Odgovorna oseba",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "responsible_last_name",
    "ui_en": "Responsible Last",
    "ui_es": "Apellido Responsable",
    "ui_sl": "Priimek odgovorne osebe",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "assistant1_name",
    "ui_en": "Assistant 1",
    "ui_es": "Asistente 1",
    "ui_sl": "Pomočnik 1",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "assistant1_last_name",
    "ui_en": "Assistant1 Last",
    "ui_es": "Apellido Asistente1",
    "ui_sl": "Priimek pomočnika 1",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "assistant2_name",
    "ui_en": "Assistant 2",
    "ui_es": "Asistente 2",
    "ui_sl": "Pomočnik 2",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "assistant2_last_name",
    "ui_en": "Assistant2 Last",
    "ui_es": "Apellido Asistente2",
    "ui_sl": "Priimek pomočnika 2",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "admin_name",
    "ui_en": "Admin",
    "ui_es": "Administrador",
    "ui_sl": "Skrbnik",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "admin_last_name",
    "ui_en": "Admin Last",
    "ui_es": "Apellido Administrador",
    "ui_sl": "Priimek skrbnika",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "internal_accounting",
    "ui_en": "Internal number – accounting",
    "ui_es": "Número interno – contabilidad",
    "ui_sl": "Interna št. – računovodstvo",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "details_available",
    "ui_en": "Details Available",
    "ui_es": "Detalles disponibles",
    "ui_sl": "Podrobnosti na voljo",
    "width": 180,
    "datatype": "int"
  },
  {
    "column_name": "loading_gate_ramp",
    "ui_en": "Loading Gate Ramp",
    "ui_es": "Rampa de carga",
    "ui_sl": "Ramp za nalaganje",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "loading_sequence",
    "ui_en": "Loading gate sequence",
    "ui_es": "Secuencia de carga",
    "ui_sl": "Zaporedje vrat",
    "width": 180,
    "datatype": "int"
  },
  {
    "column_name": "loading_type2",
    "ui_en": "Type of un/upload 2",
    "ui_es": "Tipo de carga/descarga 2",
    "ui_sl": "Tip nakladanja/razkladanja 2",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "associated_orders",
    "ui_en": "Associated orders",
    "ui_es": "Órdenes asociadas",
    "ui_sl": "Povezana naročila",
    "width": 180,
    "datatype": "List<String>"
  },
  {
    "column_name": "availability",
    "ui_en": "Availability",
    "ui_es": "Disponibilidad",
    "ui_sl": "Razpoložljivost",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "damage_mark",
    "ui_en": "Damage Mark",
    "ui_es": "Marca de daño",
    "ui_sl": "Označba poškodbe",
    "width": 180,
    "datatype": "String"
  },
  {
    "column_name": "delete",
    "ui_en": "Delete",
    "ui_es": "Eliminar",
    "ui_sl": "Izbriši",
    "width": 40,
    "datatype": "Icon"
  }
]


'''),
                                              viewName: 'orderWarehouse',
                                              filteredColumns: FFAppState()
                                                  .orderWarehouseFilteredColumns,
                                              editAction: () async {
                                                FFAppState()
                                                    .goodDescriptionList = [];
                                                FFAppState().clientList = [];
                                                safeSetState(() {});
                                                FFAppState().clientApiB = false;
                                                FFAppState().clientApiId =
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
                                                FFAppState().clientApiV =
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
                                                FFAppState().addToClientList(
                                                    ClientRowStruct(
                                                  id: FFAppState()
                                                      .tablesRow
                                                      .client,
                                                  client: FFAppState()
                                                      .tablesRow
                                                      .clientName,
                                                ));
                                                safeSetState(() {});

                                                context.pushNamed(
                                                  EditFormWidget.routeName,
                                                  queryParameters: {
                                                    'orderJson': serializeParam(
                                                      FFAppState().tablesRow,
                                                      ParamType.DataStruct,
                                                    ),
                                                    'viewFrom': serializeParam(
                                                      getCurrentRoute(context),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              copyAction: () async {
                                                if ((FFAppState()
                                                            .tablesRow
                                                            .flow ==
                                                        'out') &&
                                                    (FFAppState()
                                                            .tablesRow
                                                            .associatedOrder ==
                                                        '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'This OUT order has no associated order.',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                } else {
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
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              AssociateQueryWidget(
                                                            yesP: () async {
                                                              _model.insertedRowOP =
                                                                  await OrderLevelTable()
                                                                      .insert({
                                                                'order_no':
                                                                    valueOrDefault<
                                                                        String>(
                                                                  FFAppState()
                                                                      .tablesRow
                                                                      .orderNo
                                                                      .substring(
                                                                          0,
                                                                          FFAppState().tablesRow.orderNo.length -
                                                                              3),
                                                                  '/',
                                                                ),
                                                                'quantity': 1,
                                                                'pallet_position':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .palletPosition,
                                                                'unit':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .details,
                                                                'weight':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .weight,
                                                                'good':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .good,
                                                                'good_description':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .goodDescription,
                                                                'packaging':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .packaging,
                                                                'barcodes':
                                                                    FFAppState()
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
                                                                'container_no':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .containerNo,
                                                                'client':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .client,
                                                                'inv_status':
                                                                    'najava',
                                                                'order_status':
                                                                    'novo naročilo',
                                                                'admin':
                                                                    currentUserUid,
                                                                'warehouse':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .warehouse,
                                                                'fms_ref':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .fmsRef,
                                                                'load_ref_dvh':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .loadRefDvh,
                                                                'universal_ref_no':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .universalRefNo,
                                                                'documents':
                                                                    FFAppState()
                                                                        .emptyList,
                                                                'flow': 'out',
                                                                'eta_i': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'eta_f': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'arrival': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'start': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'stop': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'custom':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .custom,
                                                                'associated_order':
                                                                    () {
                                                                  if (FFAppState()
                                                                          .tablesRow
                                                                          .flow ==
                                                                      'in') {
                                                                    return ((FFAppState().tablesRow.associatedOrder !=
                                                                                '') &&
                                                                            (FFAppState().tablesRow.associatedOrder !=
                                                                                '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')
                                                                        ? FFAppState()
                                                                            .tablesRow
                                                                            .associatedOrder
                                                                        : FFAppState()
                                                                            .tablesRow
                                                                            .id);
                                                                  } else if (FFAppState()
                                                                          .tablesRow
                                                                          .flow ==
                                                                      'out') {
                                                                    return FFAppState()
                                                                        .tablesRow
                                                                        .associatedOrder;
                                                                  } else {
                                                                    return '';
                                                                  }
                                                                }(),
                                                                'taric_code':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .taricCode,
                                                                'customs_percentage':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .customsPercentage,
                                                                'euro_or_dolar':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .euroOrDolar,
                                                                'exchange_rate_used':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .exchangeRateUsed,
                                                                'init_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .initCost,
                                                                'exchanged_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .exchangedCost,
                                                                'value_per_unit':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .valuePerUnit,
                                                                'custom_percentage_per_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .customPercentagePerCost,
                                                                'acumulated_customs_percentages':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .acumulatedCustomsPercentages,
                                                                'current_customs_warranty':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .currentCustomsWarranty,
                                                                'remaining_customs_threshold':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .remainingCustomsThreshold,
                                                                'dolars': 0.0,
                                                                'euros': 0.0,
                                                                'internal_ref_custom':
                                                                    '',
                                                                'weight_balance':
                                                                    0.0,
                                                                'group_consumed_threshold':
                                                                    0.0,
                                                              });
                                                              _model.refreshRowOP =
                                                                  await TablesGroup
                                                                      .refreshOrderLevelCalculatedColumnsCall
                                                                      .call(
                                                                rowId: _model
                                                                    .insertedRowOP
                                                                    ?.id,
                                                                userToken:
                                                                    currentJwtToken,
                                                              );

                                                              if (!(_model
                                                                      .refreshRowOP
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Refresh row error.',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            12.0,
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
                                                            },
                                                            noP: () async {
                                                              _model.insertedRow2OP =
                                                                  await OrderLevelTable()
                                                                      .insert({
                                                                'order_no':
                                                                    valueOrDefault<
                                                                        String>(
                                                                  FFAppState()
                                                                      .tablesRow
                                                                      .orderNo
                                                                      .substring(
                                                                          0,
                                                                          FFAppState().tablesRow.orderNo.length -
                                                                              3),
                                                                  '/',
                                                                ),
                                                                'quantity': 1,
                                                                'pallet_position':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .palletPosition,
                                                                'unit':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .details,
                                                                'weight':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .weight,
                                                                'good':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .good,
                                                                'good_description':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .goodDescription,
                                                                'packaging':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .packaging,
                                                                'barcodes':
                                                                    FFAppState()
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
                                                                'container_no':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .containerNo,
                                                                'client':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .client,
                                                                'inv_status':
                                                                    'najava',
                                                                'order_status':
                                                                    'novo naročilo',
                                                                'admin':
                                                                    currentUserUid,
                                                                'warehouse':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .warehouse,
                                                                'fms_ref':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .fmsRef,
                                                                'load_ref_dvh':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .loadRefDvh,
                                                                'universal_ref_no':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .universalRefNo,
                                                                'documents':
                                                                    FFAppState()
                                                                        .emptyList,
                                                                'flow': 'out',
                                                                'eta_i': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'eta_f': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'arrival': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'start': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'stop': supaSerialize<
                                                                        PostgresTime>(
                                                                    PostgresTime(
                                                                        functions
                                                                            .stringToDateTime('00:00'))),
                                                                'custom':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .custom,
                                                                'associated_order':
                                                                    '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b',
                                                                'taric_code':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .taricCode,
                                                                'customs_percentage':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .customsPercentage,
                                                                'euro_or_dolar':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .euroOrDolar,
                                                                'exchange_rate_used':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .exchangeRateUsed,
                                                                'init_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .initCost,
                                                                'exchanged_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .exchangedCost,
                                                                'value_per_unit':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .valuePerUnit,
                                                                'custom_percentage_per_cost':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .customPercentagePerCost,
                                                                'acumulated_customs_percentages':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .acumulatedCustomsPercentages,
                                                                'current_customs_warranty':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .currentCustomsWarranty,
                                                                'remaining_customs_threshold':
                                                                    FFAppState()
                                                                        .tablesRow
                                                                        .remainingCustomsThreshold,
                                                                'dolars': 0.0,
                                                                'euros': 0.0,
                                                                'internal_ref_custom':
                                                                    '',
                                                                'weight_balance':
                                                                    0.0,
                                                                'group_consumed_threshold':
                                                                    0.0,
                                                              });
                                                              _model.refreshRow2OP =
                                                                  await TablesGroup
                                                                      .refreshOrderLevelCalculatedColumnsCall
                                                                      .call(
                                                                rowId: _model
                                                                    .insertedRow2OP
                                                                    ?.id,
                                                                userToken:
                                                                    currentJwtToken,
                                                              );

                                                              if (!(_model
                                                                      .refreshRow2OP
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Refresh row error.',
                                                                      style:
                                                                          TextStyle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            12.0,
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
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              pdfAction: () async {
                                                await actions.getPDF(
                                                  FFAppState()
                                                      .tablesRow
                                                      .toMap(),
                                                );
                                              },
                                              detailsAction: () async {
                                                FFAppState()
                                                    .clearDetailsViewCache();
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: DetailsWidget(
                                                          orderId: FFAppState()
                                                              .tablesRow
                                                              .id,
                                                          orderNo: FFAppState()
                                                              .tablesRow
                                                              .orderNo,
                                                          warehouseIdDetails:
                                                              FFAppState()
                                                                  .tablesRow
                                                                  .warehouse,
                                                          flow: FFAppState()
                                                              .tablesRow
                                                              .flow,
                                                          associatedOrder:
                                                              FFAppState()
                                                                  .tablesRow
                                                                  .associatedOrder,
                                                        ),
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: SureQueryWidget(
                                                          saveChangesP:
                                                              () async {
                                                            await OrderLevelTable()
                                                                .update(
                                                              data: {
                                                                'is_deleted':
                                                                    true,
                                                              },
                                                              matchingRows:
                                                                  (rows) => rows
                                                                      .eqOrNull(
                                                                'id',
                                                                FFAppState()
                                                                    .tablesRow
                                                                    .id,
                                                              ),
                                                            );
                                                            _model.refreshRowOPCopy =
                                                                await TablesGroup
                                                                    .refreshOrderLevelCalculatedColumnsCall
                                                                    .call(
                                                              rowId:
                                                                  FFAppState()
                                                                      .tablesRow
                                                                      .id,
                                                              userToken:
                                                                  currentJwtToken,
                                                            );

                                                            if ((_model
                                                                    .refreshRowOPCopy
                                                                    ?.succeeded ??
                                                                true)) {
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Refresh row error.',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          12.0,
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
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                safeSetState(() {});
                                              },
                                              cellSelectAction: () async {
                                                _model.fixedColumns = [];
                                                safeSetState(() {});
                                                _model.addToFixedColumns(
                                                    FixedColumnsStruct(
                                                  invStatus: FFAppState()
                                                      .tablesRow
                                                      .invStatus,
                                                  orderNo: FFAppState()
                                                      .tablesRow
                                                      .orderNo,
                                                  client: FFAppState()
                                                      .tablesRow
                                                      .clientName,
                                                  availableQuantity:
                                                      valueOrDefault<double>(
                                                    FFAppState()
                                                        .tablesRow
                                                        .quantityAvailable
                                                        .toDouble(),
                                                    0.0,
                                                  ),
                                                ));
                                                safeSetState(() {});
                                              },
                                              documentsAction: () async {
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: DocumentsWidget(
                                                          orderId: FFAppState()
                                                              .tablesRow
                                                              .id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              filtersAction: () async {
                                                await Future.delayed(
                                                  Duration(
                                                    milliseconds: 100,
                                                  ),
                                                );
                                                if (!FFAppState()
                                                    .showFiltersPopUpOrderwarehouse) {
                                                  FFAppState()
                                                          .showFiltersPopUpOrderwarehouse =
                                                      true;
                                                  safeSetState(() {});
                                                }
                                              },
                                              gridStateAction: () async {
                                                // Leer grid_state_list actual de la DB
                                                final userRow =
                                                    await UsersTable()
                                                        .queryRows(
                                                  queryFn: (q) => q.eqOrNull(
                                                    'id',
                                                    currentUserUid,
                                                  ),
                                                );

                                                List<dynamic> dbGridStateList =
                                                    [];
                                                if (userRow.isNotEmpty) {
                                                  final raw = userRow
                                                      .first.gridStateList;
                                                  dbGridStateList =
                                                      List<dynamic>.from(raw);
                                                }

                                                // Mergear: reemplazar solo la vista orderWarehouse
                                                final currentViewData =
                                                    FFAppState()
                                                        .plutogridTableInfo
                                                        .firstWhere(
                                                          (e) =>
                                                              e is Map &&
                                                              e['view'] ==
                                                                  'orderWarehouse',
                                                          orElse: () => <String,
                                                              dynamic>{},
                                                        );

                                                if (currentViewData is Map &&
                                                    currentViewData
                                                        .isNotEmpty) {
                                                  // Buscar índice en dbGridStateList
                                                  final idx = dbGridStateList
                                                      .indexWhere((e) =>
                                                          e is Map &&
                                                          e['view'] ==
                                                              'orderWarehouse');

                                                  if (idx >= 0) {
                                                    dbGridStateList[idx] =
                                                        currentViewData;
                                                  } else {
                                                    dbGridStateList
                                                        .add(currentViewData);
                                                  }
                                                }

                                                // Guardar merged list
                                                await UsersTable().update(
                                                  data: {
                                                    'grid_state_list':
                                                        dbGridStateList,
                                                    'current_grid_set':
                                                        FFAppState()
                                                            .currentGridSet,
                                                  },
                                                  matchingRows: (rows) =>
                                                      rows.eqOrNull(
                                                    'id',
                                                    currentUserUid,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        if (FFAppState()
                                            .showFiltersPopUpOrderwarehouse)
                                          wrapWithModel(
                                            model: _model
                                                .filtersPopUpOrderWarehouseModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                FiltersPopUpOrderWarehouseWidget(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    28.0, 0.0, 28.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              _model.onlineSWValue != null
                                                  ? valueOrDefault<String>(
                                                      _model.onlineSWValue!
                                                          ? 'Online'
                                                          : 'Offline',
                                                      'Connecting...',
                                                    )
                                                  : 'Offline',
                                              'Connecting...',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: _model.onlineSWValue !=
                                                          null
                                                      ? (_model.onlineSWValue!
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .success
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Switch.adaptive(
                                            value: _model.onlineSWValue!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .onlineSWValue = newValue);
                                              if (newValue) {
                                                FFAppState().onlineMode = true;
                                                safeSetState(() {});
                                              } else {
                                                FFAppState().onlineMode = false;
                                                safeSetState(() {});
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .success,
                                            activeTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .tertiary,
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            inactiveThumbColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                          Container(
                                            width: 64.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(),
                                            child: Container(
                                              width: 80.0,
                                              child: TextFormField(
                                                controller: _model
                                                    .rowsQuantityTFTextController,
                                                focusNode: _model
                                                    .rowsQuantityTFFocusNode,
                                                onChanged: (_) =>
                                                    EasyDebounce.debounce(
                                                  '_model.rowsQuantityTFTextController',
                                                  Duration(milliseconds: 2000),
                                                  () async {
                                                    FFAppState().maxNumRows =
                                                        _model.rowsQuantityTFTextController
                                                                    .text !=
                                                                ''
                                                            ? valueOrDefault<
                                                                String>(
                                                                _model
                                                                    .rowsQuantityTFTextController
                                                                    .text,
                                                                '200',
                                                              )
                                                            : '200';
                                                    safeSetState(() {});
                                                  },
                                                ),
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'sfuh8dl0' /* rows... */,
                                                  ),
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                validator: _model
                                                    .rowsQuantityTFTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    Flexible(
                                      child: FlutterFlowChoiceChips(
                                        options: [
                                          ChipData(FFLocalizations.of(context)
                                              .getText(
                                            '8ssuu897' /* all */,
                                          )),
                                          ChipData(FFLocalizations.of(context)
                                              .getText(
                                            'olwk09ha' /* available */,
                                          )),
                                          ChipData(FFLocalizations.of(context)
                                              .getText(
                                            '7sys5903' /* disassociated */,
                                          )),
                                          ChipData(FFLocalizations.of(context)
                                              .getText(
                                            '59dfe1a7' /* error */,
                                          ))
                                        ],
                                        onChanged: (val) async {
                                          safeSetState(() =>
                                              _model.choiceChipsValue =
                                                  val?.firstOrNull);
                                          _model.choiceChipSelected =
                                              _model.choiceChipsValue!;
                                          safeSetState(() {});
                                          _model.newOrderWarehouseApiV =
                                              await actions.updateAvailability(
                                            _model.choiceChipSelected,
                                            FFAppState().orderWarehouseApiV,
                                          );
                                          FFAppState().orderWarehouseApiV =
                                              _model.newOrderWarehouseApiV!;
                                          await action_blocks
                                              .orderWarehouseAction(context);
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        selectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          iconSize: 18.0,
                                          elevation: 4.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        unselectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .tertiary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          iconSize: 18.0,
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        chipSpacing: 12.0,
                                        rowSpacing: 12.0,
                                        multiselect: false,
                                        initialized:
                                            _model.choiceChipsValue != null,
                                        alignment: WrapAlignment.start,
                                        controller: _model
                                                .choiceChipsValueController ??=
                                            FormFieldController<List<String>>(
                                          [
                                            FFLocalizations.of(context).getText(
                                              '8h9bxrgw' /* all */,
                                            )
                                          ],
                                        ),
                                        wrapped: true,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            FFAppState().goodDescriptionList =
                                                [];
                                            FFAppState().goodDescriptionApiV =
                                                '';
                                            FFAppState().goodDescriptionApiId =
                                                '';
                                            FFAppState().clientList = [];
                                            FFAppState().clientApiId = '';
                                            FFAppState().clientApiV = '';
                                            safeSetState(() {});
                                            FFAppState()
                                                .addToGoodDescriptionList(
                                                    GoodDescriptionRowStruct(
                                              id: '53a4144c-c413-4cb4-a951-b9c90ac94481',
                                              opisBlaga: '/',
                                            ));
                                            FFAppState().addToClientList(
                                                ClientRowStruct(
                                              id: '6f75cdd4-2581-48bb-b97e-443d506bfb63',
                                              client: '/',
                                            ));
                                            FFAppState().goodDescriptionApiV =
                                                '/';
                                            FFAppState().goodDescriptionApiId =
                                                '53a4144c-c413-4cb4-a951-b9c90ac94481';
                                            FFAppState().clientApiV = '/';
                                            FFAppState().clientApiId =
                                                '6f75cdd4-2581-48bb-b97e-443d506bfb63';
                                            safeSetState(() {});

                                            context.pushNamed(
                                              NewFormWidget.routeName,
                                              queryParameters: {
                                                'viewFrom': serializeParam(
                                                  getCurrentRoute(context),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '060myq9m' /* Create new record */,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
