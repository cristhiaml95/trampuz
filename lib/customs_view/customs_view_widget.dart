import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/filters_pop_up_customs_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
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
import 'customs_view_model.dart';
export 'customs_view_model.dart';

class CustomsViewWidget extends StatefulWidget {
  const CustomsViewWidget({
    super.key,
    String? orderWarehouseTablesKey,
    int? numberOfRows,
  })  : this.orderWarehouseTablesKey =
            orderWarehouseTablesKey ?? 'orderWarehouseTablesDefKey',
        this.numberOfRows = numberOfRows ?? 100;

  final String orderWarehouseTablesKey;
  final int numberOfRows;

  static String routeName = 'customs_view';
  static String routePath = '/customs';

  @override
  State<CustomsViewWidget> createState() => _CustomsViewWidgetState();
}

class _CustomsViewWidgetState extends State<CustomsViewWidget>
    with TickerProviderStateMixin {
  late CustomsViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomsViewModel());

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
            'customs',
          );
        }),
        Future(() async {
          // Check if we have saved filter values to restore
          if (FFAppState().customsFilterValues.isEmpty) {
            FFAppState().customsApiV = '';
            safeSetState(() {});
            FFAppState().customsApiV = (String var1) {
              return var1 +
                  '&order=crono.desc.nullslast&availability=neq.consumed&is_deleted=eq.false&limit=50&custom=eq.756a1fad-8f1e-43d4-ad2a-00ffdca46299';
            }(FFAppState().customsApiV);
          }
          // else: customsApiV already has the saved query from filterAction
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
        List<UsersRow> customsViewUsersRowList = snapshot.data!;

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
                                                      'he2yjkvl' /* Reports */,
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
                                                      'sdt6gjp9' /* Order warehouse */,
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
                                                      'v0lhge0c' /* Warehouse 2 */,
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
                                                        'd6cn5hp1' /* Calendar */,
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
                                                FontAwesomeIcons.stamp,
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
                                                      'ut34cmou' /* Customs */,
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
                                          'z543utip' /* Settings */,
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
                                  if (customsViewUsersRowList
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
                                                        '8oq6xlf3' /* Users */,
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
                                  if (customsViewUsersRowList
                                          .where((e) => e.id == currentUserUid)
                                          .toList()
                                          .firstOrNull
                                          ?.userType ==
                                      'superadmin')
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
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
                                                      'ncy6lk05' /* Explore */,
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
                                userDetail: customsViewUsersRowList
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
                  if ((customsViewUsersRowList
                              .where((e) => e.id == currentUserUid)
                              .toList()
                              .firstOrNull
                              ?.userType ==
                          'superadmin') ||
                      (customsViewUsersRowList
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
                                    child: Visibility(
                                      visible: responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 200.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 4.0, 12.0, 4.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'nohujav5' /* Customs */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 28.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                            'w6900p22' /* Movements */,
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
                                                                fontSize: 16.0,
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
                                                            'g72mb9o7' /* Below are the details of your ... */,
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
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
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
                                                                    'pv3lclop' /* Updates: */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
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
                                                                padding:
                                                                    EdgeInsetsDirectional
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
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
                                                                    'vewoecpn' /* Quantity balance: */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        2.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                await actions
                                                                    .getCsv3(
                                                                  FFAppState()
                                                                      .orderWarehouseApiOPJsonList
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .plutogridTableInfo
                                                                      .toList(),
                                                                  functions
                                                                      .stringToJson(
                                                                          '''[
  { "column_name": "id",                              "ui_en": "Id",                                   "ui_es": "Id",                                   "ui_sl": "Id",                                   "width": 140, "datatype": "String" },
  { "column_name": "created_at",                      "ui_en": "Created At",                           "ui_es": "Created At",                           "ui_sl": "Created At",                           "width": 140, "datatype": "date" },
  { "column_name": "inv_status",                      "ui_en": "Inv Status",                           "ui_es": "Inv Status",                           "ui_sl": "Inv Status",                           "width": 140, "datatype": "String" },
  { "column_name": "order_no",                        "ui_en": "Order No",                             "ui_es": "Order No",                             "ui_sl": "Order No",                             "width": 140, "datatype": "String" },
  { "column_name": "flow",                            "ui_en": "Flow",                                 "ui_es": "Flow",                                 "ui_sl": "Flow",                                 "width": 140, "datatype": "String" },
  { "column_name": "order_status",                    "ui_en": "Order Status",                         "ui_es": "Order Status",                         "ui_sl": "Order Status",                         "width": 140, "datatype": "String" },
  { "column_name": "admin",                           "ui_en": "Admin",                                "ui_es": "Admin",                                "ui_sl": "Admin",                                "width": 140, "datatype": "String" },
  { "column_name": "warehouse",                       "ui_en": "Warehouse",                            "ui_es": "Warehouse",                            "ui_sl": "Warehouse",                            "width": 140, "datatype": "String" },
  { "column_name": "eta_date",                        "ui_en": "Eta Date",                             "ui_es": "Eta Date",                             "ui_sl": "Eta Date",                             "width": 140, "datatype": "date" },
  { "column_name": "eta_i",                           "ui_en": "Eta I",                                "ui_es": "Eta I",                                "ui_sl": "Eta I",                                "width": 140, "datatype": "time" },
  { "column_name": "eta_f",                           "ui_en": "Eta F",                                "ui_es": "Eta F",                                "ui_sl": "Eta F",                                "width": 140, "datatype": "time" },
  { "column_name": "arrival",                         "ui_en": "Arrival",                              "ui_es": "Arrival",                              "ui_sl": "Arrival",                              "width": 140, "datatype": "time" },
  { "column_name": "loading_gate",                    "ui_en": "Loading Gate",                         "ui_es": "Loading Gate",                         "ui_sl": "Loading Gate",                         "width": 140, "datatype": "String" },
  { "column_name": "loading_sequence",                "ui_en": "Loading Sequence",                     "ui_es": "Loading Sequence",                     "ui_sl": "Loading Sequence",                     "width": 140, "datatype": "integer" },
  { "column_name": "start",                           "ui_en": "Start",                                "ui_es": "Start",                                "ui_sl": "Start",                                "width": 140, "datatype": "time" },
  { "column_name": "stop",                            "ui_en": "Stop",                                 "ui_es": "Stop",                                 "ui_sl": "Stop",                                 "width": 140, "datatype": "time" },
  { "column_name": "licence_plate",                   "ui_en": "Licence Plate",                        "ui_es": "Licence Plate",                        "ui_sl": "Licence Plate",                        "width": 140, "datatype": "String" },
  { "column_name": "quantity",                        "ui_en": "Quantity",                             "ui_es": "Quantity",                             "ui_sl": "Quantity",                             "width": 140, "datatype": "integer" },
  { "column_name": "pallet_position",                 "ui_en": "Pallet Position",                      "ui_es": "Pallet Position",                      "ui_sl": "Pallet Position",                      "width": 140, "datatype": "double" },
  { "column_name": "unit",                            "ui_en": "Unit",                                 "ui_es": "Unit",                                 "ui_sl": "Unit",                                 "width": 140, "datatype": "integer" },
  { "column_name": "weight",                          "ui_en": "Weight",                               "ui_es": "Weight",                               "ui_sl": "Weight",                               "width": 140, "datatype": "integer" },
  { "column_name": "container_no",                    "ui_en": "Container No",                         "ui_es": "Container No",                         "ui_sl": "Container No",                         "width": 140, "datatype": "String" },
  { "column_name": "custom",                          "ui_en": "Custom",                               "ui_es": "Custom",                               "ui_sl": "Custom",                               "width": 140, "datatype": "String" },
  { "column_name": "responsible",                     "ui_en": "Responsible",                          "ui_es": "Responsible",                          "ui_sl": "Responsible",                          "width": 140, "datatype": "String" },
  { "column_name": "assistant1",                      "ui_en": "Assistant1",                           "ui_es": "Assistant1",                           "ui_sl": "Assistant1",                           "width": 140, "datatype": "String" },
  { "column_name": "assistant2",                      "ui_en": "Assistant2",                           "ui_es": "Assistant2",                           "ui_sl": "Assistant2",                           "width": 140, "datatype": "String" },
  { "column_name": "assistant3",                      "ui_en": "Assistant3",                           "ui_es": "Assistant3",                           "ui_sl": "Assistant3",                           "width": 140, "datatype": "String" },
  { "column_name": "assistant4",                      "ui_en": "Assistant4",                           "ui_es": "Assistant4",                           "ui_sl": "Assistant4",                           "width": 140, "datatype": "String" },
  { "column_name": "assistant5",                      "ui_en": "Assistant5",                           "ui_es": "Assistant5",                           "ui_sl": "Assistant5",                           "width": 140, "datatype": "String" },
  { "column_name": "assistant6",                      "ui_en": "Assistant6",                           "ui_es": "Assistant6",                           "ui_sl": "Assistant6",                           "width": 140, "datatype": "String" },
  { "column_name": "fms_ref",                         "ui_en": "Fms Ref",                              "ui_es": "Fms Ref",                              "ui_sl": "Fms Ref",                              "width": 140, "datatype": "String" },
  { "column_name": "load_ref_dvh",                    "ui_en": "Load Ref Dvh",                         "ui_es": "Load Ref Dvh",                         "ui_sl": "Load Ref Dvh",                         "width": 140, "datatype": "String" },
  { "column_name": "damage_mark",                     "ui_en": "Damage Mark",                          "ui_es": "Damage Mark",                          "ui_sl": "Damage Mark",                          "width": 140, "datatype": "String" },
  { "column_name": "universal_ref_no",                "ui_en": "Universal Ref No",                     "ui_es": "Universal Ref No",                     "ui_sl": "Universal Ref No",                     "width": 140, "datatype": "String" },
  { "column_name": "comment",                         "ui_en": "Comment",                              "ui_es": "Comment",                              "ui_sl": "Comment",                              "width": 140, "datatype": "String" },
  { "column_name": "loading_type",                    "ui_en": "Loading Type",                         "ui_es": "Loading Type",                         "ui_sl": "Loading Type",                         "width": 140, "datatype": "String" },
  { "column_name": "loading_type2",                   "ui_en": "Loading Type2",                        "ui_es": "Loading Type2",                        "ui_sl": "Loading Type2",                        "width": 140, "datatype": "String" },
  { "column_name": "document",                        "ui_en": "Document",                             "ui_es": "Document",                             "ui_sl": "Document",                             "width": 140, "datatype": "String" },
  { "column_name": "internal_accounting",             "ui_en": "Internal Accounting",                  "ui_es": "Internal Accounting",                  "ui_sl": "Internal Accounting",                  "width": 140, "datatype": "String" },
  { "column_name": "internal_ref_custom",             "ui_en": "Internal Ref Custom",                  "ui_es": "Internal Ref Custom",                  "ui_sl": "Internal Ref Custom",                  "width": 140, "datatype": "integer" },
  { "column_name": "crono",                           "ui_en": "Crono",                                "ui_es": "Crono",                                "ui_sl": "Crono",                                "width": 140, "datatype": "integer" },
  { "column_name": "client",                          "ui_en": "Client",                               "ui_es": "Client",                               "ui_sl": "Client",                               "width": 140, "datatype": "String" },
  { "column_name": "improvement",                     "ui_en": "Improvement",                          "ui_es": "Improvement",                          "ui_sl": "Improvement",                          "width": 140, "datatype": "String" },
  { "column_name": "other_manipulation",              "ui_en": "Other Manipulation",                   "ui_es": "Other Manipulation",                   "ui_sl": "Other Manipulation",                   "width": 140, "datatype": "String" },
  { "column_name": "good",                            "ui_en": "Good",                                 "ui_es": "Good",                                 "ui_sl": "Good",                                 "width": 140, "datatype": "String" },
  { "column_name": "good_description",                "ui_en": "Good Description",                     "ui_es": "Good Description",                     "ui_sl": "Good Description",                     "width": 140, "datatype": "String" },
  { "column_name": "barcodes",                        "ui_en": "Barcodes",                             "ui_es": "Barcodes",                             "ui_sl": "Barcodes",                             "width": 140, "datatype": "String" },
  { "column_name": "packaging",                       "ui_en": "Packaging",                            "ui_es": "Packaging",                            "ui_sl": "Packaging",                            "width": 140, "datatype": "String" },
  { "column_name": "documents",                       "ui_en": "Documents",                            "ui_es": "Documents",                            "ui_sl": "Documents",                            "width": 140, "datatype": "String" },
  { "column_name": "acepted",                         "ui_en": "Acepted",                              "ui_es": "Acepted",                              "ui_sl": "Acepted",                              "width": 140, "datatype": "boolean" },
  { "column_name": "checked",                         "ui_en": "Checked",                              "ui_es": "Checked",                              "ui_sl": "Checked",                              "width": 140, "datatype": "boolean" },
  { "column_name": "precheck",                        "ui_en": "Precheck",                             "ui_es": "Precheck",                             "ui_sl": "Precheck",                             "width": 140, "datatype": "boolean" },
  { "column_name": "no_barcodes",                     "ui_en": "No Barcodes",                          "ui_es": "No Barcodes",                          "ui_sl": "No Barcodes",                          "width": 140, "datatype": "String" },
  { "column_name": "received_barcodes",               "ui_en": "Received Barcodes",                    "ui_es": "Received Barcodes",                    "ui_sl": "Received Barcodes",                    "width": 140, "datatype": "String" },
  { "column_name": "repeated_barcodes",               "ui_en": "Repeated Barcodes",                    "ui_es": "Repeated Barcodes",                    "ui_sl": "Repeated Barcodes",                    "width": 140, "datatype": "String" },
  { "column_name": "associated_order",                "ui_en": "Associated Order",                     "ui_es": "Associated Order",                     "ui_sl": "Associated Order",                     "width": 140, "datatype": "String" },
  { "column_name": "is_deleted",                      "ui_en": "Is Deleted",                           "ui_es": "Is Deleted",                           "ui_sl": "Is Deleted",                           "width": 140, "datatype": "boolean" },
  { "column_name": "delete_datetime",                 "ui_en": "Delete Datetime",                      "ui_es": "Delete Datetime",                      "ui_sl": "Delete Datetime",                      "width": 140, "datatype": "date" },
  { "column_name": "deleter_user",                    "ui_en": "Deleter User",                         "ui_es": "Deleter User",                         "ui_sl": "Deleter User",                         "width": 140, "datatype": "String" },
  { "column_name": "created_at2",                     "ui_en": "Created At2",                          "ui_es": "Created At2",                          "ui_sl": "Created At2",                          "width": 140, "datatype": "String" },
  { "column_name": "admin_name",                      "ui_en": "Admin Name",                           "ui_es": "Admin Name",                           "ui_sl": "Admin Name",                           "width": 140, "datatype": "String" },
  { "column_name": "admin_last_name",                 "ui_en": "Admin Last Name",                      "ui_es": "Admin Last Name",                      "ui_sl": "Admin Last Name",                      "width": 140, "datatype": "String" },
  { "column_name": "warehouse_name",                  "ui_en": "Warehouse Name",                       "ui_es": "Warehouse Name",                       "ui_sl": "Warehouse Name",                       "width": 140, "datatype": "String" },
  { "column_name": "eta_date2",                       "ui_en": "Eta Date2",                            "ui_es": "Eta Date2",                            "ui_sl": "Eta Date2",                            "width": 140, "datatype": "String" },
  { "column_name": "eta_i2",                          "ui_en": "Eta I2",                               "ui_es": "Eta I2",                               "ui_sl": "Eta I2",                               "width": 140, "datatype": "String" },
  { "column_name": "eta_f2",                          "ui_en": "Eta F2",                               "ui_es": "Eta F2",                               "ui_sl": "Eta F2",                               "width": 140, "datatype": "String" },
  { "column_name": "arrival2",                        "ui_en": "Arrival2",                             "ui_es": "Arrival2",                             "ui_sl": "Arrival2",                             "width": 140, "datatype": "String" },
  { "column_name": "loading_gate_ramp",               "ui_en": "Loading Gate Ramp",                    "ui_es": "Loading Gate Ramp",                    "ui_sl": "Loading Gate Ramp",                    "width": 140, "datatype": "String" },
  { "column_name": "start2",                          "ui_en": "Start2",                               "ui_es": "Start2",                               "ui_sl": "Start2",                               "width": 140, "datatype": "String" },
  { "column_name": "stop2",                           "ui_en": "Stop2",                                "ui_es": "Stop2",                                "ui_sl": "Stop2",                                "width": 140, "datatype": "String" },
  { "column_name": "custom_name",                     "ui_en": "Custom Name",                          "ui_es": "Custom Name",                          "ui_sl": "Custom Name",                          "width": 140, "datatype": "String" },
  { "column_name": "responsible_name",                "ui_en": "Responsible Name",                     "ui_es": "Responsible Name",                     "ui_sl": "Responsible Name",                     "width": 140, "datatype": "String" },
  { "column_name": "responsible_last_name",           "ui_en": "Responsible Last Name",                "ui_es": "Responsible Last Name",                "ui_sl": "Responsible Last Name",                "width": 140, "datatype": "String" },
  { "column_name": "assistant1_name",                 "ui_en": "Assistant1 Name",                      "ui_es": "Assistant1 Name",                      "ui_sl": "Assistant1 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant1_last_name",            "ui_en": "Assistant1 Last Name",                 "ui_es": "Assistant1 Last Name",                 "ui_sl": "Assistant1 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "assistant2_name",                 "ui_en": "Assistant2 Name",                      "ui_es": "Assistant2 Name",                      "ui_sl": "Assistant2 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant2_last_name",            "ui_en": "Assistant2 Last Name",                 "ui_es": "Assistant2 Last Name",                 "ui_sl": "Assistant2 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "assistant3_name",                 "ui_en": "Assistant3 Name",                      "ui_es": "Assistant3 Name",                      "ui_sl": "Assistant3 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant3_last_name",            "ui_en": "Assistant3 Last Name",                 "ui_es": "Assistant3 Last Name",                 "ui_sl": "Assistant3 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "assistant4_name",                 "ui_en": "Assistant4 Name",                      "ui_es": "Assistant4 Name",                      "ui_sl": "Assistant4 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant4_last_name",            "ui_en": "Assistant4 Last Name",                 "ui_es": "Assistant4 Last Name",                 "ui_sl": "Assistant4 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "assistant5_name",                 "ui_en": "Assistant5 Name",                      "ui_es": "Assistant5 Name",                      "ui_sl": "Assistant5 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant5_last_name",            "ui_en": "Assistant5 Last Name",                 "ui_es": "Assistant5 Last Name",                 "ui_sl": "Assistant5 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "assistant6_name",                 "ui_en": "Assistant6 Name",                      "ui_es": "Assistant6 Name",                      "ui_sl": "Assistant6 Name",                      "width": 140, "datatype": "String" },
  { "column_name": "assistant6_last_name",            "ui_en": "Assistant6 Last Name",                 "ui_es": "Assistant6 Last Name",                 "ui_sl": "Assistant6 Last Name",                 "width": 140, "datatype": "String" },
  { "column_name": "client_name",                     "ui_en": "Client Name",                          "ui_es": "Client Name",                          "ui_sl": "Client Name",                          "width": 140, "datatype": "String" },
  { "column_name": "item",                            "ui_en": "Item",                                 "ui_es": "Item",                                 "ui_sl": "Item",                                 "width": 140, "datatype": "String" },
  { "column_name": "opis_blaga",                      "ui_en": "Opis Blaga",                           "ui_es": "Opis Blaga",                           "ui_sl": "Opis Blaga",                           "width": 140, "datatype": "String" },
  { "column_name": "packaging_name",                  "ui_en": "Packaging Name",                       "ui_es": "Packaging Name",                       "ui_sl": "Packaging Name",                       "width": 140, "datatype": "String" },
  { "column_name": "associated_order_no",             "ui_en": "Associated Order No",                  "ui_es": "Associated Order No",                  "ui_sl": "Associated Order No",                  "width": 140, "datatype": "String" },
  { "column_name": "quantity_available",              "ui_en": "Quantity Available",                   "ui_es": "Quantity Available",                   "ui_sl": "Quantity Available",                   "width": 140, "datatype": "integer" },
  { "column_name": "details_available",               "ui_en": "Details Available",                    "ui_es": "Details Available",                    "ui_sl": "Details Available",                    "width": 140, "datatype": "integer" },
  { "column_name": "associated_orders",               "ui_en": "Associated Orders",                    "ui_es": "Associated Orders",                    "ui_sl": "Associated Orders",                    "width": 140, "datatype": "String" },
  { "column_name": "associated_orders_ids",           "ui_en": "Associated Orders Ids",                "ui_es": "Associated Orders Ids",                "ui_sl": "Associated Orders Ids",                "width": 140, "datatype": "String" },
  { "column_name": "availability",                    "ui_en": "Availability",                         "ui_es": "Availability",                         "ui_sl": "Availability",                         "width": 140, "datatype": "String" },
  { "column_name": "admin_user_type",                 "ui_en": "Admin User Type",                      "ui_es": "Admin User Type",                      "ui_sl": "Admin User Type",                      "width": 140, "datatype": "String" },
  { "column_name": "details",                         "ui_en": "Details",                              "ui_es": "Details",                              "ui_sl": "Details",                              "width": 140, "datatype": "integer" },
  { "column_name": "barcode_list",                    "ui_en": "Barcode List",                         "ui_es": "Barcode List",                         "ui_sl": "Barcode List",                         "width": 140, "datatype": "String" },
  { "column_name": "init_cost",                       "ui_en": "Init Cost",                            "ui_es": "Init Cost",                            "ui_sl": "Init Cost",                            "width": 140, "datatype": "double" },
  { "column_name": "taric_code",                      "ui_en": "Taric Code",                           "ui_es": "Taric Code",                           "ui_sl": "Taric Code",                           "width": 140, "datatype": "String" },
  { "column_name": "customs_percentage",              "ui_en": "Customs Percentage",                   "ui_es": "Customs Percentage",                   "ui_sl": "Customs Percentage",                   "width": 140, "datatype": "double" },
  { "column_name": "euro_or_dolar",                   "ui_en": "Euro Or Dolar",                        "ui_es": "Euro Or Dolar",                        "ui_sl": "Euro Or Dolar",                        "width": 140, "datatype": "String" },
  { "column_name": "exchange_rate_used",              "ui_en": "Exchange Rate Used",                   "ui_es": "Exchange Rate Used",                   "ui_sl": "Exchange Rate Used",                   "width": 140, "datatype": "double" },
  { "column_name": "exchanged_cost",                  "ui_en": "Exchanged Cost",                       "ui_es": "Exchanged Cost",                       "ui_sl": "Exchanged Cost",                       "width": 140, "datatype": "double" },
  { "column_name": "value_per_unit",                  "ui_en": "Value Per Unit",                       "ui_es": "Value Per Unit",                       "ui_sl": "Value Per Unit",                       "width": 140, "datatype": "double" },
  { "column_name": "custom_percentage_per_cost",      "ui_en": "Custom Percentage Per Cost",           "ui_es": "Custom Percentage Per Cost",           "ui_sl": "Custom Percentage Per Cost",           "width": 140, "datatype": "double" },
  { "column_name": "acumulated_customs_percentages",  "ui_en": "Acumulated Customs Percentages",       "ui_es": "Acumulated Customs Percentages",       "ui_sl": "Acumulated Customs Percentages",       "width": 140, "datatype": "double" },
  { "column_name": "current_customs_warranty",        "ui_en": "Current Customs Warranty",             "ui_es": "Current Customs Warranty",             "ui_sl": "Current Customs Warranty",             "width": 140, "datatype": "double" },
  { "column_name": "remaining_customs_threshold",     "ui_en": "Remaining Customs Threshold",          "ui_es": "Remaining Customs Threshold",          "ui_sl": "Remaining Customs Threshold",          "width": 140, "datatype": "double" },
  { "column_name": "dolars",                          "ui_en": "Dolars",                               "ui_es": "Dolars",                               "ui_sl": "Dolars",                               "width": 140, "datatype": "double" },
  { "column_name": "euros",                           "ui_en": "Euros",                                "ui_es": "Euros",                                "ui_sl": "Euros",                                "width": 140, "datatype": "double" },
  { "column_name": "weight_balance",                  "ui_en": "Weight Balance",                       "ui_es": "Weight Balance",                       "ui_sl": "Weight Balance",                       "width": 140, "datatype": "double" },
  { "column_name": "warehouse_position_name",         "ui_en": "Warehouse Position Name",              "ui_es": "Warehouse Position Name",              "ui_sl": "Warehouse Position Name",              "width": 140, "datatype": "String" }
]

''')?.toList(),
                                                                  'customs',
                                                                  FFAppState()
                                                                      .todayExchangeType,
                                                                );
                                                              },
                                                              text: FFLocalizations
                                                                      .of(context)
                                                                  .getText(
                                                                '8yy6j8nm' /* Get csv */,
                                                              ),
                                                              icon: FaIcon(
                                                                FontAwesomeIcons
                                                                    .fileExcel,
                                                                size: 12.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 20.0,
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
                                                                    .secondaryText,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11.0,
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
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                            _model.fixedColumns
                                                                .toList();

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Container(
                                                            width: 400.0,
                                                            height: 68.0,
                                                            child: DataTable2(
                                                              columns: [
                                                                DataColumn2(
                                                                  label:
                                                                      DefaultTextStyle
                                                                          .merge(
                                                                    softWrap:
                                                                        true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'xhqhi36i' /* Customs garantee */,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            1.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn2(
                                                                  label:
                                                                      DefaultTextStyle
                                                                          .merge(
                                                                    softWrap:
                                                                        true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'uusy78oc' /* Order No. */,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            1.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn2(
                                                                  label:
                                                                      DefaultTextStyle
                                                                          .merge(
                                                                    softWrap:
                                                                        true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'rt73tmk7' /* Burdened guarantee */,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            1.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn2(
                                                                  label:
                                                                      DefaultTextStyle
                                                                          .merge(
                                                                    softWrap:
                                                                        true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'th9g1ght' /* Free warranty */,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            1.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn2(
                                                                  label:
                                                                      DefaultTextStyle
                                                                          .merge(
                                                                    softWrap:
                                                                        true,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'q75ko544' /* Threshold */,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            2,
                                                                        minFontSize:
                                                                            1.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelLarge
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows:
                                                                  fixedColumnsVar
                                                                      .mapIndexed((fixedColumnsVarIndex,
                                                                              fixedColumnsVarItem) =>
                                                                          [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: AutoSizeText(
                                                                                valueOrDefault<String>(
                                                                                  fixedColumnsVarItem.currentCustomsWarranty.toString(),
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
                                                                                functions
                                                                                    .reduceDouble(valueOrDefault<double>(
                                                                                          _model.fixedColumns.firstOrNull?.currentCustomsWarranty,
                                                                                          0.0,
                                                                                        ) -
                                                                                        valueOrDefault<double>(
                                                                                          _model.fixedColumns.firstOrNull?.remainingCustomsThreshold,
                                                                                          0.0,
                                                                                        ))
                                                                                    .toString()
                                                                                    .maybeHandleOverflow(
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
                                                                                  fixedColumnsVarItem.remainingCustomsThreshold.toString(),
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
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: FutureBuilder<List<InsuranceThresholdRow>>(
                                                                                future: InsuranceThresholdTable().querySingleRow(
                                                                                  queryFn: (q) => q.order('created_at'),
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
                                                                                  List<InsuranceThresholdRow> textInsuranceThresholdRowList = snapshot.data!;

                                                                                  final textInsuranceThresholdRow = textInsuranceThresholdRowList.isNotEmpty ? textInsuranceThresholdRowList.first : null;

                                                                                  return Text(
                                                                                    valueOrDefault<String>(
                                                                                      textInsuranceThresholdRow?.lastInsuranceThreshold.toString(),
                                                                                      '0',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ]
                                                                              .map((c) => DataCell(
                                                                                  c))
                                                                              .toList())
                                                                      .map((e) =>
                                                                          DataRow(
                                                                              cells: e))
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                              ),
                                                              dividerThickness:
                                                                  2.0,
                                                              columnSpacing:
                                                                  0.0,
                                                              showBottomBorder:
                                                                  true,
                                                              minWidth: 49.0,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 8.0, 0.0, 0.0),
                                    child: FlutterFlowDropDown<String>(
                                      controller:
                                          _model.stateGridDDValueController ??=
                                              FormFieldController<String>(
                                        _model.stateGridDDValue ??= () {
                                          // Obtener activeId de la vista customs
                                          try {
                                            final plutogrid =
                                                FFAppState().plutogridTableInfo;
                                            if (plutogrid.isNotEmpty) {
                                              final viewEntry =
                                                  plutogrid.firstWhere(
                                                (e) =>
                                                    e is Map &&
                                                    e['view'] == 'customs',
                                                orElse: () =>
                                                    <String, dynamic>{},
                                              );
                                              if (viewEntry is Map &&
                                                  viewEntry.containsKey(
                                                      'activeId')) {
                                                return viewEntry['activeId']
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
                                                    '\$[?(@.view==\"customs\")].states[*].id') ??
                                                []);
                                        debugPrint(
                                            '🔍 Dropdown options (IDs): $result');
                                        debugPrint(
                                            '📊 plutogridTableInfo: ${FFAppState().plutogridTableInfo}');
                                        return result;
                                      }(),
                                      optionLabels: functions.getListFromJsonPath(
                                              FFAppState()
                                                  .plutogridTableInfo
                                                  .toList(),
                                              '\$[?(@.view==\"customs\")].states[*].name') ??
                                          [],
                                      onChanged: (val) async {
                                        safeSetState(() =>
                                            _model.stateGridDDValue = val);

                                        // Guardar en Supabase: MERGE con otros views
                                        final currentTable = List<dynamic>.from(
                                            FFAppState().plutogridTableInfo);

                                        // Buscar índice de customs
                                        final customsIndex =
                                            currentTable.indexWhere((e) =>
                                                e is Map &&
                                                e['view'] == 'customs');

                                        if (customsIndex >= 0) {
                                          // Actualizar activeId solo en customs
                                          currentTable[customsIndex] = {
                                            ...currentTable[customsIndex]
                                                as Map,
                                            'activeId': _model.stateGridDDValue,
                                          };

                                          // Actualizar AppState
                                          FFAppState().plutogridTableInfo =
                                              currentTable;

                                          // Guardar en Supabase
                                          await UsersTable().update(
                                            data: {
                                              'grid_state_list': currentTable,
                                            },
                                            matchingRows: (rows) =>
                                                rows.eqOrNull(
                                              'id',
                                              currentUserUid,
                                            ),
                                          );
                                        }
                                      },
                                      width: 200.0,
                                      height: 40.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'j3zffrgj' /* Select grid */,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor:
                                          FlutterFlowTheme.of(context).accent4,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
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
                                      MediaQuery.sizeOf(context).height - 220,
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
                                                        210,
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
                                                          210,
                                                      600.0,
                                                    ),
                                              data: FFAppState()
                                                  .customsApiOPJsonList,
                                              defaultColumnWidth: 200.0,
                                              language: valueOrDefault<String>(
                                                FFLocalizations.of(context)
                                                    .languageCode,
                                                'en',
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
    "column_name": "pdf",
    "ui_en": "PDF",
    "ui_es": "PDF",
    "ui_sl": "PDF",
    "width": 40,
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
    "column_name": "order_no",
    "ui_en": "Order No.",
    "ui_es": "N.º de orden",
    "ui_sl": "Št. naročila",
    "width": 140,
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
    "column_name": "eta_date",
    "ui_en": "Date",
    "ui_es": "Fecha",
    "ui_sl": "Datum",
    "width": 120,
    "datatype": "date"
  },
  {
    "column_name": "flow",
    "ui_en": "IN / OUT",
    "ui_es": "IN / OUT",
    "ui_sl": "IN / OUT",
    "width": 90,
    "datatype": "String"
  },
  {
    "column_name": "licence_plate",
    "ui_en": "Licence Plate",
    "ui_es": "Matrícula",
    "ui_sl": "Reg. številka",
    "width": 140,
    "datatype": "String"
  },
  {
    "column_name": "improvement",
    "ui_en": "Procedure",
    "ui_es": "Procedimiento",
    "ui_sl": "Postopek",
    "width": 110,
    "datatype": "String"
  },
  {
    "column_name": "container_no",
    "ui_en": "Container No.",
    "ui_es": "N.º contenedor",
    "ui_sl": "Št. kontejnerja",
    "width": 150,
    "datatype": "String"
  },
  {
    "column_name": "fms_ref",
    "ui_en": "Ref. 1",
    "ui_es": "Ref. 1",
    "ui_sl": "Ref. 1",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "load_ref_dvh",
    "ui_en": "Ref. 2",
    "ui_es": "Ref. 2",
    "ui_sl": "Ref. 2",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "universal_ref_no",
    "ui_en": "Ref. 3",
    "ui_es": "Ref. 3",
    "ui_sl": "Ref. 3",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "quantity",
    "ui_en": "Quantity",
    "ui_es": "Cantidad",
    "ui_sl": "Količina",
    "width": 120,
    "datatype": "integer"
  },
  {
    "column_name": "quantity_available",
    "ui_en": "Stock Qty.",
    "ui_es": "Cant. stock",
    "ui_sl": "Zaloga – količina",
    "width": 140,
    "datatype": "integer"
  },
  {
    "column_name": "packaging_name",
    "ui_en": "Packaging",
    "ui_es": "Embalaje",
    "ui_sl": "Embalaža",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "weight",
    "ui_en": "Weight (kg)",
    "ui_es": "Peso (kg)",
    "ui_sl": "Teža (kg)",
    "width": 120,
    "datatype": "integer"
  },
  {
    "column_name": "weight_balance",
    "ui_en": "Stock Weight (kg)",
    "ui_es": "Peso stock (kg)",
    "ui_sl": "Zaloga – teža (kg)",
    "width": 140,
    "datatype": "integer"
  },
  {
    "column_name": "taric_code",
    "ui_en": "TARIC Code",
    "ui_es": "Código TARIC",
    "ui_sl": "TARIC koda",
    "width": 120,
    "datatype": "String"
  },
  {
    "column_name": "customs_percentage",
    "ui_en": "Customs %",
    "ui_es": "% Aduanas",
    "ui_sl": "% carine",
    "width": 110,
    "datatype": "double"
  },
  {
    "column_name": "euros",
    "ui_en": "EUR",
    "ui_es": "EUR",
    "ui_sl": "EUR",
    "width": 100,
    "datatype": "double"
  },
  {
    "column_name": "dolars",
    "ui_en": "USD",
    "ui_es": "USD",
    "ui_sl": "USD",
    "width": 100,
    "datatype": "double"
  },
  {
    "column_name": "init_cost",
    "ui_en": "Total Value",
    "ui_es": "Valor total",
    "ui_sl": "Skupna vrednost",
    "width": 160,
    "datatype": "double"
  },
  {
    "column_name": "value_per_unit",
    "ui_en": "Value per Unit",
    "ui_es": "Valor por unidad",
    "ui_sl": "Vrednost na enoto",
    "width": 160,
    "datatype": "double"
  },
  {
    "column_name": "exchanged_cost",
    "ui_en": "Customs Value (EUR)",
    "ui_es": "Valor aduanero (EUR)",
    "ui_sl": "Carinska vrednost (EUR)",
    "width": 180,
    "datatype": "double"
  },
  {
    "column_name": "custom_percentage_per_cost",
    "ui_en": "Custom % per Cost",
    "ui_es": "% Aduanas por costo",
    "ui_sl": "% carine na strošek",
    "width": 200,
    "datatype": "double"
  },
  {
    "column_name": "remaining_customs_threshold",
    "ui_en": "Remaining Customs Threshold",
    "ui_es": "Umbral aduanero restante",
    "ui_sl": "Preostali carinski prag",
    "width": 200,
    "datatype": "double"
  },
  {
    "column_name": "group_consumed_threshold",
    "ui_en": "Insurance consumed by group",
    "ui_es": "Seguro consumido por grupo",
    "ui_sl": "Zavarovanje, ki ga porabi skupina",
    "width": 200,
    "datatype": "double"
  },
  {
    "column_name": "warehouse_position_name",
    "ui_en": "Warehouse Pos.",
    "ui_es": "Pos. almacén",
    "ui_sl": "Poz. skladišča",
    "width": 160,
    "datatype": "String"
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
    "column_name": "internal_ref_custom",
    "ui_en": "Int custom",
    "ui_es": "Ref. aduana interna",
    "ui_sl": "Notranja carinska referenca",
    "width": 140,
    "datatype": "String"
  },{
    "column_name": "delete",
    "ui_en": "Delete",
    "ui_es": "Eliminar",
    "ui_sl": "Izbriši",
    "width": 40,
    "datatype": "Icon"
  }
]
'''),
                                              viewName: 'customs',
                                              filteredColumns: FFAppState()
                                                  .customsFilteredColumns,
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
                                                                    0.0,
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
                                                                    0.0,
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
                                                  currentCustomsWarranty:
                                                      valueOrDefault<double>(
                                                    functions.reduceDouble(
                                                        valueOrDefault<double>(
                                                      FFAppState()
                                                          .tablesRow
                                                          .currentCustomsWarranty,
                                                      0.0,
                                                    )),
                                                    0.0,
                                                  ),
                                                  remainingCustomsThreshold:
                                                      valueOrDefault<double>(
                                                    functions.reduceDouble(
                                                        valueOrDefault<double>(
                                                      FFAppState()
                                                          .tablesRow
                                                          .remainingCustomsThreshold,
                                                      0.0,
                                                    )),
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
                                                if (!FFAppState()
                                                    .showFiltersPopUpCustoms) {
                                                  FFAppState()
                                                          .showFiltersPopUpCustoms =
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
                                            .showFiltersPopUpCustoms)
                                          wrapWithModel(
                                            model:
                                                _model.filtersPopUpCustomsModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: FiltersPopUpCustomsWidget(),
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
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                                    '8b7rngl0' /* rows... */,
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
                                            'nq8gl8sf' /* Create new record */,
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
