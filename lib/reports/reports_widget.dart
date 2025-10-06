import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_reports_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/pages/floating/associate_query/associate_query_widget.dart';
import '/pages/floating/details/details_widget.dart';
import '/pages/floating/documents/documents_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reports_model.dart';
export 'reports_model.dart';

class ReportsWidget extends StatefulWidget {
  const ReportsWidget({
    super.key,
    String? orderWarehouseTablesKey,
    int? numberOfRows,
  })  : this.orderWarehouseTablesKey =
            orderWarehouseTablesKey ?? 'orderWarehouseTablesDefKey',
        this.numberOfRows = numberOfRows ?? 100;

  final String orderWarehouseTablesKey;
  final int numberOfRows;

  static String routeName = 'reports';
  static String routePath = '/reports';

  @override
  State<ReportsWidget> createState() => _ReportsWidgetState();
}

class _ReportsWidgetState extends State<ReportsWidget>
    with TickerProviderStateMixin {
  late ReportsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportsModel());

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
            'reports',
          );
        }),
        Future(() async {
          FFAppState().reportsApiV = '';
          safeSetState(() {});
          FFAppState().reportsApiV = (String var1) {
            return var1 + '&order=crono.desc.nullslast&is_deleted=eq.false';
          }(FFAppState().reportsApiV);
          await action_blocks.orderWarehouseAction(context);
          safeSetState(() {});
        }),
        Future(() async {
          _model.packagingApiOP = await TablesGroup.packagingCall.call(
            userToken: currentJwtToken,
          );

          _model.manipulationApiOP = await TablesGroup.manipulationCall.call(
            userToken: currentJwtToken,
          );

          FFAppState().packagingList = TablesGroup.packagingCall
              .packagingName(
                (_model.packagingApiOP?.jsonBody ?? ''),
              )!
              .toList()
              .cast<String>();
          FFAppState().manipulationList = TablesGroup.manipulationCall
              .manipulation(
                (_model.manipulationApiOP?.jsonBody ?? ''),
              )!
              .toList()
              .cast<String>();
          safeSetState(() {});
        }),
      ]);
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
        List<UsersRow> reportsUsersRowList = snapshot.data!;

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
                                  Icon(
                                    Icons.doorbell_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 32.0,
                                  ),
                                  if (FFAppState().navOpen == true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'yakl8w1o' /* Trampuž */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .fontStyle,
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/reports.svg',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '7uqhp8pp' /* Reports */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
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
                                            OrderWarehouseWidget.routeName);
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/orderwarehouse.svg',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'i1pfz7zq' /* Order warehouse */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/warehouse2.svg',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (FFAppState().navOpen == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'et4sokhi' /* Warehouse 2 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/calendar.svg',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.cover,
                                                ),
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
                                                        'wywtkc0i' /* Calendar */,
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
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/customs.svg',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.cover,
                                                ),
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
                                                        'zucv118b' /* Customs */,
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
                                          '18763ku5' /* Settings */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
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
                                  if (reportsUsersRowList
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
                                                        'e9bl6o82' /* Users */,
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
                                  if (reportsUsersRowList
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
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/extras.svg',
                                                    width: 24.0,
                                                    height: 24.0,
                                                    fit: BoxFit.cover,
                                                  ),
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
                                                        'atnu4jxq' /* Explore */,
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
                                userDetail: reportsUsersRowList
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
                  if ((reportsUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'superadmin') ||
                      (reportsUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'administrator'))
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: FutureBuilder<List<OrderLevelRow>>(
                          future: OrderLevelTable().queryRows(
                            queryFn: (q) => q
                                .eqOrNull(
                                  'is_deleted',
                                  false,
                                )
                                .order('crono'),
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
                            List<OrderLevelRow> maxWidthOrderLevelRowList =
                                snapshot.data!;

                            return Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            maxWidth: double.infinity,
                                          ),
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200.0,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 4.0,
                                                                12.0, 4.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'fcpvqdd4' /* Reports */,
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
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                28.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
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
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'xcnmxdqs' /* Reports */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
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
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'x6z5lxox' /* Here you have the general and ... */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
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
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '4nd2o6gw' /* Updates: */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
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
                                                                              36.0,
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
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    if (_model
                                                                            .tabBarCurrentIndex ==
                                                                        0) {
                                                                      await actions
                                                                          .getCsv2(
                                                                        FFAppState()
                                                                            .orderWarehouseApiOPJsonList
                                                                            .toList(),
                                                                        functions
                                                                            .stringToJson('''[
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival Date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 160,
    "datatype": "DateTime",
    "filter": "date"
  },
  {
    "column_name": "flow",
    "ui_en": "Flow",
    "ui_es": "Flujo",
    "ui_sl": "Tok",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "licence_plate",
    "ui_en": "Licence",
    "ui_es": "Placa",
    "ui_sl": "Registrska številka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "improvement",
    "ui_en": "Improvement",
    "ui_es": "Mejora",
    "ui_sl": "Izboljšava",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "universal_ref_no",
    "ui_en": "Universal ref num",
    "ui_es": "N.º de ref. universal",
    "ui_sl": "Univerzalna referenca",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "fms_ref",
    "ui_en": "FMS ref",
    "ui_es": "Ref. FMS",
    "ui_sl": "FMS referenca",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "load_ref_dvh",
    "ui_en": "Load ref dvh",
    "ui_es": "Ref. carga DVH",
    "ui_sl": "Referenca nalaganja DVH",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "item",
    "ui_en": "Good",
    "ui_es": "Good",
    "ui_sl": "Good",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "opis_blaga",
    "ui_en": "Good description",
    "ui_es": "Descripción del good",
    "ui_sl": "Opis gooda",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "loading_type",
    "ui_en": "Type of un/upload",
    "ui_es": "Tipo de carga/descarga",
    "ui_sl": "Tip nakladanja/razkladanja",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "other_manipulation",
    "ui_en": "Other manipulations",
    "ui_es": "Otras manipulaciones",
    "ui_sl": "Drugi postopki",
    "width": 200,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 160,
    "datatype": "List<String>",
    "filter": "contains"
  },
  {
    "column_name": "order_no",
    "ui_en": "Order N°",
    "ui_es": "N.º de orden asociado",
    "ui_sl": "Št. povez. naročila",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "custom_name",
    "ui_en": "Custom",
    "ui_es": "Aduana",
    "ui_sl": "Carina",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "internal_ref_custom",
    "ui_en": "Int custom",
    "ui_es": "Ref. aduana interna",
    "ui_sl": "Notranja carinska referenca",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  }
]
''')?.toList(),
                                                                      );
                                                                    } else {
                                                                      await actions
                                                                          .getCsv2(
                                                                        FFAppState()
                                                                            .orderWarehouseApiOPJsonList
                                                                            .toList(),
                                                                        functions
                                                                            .stringToJson('''[
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival Date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 160,
    "datatype": "DateTime",
    "filter": "date"
  },
  {
    "column_name": "inv_status",
    "ui_en": "Inventory status",
    "ui_es": "Estado de inventario",
    "ui_sl": "Status zaloge",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "item",
    "ui_en": "Good",
    "ui_es": "Good",
    "ui_sl": "Good",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "opis_blaga",
    "ui_en": "Good description",
    "ui_es": "Descripción",
    "ui_sl": "Opis",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 160,
    "datatype": "List<String>",
    "filter": "contains"
  }
]
''')?.toList(),
                                                                      );
                                                                    }
                                                                  },
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '1s82femk' /* Get csv */,
                                                                  ),
                                                                  icon: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .fileExcel,
                                                                    size: 15.0,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height:
                                                                        28.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              11.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 8.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 48.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment(0.0, 0),
                                                      child: TabBar(
                                                        labelColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        unselectedLabelColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                        unselectedLabelStyle:
                                                            TextStyle(),
                                                        indicatorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        indicatorWeight: 4.0,
                                                        tabs: [
                                                          Tab(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'h90z5128' /* General report */,
                                                            ),
                                                          ),
                                                          Tab(
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'lk2foi05' /* Stock report */,
                                                            ),
                                                          ),
                                                        ],
                                                        controller: _model
                                                            .tabBarController,
                                                        onTap: (i) async {
                                                          [
                                                            () async {},
                                                            () async {}
                                                          ][i]();
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TabBarView(
                                                        controller: _model
                                                            .tabBarController,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Builder(
                                                                    builder:
                                                                        (context) =>
                                                                            Container(
                                                                      width: FFAppState().navOpen == true
                                                                          ? (MediaQuery.sizeOf(context).width -
                                                                              270)
                                                                          : (MediaQuery.sizeOf(context).width -
                                                                              72),
                                                                      height: valueOrDefault<
                                                                          double>(
                                                                        MediaQuery.sizeOf(context).height -
                                                                            210,
                                                                        600.0,
                                                                      ),
                                                                      child: custom_widgets
                                                                          .PlutoGridorderwarehouse(
                                                                        width: FFAppState().navOpen == true
                                                                            ? (MediaQuery.sizeOf(context).width -
                                                                                270)
                                                                            : (MediaQuery.sizeOf(context).width -
                                                                                72),
                                                                        height:
                                                                            valueOrDefault<double>(
                                                                          MediaQuery.sizeOf(context).height -
                                                                              210,
                                                                          600.0,
                                                                        ),
                                                                        data: FFAppState()
                                                                            .reportsApiOPJsonList,
                                                                        defaultColumnWidth:
                                                                            200.0,
                                                                        language:
                                                                            'en',
                                                                        columns:
                                                                            functions.stringToJson('''[
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival Date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 160,
    "datatype": "DateTime",
    "filter": "date"
  },
  {
    "column_name": "flow",
    "ui_en": "Flow",
    "ui_es": "Flujo",
    "ui_sl": "Tok",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "licence_plate",
    "ui_en": "Licence",
    "ui_es": "Placa",
    "ui_sl": "Registrska številka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "improvement",
    "ui_en": "Improvement",
    "ui_es": "Mejora",
    "ui_sl": "Izboljšava",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "universal_ref_no",
    "ui_en": "Universal ref num",
    "ui_es": "N.º de ref. universal",
    "ui_sl": "Univerzalna referenca",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "fms_ref",
    "ui_en": "FMS ref",
    "ui_es": "Ref. FMS",
    "ui_sl": "FMS referenca",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "load_ref_dvh",
    "ui_en": "Load ref dvh",
    "ui_es": "Ref. carga DVH",
    "ui_sl": "Referenca nalaganja DVH",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "item",
    "ui_en": "Good",
    "ui_es": "Good",
    "ui_sl": "Good",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "opis_blaga",
    "ui_en": "Good description",
    "ui_es": "Descripción del good",
    "ui_sl": "Opis gooda",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "loading_type",
    "ui_en": "Type of un/upload",
    "ui_es": "Tipo de carga/descarga",
    "ui_sl": "Tip nakladanja/razkladanja",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "other_manipulation",
    "ui_en": "Other manipulations",
    "ui_es": "Otras manipulaciones",
    "ui_sl": "Drugi postopki",
    "width": 200,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 160,
    "datatype": "List<String>",
    "filter": "contains"
  },
  {
    "column_name": "order_no",
    "ui_en": "Order N°",
    "ui_es": "N.º de orden asociado",
    "ui_sl": "Št. povez. naročila",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "custom_name",
    "ui_en": "Custom",
    "ui_es": "Aduana",
    "ui_sl": "Carina",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "internal_ref_custom",
    "ui_en": "Int custom",
    "ui_es": "Ref. aduana interna",
    "ui_sl": "Notranja carinska referenca",
    "width": 160,
    "datatype": "String",
    "filter": "integer"
  }
]

'''),
                                                                        viewName:
                                                                            'reportsGeneral',
                                                                        filteredColumns:
                                                                            FFAppState().reportsFilteredColumns,
                                                                        editAction:
                                                                            () async {},
                                                                        copyAction:
                                                                            () async {
                                                                          if ((FFAppState().tablesRow.flow == 'out') &&
                                                                              (FFAppState().tablesRow.associatedOrder == '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  'This OUT order has no associated order.',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            );
                                                                          } else {
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
                                                                                    child: AssociateQueryWidget(
                                                                                      yesP: () async {
                                                                                        _model.insertedRowOP = await OrderLevelTable().insert({
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
                                                                                          'associated_order': () {
                                                                                            if (FFAppState().tablesRow.flow == 'in') {
                                                                                              return ((FFAppState().tablesRow.associatedOrder != '') && (FFAppState().tablesRow.associatedOrder != '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b') ? FFAppState().tablesRow.associatedOrder : FFAppState().tablesRow.id);
                                                                                            } else if (FFAppState().tablesRow.flow == 'out') {
                                                                                              return FFAppState().tablesRow.associatedOrder;
                                                                                            } else {
                                                                                              return '';
                                                                                            }
                                                                                          }(),
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
                                                                                        _model.refreshRowOP = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                          rowId: _model.insertedRowOP?.id,
                                                                                          userToken: currentJwtToken,
                                                                                        );

                                                                                        if (!(_model.refreshRowOP?.succeeded ?? true)) {
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
                                                                                        _model.insertedRow2OP = await OrderLevelTable().insert({
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
                                                                                        _model.refreshRow2OP = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                          rowId: _model.insertedRow2OP?.id,
                                                                                          userToken: currentJwtToken,
                                                                                        );

                                                                                        if (!(_model.refreshRow2OP?.succeeded ?? true)) {
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
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        pdfAction:
                                                                            () async {
                                                                          await actions
                                                                              .getPDF(
                                                                            FFAppState().tablesRow.toMap(),
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
                                                                                elevation: 0,
                                                                                insetPadding: EdgeInsets.zero,
                                                                                backgroundColor: Colors.transparent,
                                                                                alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                child: GestureDetector(
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
                                                                                    orderId: FFAppState().tablesRow.id,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        filtersAction:
                                                                            () async {
                                                                          if (!FFAppState()
                                                                              .showFiltersPopUpReports) {
                                                                            FFAppState().showFiltersPopUpReports =
                                                                                true;
                                                                            safeSetState(() {});
                                                                          }
                                                                        },
                                                                        gridStateAction:
                                                                            () async {
                                                                          await UsersTable()
                                                                              .update(
                                                                            data: {
                                                                              'last_grid_state': FFAppState().plutogridTableInfo,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Builder(
                                                                    builder:
                                                                        (context) =>
                                                                            Container(
                                                                      width: FFAppState().navOpen == true
                                                                          ? (MediaQuery.sizeOf(context).width -
                                                                              270)
                                                                          : (MediaQuery.sizeOf(context).width -
                                                                              72),
                                                                      height: valueOrDefault<
                                                                          double>(
                                                                        MediaQuery.sizeOf(context).height -
                                                                            210,
                                                                        600.0,
                                                                      ),
                                                                      child: custom_widgets
                                                                          .PlutoGridorderwarehouse(
                                                                        width: FFAppState().navOpen == true
                                                                            ? (MediaQuery.sizeOf(context).width -
                                                                                270)
                                                                            : (MediaQuery.sizeOf(context).width -
                                                                                72),
                                                                        height:
                                                                            valueOrDefault<double>(
                                                                          MediaQuery.sizeOf(context).height -
                                                                              210,
                                                                          600.0,
                                                                        ),
                                                                        data: FFAppState()
                                                                            .reportsApiOPJsonList,
                                                                        defaultColumnWidth:
                                                                            200.0,
                                                                        language:
                                                                            'en',
                                                                        columns:
                                                                            functions.stringToJson('''[
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival Date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 160,
    "datatype": "DateTime",
    "filter": "date"
  },
  {
    "column_name": "inv_status",
    "ui_en": "Inventory status",
    "ui_es": "Estado de inventario",
    "ui_sl": "Status zaloge",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
  },
  {
    "column_name": "item",
    "ui_en": "Good",
    "ui_es": "Good",
    "ui_sl": "Good",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "opis_blaga",
    "ui_en": "Good description",
    "ui_es": "Descripción",
    "ui_sl": "Opis",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 160,
    "datatype": "List<String>",
    "filter": "contains"
  }
]
'''),
                                                                        viewName:
                                                                            'reportsStock',
                                                                        filteredColumns:
                                                                            FFAppState().reportsFilteredColumns,
                                                                        editAction:
                                                                            () async {},
                                                                        copyAction:
                                                                            () async {
                                                                          if ((FFAppState().tablesRow.flow == 'out') &&
                                                                              (FFAppState().tablesRow.associatedOrder == '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b')) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(
                                                                                  'This OUT order has no associated order.',
                                                                                  style: TextStyle(
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                ),
                                                                                duration: Duration(milliseconds: 4000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            );
                                                                          } else {
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
                                                                                    child: AssociateQueryWidget(
                                                                                      yesP: () async {
                                                                                        _model.insertedRowOP1 = await OrderLevelTable().insert({
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
                                                                                          'associated_order': () {
                                                                                            if (FFAppState().tablesRow.flow == 'in') {
                                                                                              return ((FFAppState().tablesRow.associatedOrder != '') && (FFAppState().tablesRow.associatedOrder != '0e0c37f1-96bc-4cc2-a3f6-094e5e8f059b') ? FFAppState().tablesRow.associatedOrder : FFAppState().tablesRow.id);
                                                                                            } else if (FFAppState().tablesRow.flow == 'out') {
                                                                                              return FFAppState().tablesRow.associatedOrder;
                                                                                            } else {
                                                                                              return '';
                                                                                            }
                                                                                          }(),
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
                                                                                        _model.refreshRowOP2 = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                          rowId: _model.insertedRowOP1?.id,
                                                                                          userToken: currentJwtToken,
                                                                                        );

                                                                                        if (!(_model.refreshRowOP2?.succeeded ?? true)) {
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
                                                                                        _model.insertedRow2OP1 = await OrderLevelTable().insert({
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
                                                                                        _model.refreshRow2OP2 = await TablesGroup.refreshOrderLevelCalculatedColumnsCall.call(
                                                                                          rowId: _model.insertedRow2OP1?.id,
                                                                                          userToken: currentJwtToken,
                                                                                        );

                                                                                        if (!(_model.refreshRow2OP2?.succeeded ?? true)) {
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
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        pdfAction:
                                                                            () async {
                                                                          await actions
                                                                              .createPdf(
                                                                            FFAppState().tablesRow.orderNo,
                                                                            FFAppState().tablesRow.clientName,
                                                                            FFAppState().tablesRow.warehouseName,
                                                                            FFAppState().tablesRow.flow,
                                                                            FFAppState().tablesRow.licencePlate,
                                                                            FFAppState().tablesRow.containerNo,
                                                                            FFAppState().tablesRow.item,
                                                                            FFAppState().tablesRow.opisBlaga,
                                                                            FFAppState().tablesRow.palletPosition.toString(),
                                                                            FFAppState().tablesRow.weight.toString(),
                                                                            FFAppState().tablesRow.universalRefNo,
                                                                            FFAppState().tablesRow.fmsRef,
                                                                            FFAppState().tablesRow.loadRefDvh,
                                                                            FFAppState().tablesRow.customName,
                                                                            FFAppState().tablesRow.damageMark,
                                                                            FFAppState().tablesRow.comment,
                                                                            FFAppState().tablesRow.loadingType,
                                                                            valueOrDefault<String>(
                                                                              '${FFAppState().tablesRow.responsibleName} ${FFAppState().tablesRow.responsibleLastName}',
                                                                              '/',
                                                                            ),
                                                                            valueOrDefault<String>(
                                                                              '${FFAppState().tablesRow.assistant1Name} ${FFAppState().tablesRow.assistant2Name}',
                                                                              '/',
                                                                            ),
                                                                            FFAppState().tablesRow.otherManipulation,
                                                                            valueOrDefault<String>(
                                                                              dateTimeFormat(
                                                                                "yMMMd",
                                                                                functions.parsePostgresTimestamp(FFAppState().tablesRow.etaDate2),
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              ),
                                                                              '/',
                                                                            ),
                                                                            FFAppState().tablesRow.quantity.toString(),
                                                                            FFAppState().tablesRow.warehousePositionName,
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
                                                                                elevation: 0,
                                                                                insetPadding: EdgeInsets.zero,
                                                                                backgroundColor: Colors.transparent,
                                                                                alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                child: GestureDetector(
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
                                                                              'last_grid_state': FFAppState().plutogridTableInfo,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (FFAppState()
                                                  .showFiltersPopUpReports)
                                                wrapWithModel(
                                                  model: _model
                                                      .filtersPopUpReportsModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      FiltersPopUpReportsWidget(),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
