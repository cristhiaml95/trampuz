import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_calendar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
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
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_model.dart';
export 'calendar_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    String? calendarKey,
  }) : this.calendarKey = calendarKey ?? 'calendarKeyDefKey';

  final String calendarKey;

  static String routeName = 'calendar';
  static String routePath = '/calendar';

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  late CalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
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
            'calendar',
          );
        }),
        Future(() async {
          _model.warehouseApiCallOP = await TablesGroup.warehouseCall.call();

          FFAppState().warehouseList = TablesGroup.warehouseCall
              .warehouseName(
                (_model.warehouseApiCallOP?.jsonBody ?? ''),
              )!
              .toList()
              .cast<String>();
          safeSetState(() {});
        }),
        Future(() async {
          // Check if we have saved filter values to restore
          if (FFAppState().calendarFilterValues.isEmpty) {
            FFAppState().calendarApiV = (String var1, String var2) {
              return var1 +
                  '&order=eta_date.desc.nullslast&eta_date=eq.' +
                  var2;
            }(
                FFAppState().calendarApiV,
                valueOrDefault<String>(
                  dateTimeFormat(
                    "yyyy-MM-dd",
                    getCurrentTimestamp,
                    locale: FFLocalizations.of(context).languageCode,
                  ),
                  '/',
                ));
            safeSetState(() {});
          }
          // else: calendarApiV already has the saved query from filterAction
          await action_blocks.orderWarehouseAction(context);
          safeSetState(() {});
        }),
        Future(() async {
          await action_blocks.exchangeTypeBlock(context);
        }),
      ]);
    });

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
        uniqueQueryKey: widget.calendarKey,
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
        List<UsersRow> calendarUsersRowList = snapshot.data!;

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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
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
                                                      'e81lwjk0' /* Reports */,
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
                                                        .secondaryBackground,
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
                                                      'r2yzm09a' /* Order warehouse */,
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
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
                                                      'dr5xxudp' /* Warehouse 2 */,
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
                                                FontAwesomeIcons.calendarDays,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
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
                                                        '38h9lzty' /* Calendar */,
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
                                              Icon(
                                                FontAwesomeIcons.stamp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
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
                                                        'dc1jvfjh' /* Customs */,
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
                                          'z9acdbvy' /* Settings */,
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
                                  if (calendarUsersRowList
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
                                                        '1fryj9i0' /* Users */,
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
                                  if (calendarUsersRowList
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
                                                  child: Icon(
                                                    FontAwesomeIcons.ellipsis,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 20.0,
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
                                                        'dt3rvtis' /* Explore */,
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
                                userDetail: calendarUsersRowList
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
                  if ((calendarUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'superadmin') ||
                      (calendarUsersRowList
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 4.0, 12.0, 4.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'xi5pl87s' /* Calendar */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '081bbeg6' /* Upcoming appointments. */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'hjdhyanu' /* Below are the details of your ... */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            200.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'hvgqwx33' /* Refresh manually */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await action_blocks
                                                        .orderWarehouseAction(
                                                            context);
                                                    safeSetState(() {});
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Refreshed successfully!',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12.0,
                                                            height: 0.25,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.refresh_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 8.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FlutterFlowCalendar(
                                color: FlutterFlowTheme.of(context).tertiary,
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                weekFormat: true,
                                weekStartsMonday: true,
                                twoRowHeader: true,
                                rowHeight: 48.0,
                                onChange: (DateTimeRange? newSelectedDate) {
                                  safeSetState(() => _model
                                      .calendarSelectedDay = newSelectedDate);
                                },
                                titleStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                dayOfWeekStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'Roboto',
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                dateStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                selectedDateStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                inactiveDateStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 8.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            FFAppState().calendarApiV = '';
                                            safeSetState(() {});
                                            FFAppState()
                                                .calendarApiV = (String var1,
                                                    String var2) {
                                              return var1 +
                                                  '&order=eta_date.desc.nullslast&eta_date=eq.' +
                                                  var2;
                                            }(
                                                FFAppState().orderWarehouseApiV,
                                                dateTimeFormat(
                                                  "yyyy-MM-dd",
                                                  _model.calendarSelectedDay!
                                                      .start,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ));
                                            safeSetState(() {});
                                            if (_model.warehouseDDValue !=
                                                    null &&
                                                _model.warehouseDDValue != '') {
                                              FFAppState().calendarApiV =
                                                  (String var1, String var2,
                                                          String var3) {
                                                return var1 +
                                                    '&warehouse_name=eq.' +
                                                    var2 +
                                                    '&eta_date=eq.' +
                                                    var3;
                                              }(
                                                      FFAppState()
                                                          .orderWarehouseApiV,
                                                      _model.warehouseDDValue!,
                                                      valueOrDefault<String>(
                                                        dateTimeFormat(
                                                          "yyyy-MM-dd",
                                                          _model
                                                              .calendarSelectedDay
                                                              ?.start,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        '/',
                                                      ));
                                              safeSetState(() {});
                                            }
                                            await action_blocks
                                                .orderWarehouseAction(context);
                                            safeSetState(() {});
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '3szriht0' /* Search */,
                                          ),
                                          icon: Icon(
                                            Icons.search,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 28.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
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
                                                      fontSize: 12.0,
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
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            64.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 100.0,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .warehouseDDValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: FFAppState()
                                                        .warehouseList,
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .warehouseDDValue =
                                                            val),
                                                    width: 100.0,
                                                    height: 40.0,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'hnmx914k' /* Warehouse... */,
                                                    ),
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 4.0,
                                                                16.0, 4.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      safeSetState(() {
                                                        _model
                                                            .warehouseDDValueController
                                                            ?.reset();
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.refresh_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Builder(
                                            builder: (context) => Container(
                                              width: FFAppState().navOpen ==
                                                      true
                                                  ? (MediaQuery.sizeOf(context)
                                                          .width -
                                                      270)
                                                  : (MediaQuery.sizeOf(context)
                                                          .width -
                                                      72),
                                              height: valueOrDefault<double>(
                                                MediaQuery.sizeOf(context)
                                                        .height -
                                                    351,
                                                200.0,
                                              ),
                                              child: custom_widgets
                                                  .PlutoGridorderwarehouse(
                                                width:
                                                    FFAppState().navOpen == true
                                                        ? (MediaQuery.sizeOf(
                                                                    context)
                                                                .width -
                                                            270)
                                                        : (MediaQuery.sizeOf(
                                                                    context)
                                                                .width -
                                                            72),
                                                height: valueOrDefault<double>(
                                                  MediaQuery.sizeOf(context)
                                                          .height -
                                                      351,
                                                  200.0,
                                                ),
                                                data: FFAppState()
                                                    .calendarApiOPJsonList,
                                                defaultColumnWidth: 200.0,
                                                language:
                                                    valueOrDefault<String>(
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                                  'es',
                                                ),
                                                columns:
                                                    functions.stringToJson('''[
  {
    "column_name": "edit",
    "ui_en": "Edit",
    "ui_es": "Edición",
    "ui_sl": "Urejanje",
    "width": 40,
    "datatype": "Icon",
    "filter": "none"
  },
  {
    "column_name": "details",
    "ui_en": "Details",
    "ui_es": "Detalles",
    "ui_sl": "Podrobnosti",
    "width": 40,
    "datatype": "Icon",
    "filter": "none"
  },
  {
    "column_name": "warehouse_name",
    "ui_en": "Warehouse",
    "ui_es": "Almacén",
    "ui_sl": "Skladišče",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "order_no",
    "ui_en": "Order No.",
    "ui_es": "N.º de orden",
    "ui_sl": "Št. naročila",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
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
    "column_name": "flow",
    "ui_en": "Flow",
    "ui_es": "Flujo",
    "ui_sl": "Tok",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "order_status",
    "ui_en": "Order status",
    "ui_es": "Estado del pedido",
    "ui_sl": "Status naročila",
    "width": 160,
    "datatype": "String",
    "filter": "dropdown"
  },
  {
    "column_name": "eta_i",
    "ui_en": "Time from",
    "ui_es": "Hora desde",
    "ui_sl": "Čas od",
    "width": 160,
    "datatype": "time",
    "filter": "date"
  },
  {
    "column_name": "eta_f",
    "ui_en": "Time to",
    "ui_es": "Hora hasta",
    "ui_sl": "Čas do",
    "width": 160,
    "datatype": "time",
    "filter": "date"
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
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int",
    "filter": "integer"
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
    "column_name": "admin_name",
    "ui_en": "Admin",
    "ui_es": "Administrador",
    "ui_sl": "Skrbnik",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  },
  {
    "column_name": "admin_last_name",
    "ui_en": "Admin Last",
    "ui_es": "Apellido Administrador",
    "ui_sl": "Priimek skrbnika",
    "width": 160,
    "datatype": "String",
    "filter": "contains"
  }
]

'''),
                                                viewName: 'calendar',
                                                filteredColumns: FFAppState()
                                                    .calendarFilterColumns,
                                                editAction: () async {
                                                  FFAppState()
                                                      .goodDescriptionList = [];
                                                  FFAppState().clientList = [];
                                                  safeSetState(() {});
                                                  FFAppState().clientApiB =
                                                      false;
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
                                                      'orderJson':
                                                          serializeParam(
                                                        FFAppState().tablesRow,
                                                        ParamType.DataStruct,
                                                      ),
                                                      'viewFrom':
                                                          serializeParam(
                                                        getCurrentRoute(
                                                            context),
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
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child:
                                                              GestureDetector(
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
                                                                  'unit': FFAppState()
                                                                      .tablesRow
                                                                      .details,
                                                                  'weight': FFAppState()
                                                                      .tablesRow
                                                                      .weight,
                                                                  'good': FFAppState()
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
                                                                  'client': FFAppState()
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
                                                                  'custom': FFAppState()
                                                                      .tablesRow
                                                                      .custom,
                                                                  'associated_order':
                                                                      () {
                                                                    if (FFAppState()
                                                                            .tablesRow
                                                                            .flow ==
                                                                        'in') {
                                                                      return ((FFAppState().tablesRow.associatedOrder != '') &&
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
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
                                                                  'unit': FFAppState()
                                                                      .tablesRow
                                                                      .details,
                                                                  'weight': FFAppState()
                                                                      .tablesRow
                                                                      .weight,
                                                                  'good': FFAppState()
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
                                                                  'client': FFAppState()
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
                                                                  'custom': FFAppState()
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
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
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: DetailsWidget(
                                                            orderId:
                                                                FFAppState()
                                                                    .tablesRow
                                                                    .id,
                                                            orderNo:
                                                                FFAppState()
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
                                                deleteAction: () async {},
                                                cellSelectAction: () async {},
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
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              DocumentsWidget(
                                                            orderId:
                                                                FFAppState()
                                                                    .tablesRow
                                                                    .id,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                filtersAction: () async {
                                                  if (!FFAppState()
                                                      .showFiltersPopUpCalendar) {
                                                    FFAppState()
                                                            .showFiltersPopUpCalendar =
                                                        true;
                                                    safeSetState(() {});
                                                  }
                                                },
                                                gridStateAction: () async {
                                                  await UsersTable().update(
                                                    data: {
                                                      'last_grid_state':
                                                          FFAppState()
                                                              .plutogridTableInfo,
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
                                              .showFiltersPopUpCalendar)
                                            wrapWithModel(
                                              model: _model
                                                  .filtersPopUpCalendarModel,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child:
                                                  FiltersPopUpCalendarWidget(),
                                            ),
                                        ],
                                      ),
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
