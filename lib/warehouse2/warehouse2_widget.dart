import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_warehouse2_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/components/light_mode/light_mode_widget.dart';
import '/pages/components/user_details/user_details_widget.dart';
import '/pages/floating/associate_query/associate_query_widget.dart';
import '/pages/floating/details/details_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'warehouse2_model.dart';
export 'warehouse2_model.dart';

class Warehouse2Widget extends StatefulWidget {
  const Warehouse2Widget({
    super.key,
    String? warehouse2TablesKey,
  }) : this.warehouse2TablesKey =
            warehouse2TablesKey ?? 'warehouse2TablesDefKey';

  final String warehouse2TablesKey;

  static String routeName = 'warehouse2';
  static String routePath = '/warehouse2';

  @override
  State<Warehouse2Widget> createState() => _Warehouse2WidgetState();
}

class _Warehouse2WidgetState extends State<Warehouse2Widget>
    with TickerProviderStateMixin {
  late Warehouse2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Warehouse2Model());

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
            'warehouse2',
          );
        }),
        Future(() async {
          // Check if we have saved filter values to restore
          if (FFAppState().warehouse2FilterValues.isEmpty) {
            FFAppState().warehouse2ApiV = '';
            safeSetState(() {});
            FFAppState().warehouse2ApiV = (String var1) {
              return var1 +
                  '&order=crono.desc.nullslast&availability=neq.consumed&is_deleted=eq.false&limit=50&custom_name=neq.CARINSKI%20POSTOPEK';
            }(FFAppState().warehouse2ApiV);
          }
          // else: warehouse2ApiV already has the saved query from filterAction
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
        uniqueQueryKey: valueOrDefault<String>(
          widget.warehouse2TablesKey,
          'warehouse2UsersDefKey',
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
        List<UsersRow> warehouse2UsersRowList = snapshot.data!;

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
                                                      'herxqh9m' /* Reports */,
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
                                              Icon(
                                                FontAwesomeIcons.boxesStacked,
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
                                                      'q3z2kzhq' /* Order warehouse */,
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
                                                FontAwesomeIcons.warehouse,
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
                                                      '9xz0x26y' /* Warehouse 2 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
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
                                                        'abhnwadp' /* Calendar */,
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
                                                        'asy0wtm9' /* Customs */,
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
                                          'onsxf48i' /* Settings */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Roboto',
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
                                  if (warehouse2UsersRowList
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
                                                        'r8wv2y24' /* Users */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
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
                                  if (warehouse2UsersRowList
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
                                                        '5vf7vs5q' /* Explore */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
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
                                userDetail: warehouse2UsersRowList
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
                  if ((warehouse2UsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'superadmin') ||
                      (warehouse2UsersRowList
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
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 4.0, 12.0, 4.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'uqmisslm' /* Warehouse 2 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'gewq9u1w' /* Movements */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'pkwucw9j' /* Below are the details of your ... */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'lzzntp6o' /* Updates: */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
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
                                                          fontSize: 16.0,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 4.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      FFAppState()
                                                          .updates
                                                          .toString(),
                                                      '0',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 36.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final fixedColumnsVar = _model
                                                      .fixedColumns
                                                      .toList();

                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Container(
                                                      width: 300.0,
                                                      height: 68.0,
                                                      child: DataTable2(
                                                        columns: [
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'fpybr0sz' /* Inventory status */,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  minFontSize:
                                                                      1.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '793l94ba' /* Order No. */,
                                                                  ),
                                                                  maxLines: 2,
                                                                  minFontSize:
                                                                      1.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          DataColumn2(
                                                            label:
                                                                DefaultTextStyle
                                                                    .merge(
                                                              softWrap: true,
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ragnfncj' /* Client */,
                                                                  ),
                                                                  maxLines: 2,
                                                                  minFontSize:
                                                                      1.0,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                        rows: fixedColumnsVar
                                                            .mapIndexed((fixedColumnsVarIndex,
                                                                    fixedColumnsVarItem) =>
                                                                [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        fixedColumnsVarItem
                                                                            .invStatus,
                                                                        '/',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          1.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        fixedColumnsVarItem
                                                                            .orderNo,
                                                                        '/',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          1.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontSize:
                                                                                10.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        fixedColumnsVarItem
                                                                            .client,
                                                                        '/',
                                                                      ).maybeHandleOverflow(
                                                                        maxChars:
                                                                            20,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      minFontSize:
                                                                          1.0,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ]
                                                                    .map((c) =>
                                                                        DataCell(
                                                                            c))
                                                                    .toList())
                                                            .map((e) => DataRow(
                                                                cells: e))
                                                            .toList(),
                                                        headingRowColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                        ),
                                                        headingRowHeight: 40.0,
                                                        dataRowColor:
                                                            WidgetStateProperty
                                                                .all(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                        ),
                                                        dataRowHeight: 28.0,
                                                        border: TableBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                        ),
                                                        dividerThickness: 2.0,
                                                        columnSpacing: 0.0,
                                                        showBottomBorder: true,
                                                        minWidth: 49.0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
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
                              Flexible(
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
                                                    218,
                                                600.0,
                                              ),
                                        child: custom_widgets
                                            .PlutoGridorderwarehouse(
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
                                                      218,
                                                  600.0,
                                                ),
                                          data: FFAppState()
                                              .warehouse2ApiOPJsonList,
                                          defaultColumnWidth: 200.0,
                                          language: valueOrDefault<String>(
                                            FFLocalizations.of(context)
                                                .languageCode,
                                            'es',
                                          ),
                                          columns: functions.stringToJson('''[
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
    "column_name": "warehouse_name",
    "ui_en": "Warehouse",
    "ui_es": "Almacén",
    "ui_sl": "Skladišče",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "order_no",
    "ui_en": "Order No.",
    "ui_es": "N.º de orden",
    "ui_sl": "Št. naročila",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "client_name",
    "ui_en": "Client",
    "ui_es": "Cliente",
    "ui_sl": "Stranka",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "order_status",
    "ui_en": "Order status",
    "ui_es": "Estado del pedido",
    "ui_sl": "Status naročila",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "acepted",
    "ui_en": "Accept",
    "ui_es": "Aceptar",
    "ui_sl": "Sprejeto",
    "width": 160,
    "datatype": "bool"
  },
  {
    "column_name": "precheck",
    "ui_en": "Pre‑Check",
    "ui_es": "Pre‑chequeo",
    "ui_sl": "Predhodni pregled",
    "width": 160,
    "datatype": "bool"
  },
  {
    "column_name": "checked",
    "ui_en": "Check",
    "ui_es": "Chequeo",
    "ui_sl": "Pregledano",
    "width": 160,
    "datatype": "bool"
  },
  {
    "column_name": "flow",
    "ui_en": "Flow",
    "ui_es": "Flujo",
    "ui_sl": "Tok",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "eta_date",
    "ui_en": "Arrival date",
    "ui_es": "Fecha de llegada",
    "ui_sl": "Datum prihoda",
    "width": 160,
    "datatype": "DateTime"
  },
  {
    "column_name": "eta_i",
    "ui_en": "Time (Approx.)",
    "ui_es": "Hora (aprox.)",
    "ui_sl": "Čas (približno)",
    "width": 160,
    "datatype": "DateTime"
  },
  {
    "column_name": "licence_plate",
    "ui_en": "Licence",
    "ui_es": "Placa",
    "ui_sl": "Registrska številka",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "improvement",
    "ui_en": "Improvement",
    "ui_es": "Mejora",
    "ui_sl": "Izboljšava",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º de contenedor",
    "ui_sl": "Št. zabojnika",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "arrival",
    "ui_en": "Arrival",
    "ui_es": "Llegada",
    "ui_sl": "Prihod",
    "width": 160,
    "datatype": "DateTime"
  },
  {
    "column_name": "loading_gate_ramp",
    "ui_en": "Loading Gate",
    "ui_es": "Puerta de carga",
    "ui_sl": "Vrata nalaganja",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "loading_sequence",
    "ui_en": "Load sequence",
    "ui_es": "Secuencia de carga",
    "ui_sl": "Zaporedje nalaganja",
    "width": 160,
    "datatype": "int"
  },
  {
    "column_name": "load_ref_dvh",
    "ui_en": "Load ref dvh",
    "ui_es": "Ref. carga DVH",
    "ui_sl": "Referenca nalaganja DVH",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 160,
    "datatype": "int"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Pakiranje",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight",
    "ui_es": "Peso",
    "ui_sl": "Teža",
    "width": 160,
    "datatype": "int"
  },
  {
    "column_name": "custom_name",
    "ui_en": "Custom",
    "ui_es": "Aduana",
    "ui_sl": "Carina",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "comment",
    "ui_en": "Comment",
    "ui_es": "Comentario",
    "ui_sl": "Komentar",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "documents",
    "ui_en": "Documents",
    "ui_es": "Documentos",
    "ui_sl": "Dokumenti",
    "width": 160,
    "datatype": "List<String>"
  },
  {
    "column_name": "admin_name",
    "ui_en": "Admin",
    "ui_es": "Administrador",
    "ui_sl": "Skrbnik",
    "width": 160,
    "datatype": "String"
  },
  {
    "column_name": "internal_ref_custom",
    "ui_en": "Int custom",
    "ui_es": "Ref. aduana interna",
    "ui_sl": "Notranja carinska referenca",
    "width": 160,
    "datatype": "String"
  }
]
'''),
                                          viewName: 'warehouse2',
                                          filteredColumns: FFAppState()
                                              .warehouse2FilterdColumns,
                                          editAction: () async {
                                            FFAppState().goodDescriptionList =
                                                [];
                                            FFAppState().clientList = [];
                                            safeSetState(() {});
                                            FFAppState().clientApiB = false;
                                            FFAppState().clientApiId =
                                                FFAppState().tablesRow.orderNo;
                                            FFAppState().goodDescriptionApiId =
                                                FFAppState()
                                                    .tablesRow
                                                    .goodDescription;
                                            FFAppState().goodDescriptionApiV =
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
                                              id: FFAppState().tablesRow.client,
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
                                            if ((FFAppState().tablesRow.flow ==
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                        FocusManager.instance
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
                                                                      FFAppState()
                                                                              .tablesRow
                                                                              .orderNo
                                                                              .length -
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
                                                            'weight':
                                                                FFAppState()
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
                                                                      FFAppState()
                                                                              .tablesRow
                                                                              .orderNo
                                                                              .length -
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
                                                            'weight':
                                                                FFAppState()
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
                                            }

                                            safeSetState(() {});
                                          },
                                          pdfAction: () async {
                                            await actions.getPDF(
                                              FFAppState().tablesRow.toMap(),
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
                                                  insetPadding: EdgeInsets.zero,
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
                                                          .instance.primaryFocus
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
                                          deleteAction: () async {},
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
                                          documentsAction: () async {},
                                          filtersAction: () async {
                                            if (!FFAppState()
                                                .showFiltersPopUpWarehouse2) {
                                              FFAppState()
                                                      .showFiltersPopUpWarehouse2 =
                                                  true;
                                              safeSetState(() {});
                                            }
                                          },
                                          gridStateAction: () async {
                                            await UsersTable().update(
                                              data: {
                                                'last_grid_state': FFAppState()
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
                                    if (FFAppState().showFiltersPopUpWarehouse2)
                                      wrapWithModel(
                                        model:
                                            _model.filtersPopUpWarehouse2Model,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: FiltersPopUpWarehouse2Widget(),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 28.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        FFAppState().goodDescriptionList = [];
                                        FFAppState().goodDescriptionApiV = '';
                                        FFAppState().goodDescriptionApiId = '';
                                        FFAppState().clientList = [];
                                        FFAppState().clientApiId = '';
                                        FFAppState().clientApiV = '';
                                        safeSetState(() {});
                                        FFAppState().addToGoodDescriptionList(
                                            GoodDescriptionRowStruct(
                                          id: '53a4144c-c413-4cb4-a951-b9c90ac94481',
                                          opisBlaga: '/',
                                        ));
                                        FFAppState()
                                            .addToClientList(ClientRowStruct(
                                          id: '6f75cdd4-2581-48bb-b97e-443d506bfb63',
                                          client: '/',
                                        ));
                                        FFAppState().goodDescriptionApiV = '/';
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
                                      text: FFLocalizations.of(context).getText(
                                        '3ndo5buw' /* Create new record */,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
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
