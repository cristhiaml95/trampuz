import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/floating/documents/documents_widget.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'forms_model.dart';
export 'forms_model.dart';

class FormsWidget extends StatefulWidget {
  const FormsWidget({
    super.key,
    required this.orderId,
    String? formsKey,
    int? page,
    required this.associatedOrder,
    required this.flow,
  })  : this.formsKey = formsKey ?? 'formsDefKey',
        this.page = page ?? 0;

  final String? orderId;
  final String formsKey;
  final int page;
  final String? associatedOrder;
  final String? flow;

  @override
  State<FormsWidget> createState() => _FormsWidgetState();
}

class _FormsWidgetState extends State<FormsWidget> {
  late FormsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormsModel());

    _model.orderNoTFTextController ??= TextEditingController();
    _model.orderNoTFFocusNode ??= FocusNode();

    _model.internalRefTFocusNode ??= FocusNode();

    _model.internalAccTFocusNode ??= FocusNode();

    _model.sequenceTextController ??= TextEditingController();
    _model.sequenceFocusNode ??= FocusNode();

    _model.licencePlateTFTextController ??= TextEditingController();
    _model.licencePlateTFFocusNode ??= FocusNode();

    _model.containerTFocusNode ??= FocusNode();

    _model.commentTFFocusNode ??= FocusNode();

    _model.quantityTFocusNode ??= FocusNode();

    _model.palletPositionTFocusNode ??= FocusNode();

    _model.unitTTextController ??= TextEditingController();
    _model.unitTFocusNode ??= FocusNode();

    _model.weightTFocusNode ??= FocusNode();

    _model.universalRefNumTFocusNode ??= FocusNode();

    _model.fmsRefTFocusNode ??= FocusNode();

    _model.loadRefDvhTFocusNode ??= FocusNode();

    _model.barcodesTFFocusNode ??= FocusNode();

    _model.repeatedBarcodesTFFocusNode ??= FocusNode();

    _model.nonExistentBarcodesTFFocusNode ??= FocusNode();

    _model.taricCodeTFFocusNode ??= FocusNode();

    _model.customsPercentageFocusNode ??= FocusNode();

    _model.costTFFocusNode ??= FocusNode();

    _model.exchangeRateTFFocusNode ??= FocusNode();

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

    return FutureBuilder<List<UsersRow>>(
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
        List<UsersRow> formsUsersRowList = snapshot.data!;

        return Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: FutureBuilder<List<VistaOrderLevelExtendedRow>>(
            future: VistaOrderLevelExtendedTable().querySingleRow(
              queryFn: (q) => q.eqOrNull(
                'id',
                widget.orderId,
              ),
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
              List<VistaOrderLevelExtendedRow>
                  containerVistaOrderLevelExtendedRowList = snapshot.data!;

              final containerVistaOrderLevelExtendedRow =
                  containerVistaOrderLevelExtendedRowList.isNotEmpty
                      ? containerVistaOrderLevelExtendedRowList.first
                      : null;

              return Container(
                width: 1200.0,
                height: 640.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(28.0),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: () {
                      if (_model.page == 0) {
                        return FlutterFlowTheme.of(context).secondary;
                      } else if (_model.page == 1) {
                        return FlutterFlowTheme.of(context).success;
                      } else if (_model.page == 2) {
                        return FlutterFlowTheme.of(context).primaryText;
                      } else if (_model.page == 3) {
                        return FlutterFlowTheme.of(context).info;
                      } else {
                        return FlutterFlowTheme.of(context).warning;
                      }
                    }(),
                    width: 8.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    28.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '4w4fampe' /* Edit record */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    28.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    containerVistaOrderLevelExtendedRow
                                        ?.orderNo,
                                    '/',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 0;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              's2ln34za' /* Announcement */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFCFE2F3),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).secondary,
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 2;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'ixgnt5vg' /* Vehicle, quantity */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFD9D9D9),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Color(0xFF1F262A),
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 1;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'slij6xnt' /* Time, ramp */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFD9EAD3),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Color(0xFF74DA7F),
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 3;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                3,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              '7mz1zveh' /* Manipulations, warehouses */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFD9D2E9),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).info,
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 4;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                4,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              '06cqog9s' /* Goods, ref. no, barcode */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFFCE5CD),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).warning,
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.page = 5;
                              safeSetState(() {});
                              await _model.pageViewController?.animateToPage(
                                5,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: FFLocalizations.of(context).getText(
                              'tquuujvr' /* Customs */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).tertiary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 4.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 40.0),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _model.pageViewController ??=
                                PageController(
                                    initialPage: max(
                                        0,
                                        min(
                                            valueOrDefault<int>(
                                              widget.page,
                                              0,
                                            ),
                                            5))),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Form(
                                key: _model.formKey2,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '2fq4wgnt' /* Order No:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                    .orderNoTFTextController,
                                                focusNode:
                                                    _model.orderNoTFFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.orderNo,
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFCFE2F3),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
                                                  ),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                validator: _model
                                                    .orderNoTFTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ej4ffm0k' /* Client:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              child: custom_widgets.ClientTFDD(
                                                width: 280.0,
                                                height: 50.0,
                                                clientList:
                                                    FFAppState().clientList,
                                                action: () async {
                                                  FFAppState().clientApiB =
                                                      true;
                                                  safeSetState(() {});
                                                  await action_blocks
                                                      .clientApiAction(context);
                                                  safeSetState(() {});
                                                },
                                                resetAction: () async {
                                                  FFAppState().clientApiB =
                                                      false;
                                                  FFAppState().clientApiId = '';
                                                  FFAppState().clientApiV = '';
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'iaur83ra' /* Input/output:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .flowDDValueController ??=
                                                  FormFieldController<String>(
                                                      null),
                                              options: [
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'beno68e9' /* in */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '4f68f0jj' /* out */,
                                                )
                                              ],
                                              onChanged: (val) => safeSetState(
                                                  () =>
                                                      _model.flowDDValue = val),
                                              width: 280.0,
                                              height: 50.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                              hintText:
                                                  containerVistaOrderLevelExtendedRow
                                                      ?.flow,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: Color(0xFFCFE2F3),
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '0pln6r7m' /* Estimated arrival:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                // etaDate
                                                final _datePicked1Date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      getCurrentTimestamp,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2050),
                                                  builder: (context, child) {
                                                    return wrapInMaterialDatePickerTheme(
                                                      context,
                                                      child!,
                                                      headerBackgroundColor:
                                                          Color(0xFFDEB6B7),
                                                      headerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      headerTextStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 32.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                              ),
                                                      pickerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      pickerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      selectedDateTimeBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      selectedDateTimeForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      actionButtonForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      iconSize: 24.0,
                                                    );
                                                  },
                                                );

                                                if (_datePicked1Date != null) {
                                                  safeSetState(() {
                                                    _model.datePicked1 =
                                                        DateTime(
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
                                              },
                                              child: Container(
                                                width: 280.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: Color(0xFFCFE2F3),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    _model.datePicked1 != null
                                                        ? dateTimeFormat(
                                                            "yMMMd",
                                                            _model.datePicked1,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )
                                                        : dateTimeFormat(
                                                            "yMMMd",
                                                            functions.parsePostgresTimestamp(
                                                                containerVistaOrderLevelExtendedRow!
                                                                    .etaDate2!),
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'er1iflkk' /* Order status:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .orderStatusDDValueController ??=
                                                  FormFieldController<String>(
                                                      null),
                                              options: [
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '4mm5s45u' /* novo naročilo */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'q8evheu3' /* izvajanje */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'c7ae11xt' /* zaključeno */,
                                                )
                                              ],
                                              onChanged: (val) => safeSetState(
                                                  () => _model
                                                          .orderStatusDDValue =
                                                      val),
                                              width: 280.0,
                                              height: 50.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  containerVistaOrderLevelExtendedRow
                                                      ?.orderStatus,
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: Color(0xFFCFE2F3),
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'rvm1e9wy' /* Warehouse:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FutureBuilder<List<WarehousesRow>>(
                                              future: FFAppState().warehouses(
                                                uniqueQueryKey:
                                                    widget.formsKey,
                                                requestFn: () =>
                                                    WarehousesTable().queryRows(
                                                  queryFn: (q) => q,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<WarehousesRow>
                                                    warehouseDDWarehousesRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .warehouseDDValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.warehouseDDValue ??=
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.warehouse,
                                                  ),
                                                  options: List<String>.from(
                                                      warehouseDDWarehousesRowList
                                                          .map((e) => e.id)
                                                          .toList()),
                                                  optionLabels:
                                                      warehouseDDWarehousesRowList
                                                          .map((e) =>
                                                              e.warehouse)
                                                          .toList(),
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                              .warehouseDDValue =
                                                          val),
                                                  width: 280.0,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText:
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.warehouseName,
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFFCFE2F3),
                                                  borderWidth: 2.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  hidesUnderline: true,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '3s4hp8em' /* Creation date:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                // creationDate
                                                final _datePicked2Date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      getCurrentTimestamp,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2050),
                                                  builder: (context, child) {
                                                    return wrapInMaterialDatePickerTheme(
                                                      context,
                                                      child!,
                                                      headerBackgroundColor:
                                                          Color(0xFFDEB6B7),
                                                      headerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      headerTextStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 32.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                              ),
                                                      pickerBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      pickerForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      selectedDateTimeBackgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      selectedDateTimeForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      actionButtonForegroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      iconSize: 24.0,
                                                    );
                                                  },
                                                );

                                                TimeOfDay? _datePicked2Time;
                                                if (_datePicked2Date != null) {
                                                  _datePicked2Time =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.fromDateTime(
                                                            getCurrentTimestamp),
                                                    builder: (context, child) {
                                                      return wrapInMaterialTimePickerTheme(
                                                        context,
                                                        child!,
                                                        headerBackgroundColor:
                                                            Color(0xFFDEB6B7),
                                                        headerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        headerTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .fontStyle,
                                                                ),
                                                        pickerBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        pickerForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        selectedDateTimeBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        selectedDateTimeForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        actionButtonForegroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  );
                                                }

                                                if (_datePicked2Date != null &&
                                                    _datePicked2Time != null) {
                                                  safeSetState(() {
                                                    _model.datePicked2 =
                                                        DateTime(
                                                      _datePicked2Date.year,
                                                      _datePicked2Date.month,
                                                      _datePicked2Date.day,
                                                      _datePicked2Time!.hour,
                                                      _datePicked2Time.minute,
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
                                                width: 280.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: Color(0xFFCFE2F3),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.datePicked2 != null
                                                          ? dateTimeFormat(
                                                              "yMMMd",
                                                              _model
                                                                  .datePicked2,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                          : dateTimeFormat(
                                                              "yMMMd",
                                                              functions.parsePostgresTimestamp(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .createdAt2!),
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                      '/',
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
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'n2o8wfi4' /* Admin:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .adminDDValueController ??=
                                                  FormFieldController<String>(
                                                _model.adminDDValue ??= '',
                                              ),
                                              options: List<String>.from(
                                                  formsUsersRowList
                                                      .map((e) => e.id)
                                                      .toList()),
                                              optionLabels: formsUsersRowList
                                                  .map((e) => e.lastName)
                                                  .toList(),
                                              onChanged: (val) => safeSetState(
                                                  () => _model.adminDDValue =
                                                      val),
                                              width: 280.0,
                                              height: 50.0,
                                              searchHintTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                              searchTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  '${containerVistaOrderLevelExtendedRow?.adminName} ${containerVistaOrderLevelExtendedRow?.adminLastName}',
                                              searchHintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'uh5dxl5p' /* Search for an item... */,
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: Color(0xFFCFE2F3),
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'x6to0e7v' /* Custom:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FutureBuilder<List<CustomsRow>>(
                                              future: FFAppState().customs(
                                                uniqueQueryKey:
                                                    widget.formsKey,
                                                requestFn: () =>
                                                    CustomsTable().queryRows(
                                                  queryFn: (q) => q,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<CustomsRow>
                                                    customDDCustomsRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .customDDValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.customDDValue ??= '',
                                                  ),
                                                  options: List<String>.from(
                                                      customDDCustomsRowList
                                                          .map((e) => e.id)
                                                          .toList()),
                                                  optionLabels:
                                                      customDDCustomsRowList
                                                          .map((e) => e.custom)
                                                          .toList(),
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                          .customDDValue = val),
                                                  width: 280.0,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText:
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.customName,
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFFCFE2F3),
                                                  borderWidth: 2.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  hidesUnderline: true,
                                                  isSearchable: false,
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: AutoSizeText(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'p7usehyk' /* Internal reference number - cu... */,
                                                ),
                                                textAlign: TextAlign.start,
                                                minFontSize: 6.0,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                        .internalRefTTextController ??=
                                                    TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.internalRefCustom,
                                                    '/',
                                                  ),
                                                ),
                                                focusNode: _model
                                                    .internalRefTFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.internalRefCustom,
                                                    '/',
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
                                                      color: Color(0xFFCFE2F3),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .internalRefTTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: AutoSizeText(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'jruby3lr' /* Internal accounting:   */,
                                                ),
                                                minFontSize: 6.0,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                        .internalAccTTextController ??=
                                                    TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.internalAccounting,
                                                    '/',
                                                  ),
                                                ),
                                                focusNode: _model
                                                    .internalAccTFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.internalAccounting,
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
                                                      color: Color(0xFFCFE2F3),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .internalAccTTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: AutoSizeText(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '52lqeszm' /* Documents:   */,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  minFontSize: 6.0,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
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
                                                              DocumentsWidget(
                                                            orderId: widget
                                                                .orderId!,
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 280.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFCFE2F3),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _model.formKey3,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '51d0v2pi' /* Inventory status:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .inventoryStatusDDValueController ??=
                                                  FormFieldController<String>(
                                                      null),
                                              options: [
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'd2ay29dq' /* najava */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '9mqiqqmd' /* obdelava */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ak1nrnrl' /* izdano */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ck4ekony' /* zaloga */,
                                                )
                                              ],
                                              onChanged: (val) => safeSetState(
                                                  () => _model
                                                          .inventoryStatusDDValue =
                                                      val),
                                              width: 280.0,
                                              height: 50.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: valueOrDefault<String>(
                                                containerVistaOrderLevelExtendedRow
                                                    ?.invStatus,
                                                'brez izbire',
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: Color(0xFFD9EAD3),
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'g5m6fbuf' /* Announced time 1:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.announcedTime1T =
                                                    await actions.selectTime(
                                                  context,
                                                );

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 280.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFD9EAD3),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.announcedTime1T !=
                                                              null
                                                          ? dateTimeFormat(
                                                              "Hm",
                                                              _model
                                                                  .announcedTime1T,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                          : dateTimeFormat(
                                                              "Hm",
                                                              functions.parsePostgresTimestamp(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .etaI2!),
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                      '/',
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
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'uoxtbao7' /* Announced time 2:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.announcedTime2T =
                                                    await actions.selectTime(
                                                  context,
                                                );

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 280.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFD9EAD3),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.announcedTime2T !=
                                                              null
                                                          ? dateTimeFormat(
                                                              "Hm",
                                                              _model
                                                                  .announcedTime2T,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                          : dateTimeFormat(
                                                              "Hm",
                                                              functions.parsePostgresTimestamp(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .etaF2!),
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                      '/',
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
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'b63594nl' /* Arrival:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.arrivalT =
                                                    await actions.selectTime(
                                                  context,
                                                );

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 280.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: Color(0xFFD9EAD3),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.arrivalT != null
                                                          ? dateTimeFormat(
                                                              "Hm",
                                                              _model.arrivalT,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )
                                                          : dateTimeFormat(
                                                              "Hm",
                                                              functions.parsePostgresTimestamp(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .arrival2!),
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                      '/',
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
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '7pkfn8ib' /* Loading gate:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            FutureBuilder<
                                                List<LoadingGatesRow>>(
                                              future: FFAppState().loadingGates(
                                                uniqueQueryKey:
                                                    widget.formsKey,
                                                requestFn: () =>
                                                    LoadingGatesTable()
                                                        .queryRows(
                                                  queryFn: (q) => q,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<LoadingGatesRow>
                                                    loadingGateDDLoadingGatesRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .loadingGateDDValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.loadingGateDDValue ??=
                                                        '',
                                                  ),
                                                  options: List<String>.from(
                                                      loadingGateDDLoadingGatesRowList
                                                          .where((e) =>
                                                              e.warehouse ==
                                                              _model
                                                                  .warehouseDDValue)
                                                          .toList()
                                                          .map((e) => e.id)
                                                          .toList()),
                                                  optionLabels:
                                                      loadingGateDDLoadingGatesRowList
                                                          .where((e) =>
                                                              e.warehouse ==
                                                              _model
                                                                  .warehouseDDValue)
                                                          .toList()
                                                          .map((e) => e.ramp)
                                                          .toList(),
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                              .loadingGateDDValue =
                                                          val),
                                                  width: 280.0,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.loadingGateRamp,
                                                    'brez izbire',
                                                  ),
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFFD9EAD3),
                                                  borderWidth: 2.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  hidesUnderline: true,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'ggnfr75d' /* Loading gate sequence:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                    .sequenceTextController,
                                                focusNode:
                                                    _model.sequenceFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.loadingSequence
                                                        ?.toString(),
                                                    '-1',
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
                                                      color: Color(0xFFD9EAD3),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .sequenceTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '5b3d3y3h' /* Start (upload/unload):   */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.startT =
                                                      await actions.selectTime(
                                                    context,
                                                  );

                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: 280.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Color(0xFFD9EAD3),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        _model.startT != null
                                                            ? dateTimeFormat(
                                                                "Hm",
                                                                _model.startT,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )
                                                            : dateTimeFormat(
                                                                "Hm",
                                                                functions.parsePostgresTimestamp(
                                                                    containerVistaOrderLevelExtendedRow!
                                                                        .start2!),
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                        'brez izbire',
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'p0vxwlax' /* Stop (upload/unload):   */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.stopT =
                                                      await actions.selectTime(
                                                    context,
                                                  );

                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: 280.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color: Color(0xFFD9EAD3),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        _model.stopT != null
                                                            ? dateTimeFormat(
                                                                "Hm",
                                                                _model.stopT,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )
                                                            : dateTimeFormat(
                                                                "Hm",
                                                                functions.parsePostgresTimestamp(
                                                                    containerVistaOrderLevelExtendedRow!
                                                                        .stop2!),
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                        'brez izbire',
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _model.formKey6,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 160.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'jsq2xkyk' /* Licence plate No:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 280.0,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .licencePlateTFTextController,
                                                    focusNode: _model
                                                        .licencePlateTFFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: valueOrDefault<
                                                          String>(
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.licencePlate,
                                                        'brez izbire',
                                                      ),
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFD9D9D9),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    validator: _model
                                                        .licencePlateTFTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 160.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'e0d8yka2' /* Improvement:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .improvementDDValueController ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options: [
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'l8k0xuaf' /* kont.-20" */,
                                                    ),
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '4citue3o' /* kont.-40" */,
                                                    ),
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '4y1sq1d7' /* kont.-45" */,
                                                    ),
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '2572s363' /* cerada */,
                                                    ),
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'aj0w8yyo' /* hladilnik */,
                                                    ),
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'onw3427g' /* silos */,
                                                    )
                                                  ],
                                                  onChanged: (val) =>
                                                      safeSetState(() => _model
                                                              .improvementDDValue =
                                                          val),
                                                  width: 280.0,
                                                  height: 50.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.improvement,
                                                    'brez izbire',
                                                  ),
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      Color(0xFFD9D9D9),
                                                  borderWidth: 2.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
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
                                                  width: 160.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '241xgsk0' /* Container No:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 280.0,
                                                  child: TextFormField(
                                                    controller: _model
                                                            .containerTTextController ??=
                                                        TextEditingController(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.containerNo,
                                                        '/',
                                                      ),
                                                    ),
                                                    focusNode: _model
                                                        .containerTFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: valueOrDefault<
                                                          String>(
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.containerNo,
                                                        'brez izbire',
                                                      ),
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFD9D9D9),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    validator: _model
                                                        .containerTTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '1luorh6t' /* Comment:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 280.0,
                                                        child: TextFormField(
                                                          controller: _model
                                                                  .commentTFTextController ??=
                                                              TextEditingController(
                                                            text:
                                                                containerVistaOrderLevelExtendedRow
                                                                    ?.comment,
                                                          ),
                                                          focusNode: _model
                                                              .commentTFFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                              '2x6bir61' /* Insert new value... */,
                                                            ),
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFD9D9D9),
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                          maxLines: 8,
                                                          validator: _model
                                                              .commentTFTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '6v4a337z' /* Quantity:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                              child: Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .quantityTTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.quantity
                                                          ?.toString(),
                                                      '-1',
                                                    ),
                                                  ),
                                                  focusNode:
                                                      _model.quantityTFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.quantity
                                                          ?.toString(),
                                                      '-1',
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
                                                            Color(0xFFD9D9D9),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: _model
                                                      .quantityTTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'n93uyp2z' /* Pallet position:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                              child: Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .palletPositionTTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.palletPosition
                                                          ?.toString(),
                                                      '-1',
                                                    ),
                                                  ),
                                                  focusNode: _model
                                                      .palletPositionTFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '963ibpdr' /* Insert new value... */,
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
                                                            Color(0xFFD9D9D9),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  validator: _model
                                                      .palletPositionTTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            '^\\d*\\.?\\d*\$'))
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
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'bbrh0h2w' /* Pre - Check:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 296.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model
                                                          .preCheckCBValue ??=
                                                      containerVistaOrderLevelExtendedRow!
                                                          .precheck!,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() =>
                                                        _model.preCheckCBValue =
                                                            newValue!);
                                                  },
                                                  side: (FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '8c0v3o3c' /* Check:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: 296.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model.checkCBValue ??=
                                                      containerVistaOrderLevelExtendedRow!
                                                          .checked!,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() =>
                                                        _model.checkCBValue =
                                                            newValue!);
                                                  },
                                                  side: (FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .success,
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'x7scfgzz' /* Unit:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                if (valueOrDefault<bool>(
                                                  _model.checkboxValue,
                                                  false,
                                                ))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    child: Container(
                                                      width: 280.0,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .unitTTextController,
                                                        focusNode: _model
                                                            .unitTFocusNode,
                                                        autofocus: false,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              valueOrDefault<
                                                                  String>(
                                                            containerVistaOrderLevelExtendedRow
                                                                ?.unit
                                                                ?.toString(),
                                                            '0',
                                                          ),
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFFD9D9D9),
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        validator: _model
                                                            .unitTTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                if (!valueOrDefault<bool>(
                                                  _model.checkboxValue,
                                                  true,
                                                ))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    child: Container(
                                                      width: 280.0,
                                                      height: 50.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFD9D9D9),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            containerVistaOrderLevelExtendedRow
                                                                ?.unit
                                                                ?.toString(),
                                                            '0',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 160.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '3lpe3obr' /* Weight:   */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                              child: Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .weightTTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.weight
                                                          ?.toString(),
                                                      '-1',
                                                    ),
                                                  ),
                                                  focusNode:
                                                      _model.weightTFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.weight
                                                          ?.toString(),
                                                      '-1',
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
                                                            Color(0xFFD9D9D9),
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  validator: _model
                                                      .weightTTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _model.formKey1,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'swxjzyjy' /* Other manipulations:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FutureBuilder<
                                                      List<ManipulationsRow>>(
                                                    future: ManipulationsTable()
                                                        .queryRows(
                                                      queryFn: (q) => q,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<ManipulationsRow>
                                                          otherManipulationDDManipulationsRowList =
                                                          snapshot.data!;

                                                      return FlutterFlowDropDown<
                                                          String>(
                                                        controller: _model
                                                                .otherManipulationDDValueController ??=
                                                            FormFieldController<
                                                                String>(null),
                                                        options:
                                                            otherManipulationDDManipulationsRowList
                                                                .map((e) =>
                                                                    valueOrDefault<
                                                                        String>(
                                                                      e.manipulation,
                                                                      '/',
                                                                    ))
                                                                .toList(),
                                                        onChanged: (val) =>
                                                            safeSetState(() =>
                                                                _model.otherManipulationDDValue =
                                                                    val),
                                                        width: 280.0,
                                                        height: 50.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText:
                                                            valueOrDefault<
                                                                String>(
                                                          containerVistaOrderLevelExtendedRow
                                                              ?.otherManipulation,
                                                          'brez izbire',
                                                        ),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 2.0,
                                                        borderColor:
                                                            Color(0xFFD9D2E9),
                                                        borderWidth: 2.0,
                                                        borderRadius: 8.0,
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                        hidesUnderline: true,
                                                        isSearchable: false,
                                                        isMultiSelect: false,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'k3bvaxvd' /* Type of un/upload:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .loadTypeDDValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: [
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'c1g1mv1p' /* viličar */,
                                                      ),
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'xt5iyzud' /* ročno */,
                                                      )
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .loadTypeDDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.loadingType,
                                                      'brez izbire',
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '4ys80k7p' /* Type of un/upload 2:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .loadType2DDValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: [
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'dfdjkscf' /* viličar */,
                                                      ),
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'gaxkwc6b' /* ročno */,
                                                      )
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .loadType2DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.loadingType2,
                                                      'brez izbire',
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'nnew7c7t' /* Responsible:  */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .responsibleDDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.responsibleDDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .responsibleDDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.responsibleName} ${containerVistaOrderLevelExtendedRow?.responsibleLastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '5j26f3oh' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'rxkrrxst' /* Assistant 1:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant1DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant1DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant1DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant1Name} ${containerVistaOrderLevelExtendedRow?.assistant1LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'w00it0yk' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'odfaa90q' /* Assistant 2:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant2DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant2DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant2DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant2Name} ${containerVistaOrderLevelExtendedRow?.assistant2LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '86gnzb1r' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '42o4cwkv' /* Assistant 3:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant3DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant3DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant3DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant3Name} ${containerVistaOrderLevelExtendedRow?.assistant3LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'y9wemh7m' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        AutoSizeText(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'uxlc78ll' /* Assistant 4:   */,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          minFontSize: 6.0,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant4DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant4DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant4DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant4Name} ${containerVistaOrderLevelExtendedRow?.assistant4LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'cyhz6mld' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        AutoSizeText(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'dh2jv6vo' /* Assistant 5:   */,
                                                          ),
                                                          minFontSize: 6.0,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant5DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant5DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant5DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant5Name} ${containerVistaOrderLevelExtendedRow?.assistant5LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '2rezj3dd' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 160.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        AutoSizeText(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'iigw54yp' /* Assistant 6:   */,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          minFontSize: 6.0,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FlutterFlowDropDown<String>(
                                                    controller: _model
                                                            .assistant6DDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.assistant6DDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        formsUsersRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        formsUsersRowList
                                                            .map((e) =>
                                                                e.lastName)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .assistant6DDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        '${containerVistaOrderLevelExtendedRow?.assistant6Name} ${containerVistaOrderLevelExtendedRow?.assistant6LastName}',
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'gvqo5j88' /* Search for an item... */,
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
                                                        Color(0xFFD9D2E9),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: _model.formKey4,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 250.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '27brn9o8' /* Universal ref num:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                        .universalRefNumTTextController ??=
                                                    TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.universalRefNo,
                                                    '/',
                                                  ),
                                                ),
                                                focusNode: _model
                                                    .universalRefNumTFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.universalRefNo,
                                                    '/',
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
                                                      color: Color(0xFFFCE5CD),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .universalRefNumTTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 250.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'w2vc2fpp' /* FMS ref:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                        .fmsRefTTextController ??=
                                                    TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.fmsRef,
                                                    '/',
                                                  ),
                                                ),
                                                focusNode:
                                                    _model.fmsRefTFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.fmsRef,
                                                    '/',
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
                                                      color: Color(0xFFFCE5CD),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .fmsRefTTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 250.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'qx5ac8t1' /* Load ref/dvh:   */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: TextFormField(
                                                controller: _model
                                                        .loadRefDvhTTextController ??=
                                                    TextEditingController(
                                                  text: valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.loadRefDvh,
                                                    '/',
                                                  ),
                                                ),
                                                focusNode:
                                                    _model.loadRefDvhTFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      valueOrDefault<String>(
                                                    containerVistaOrderLevelExtendedRow
                                                        ?.loadRefDvh,
                                                    '/',
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
                                                      color: Color(0xFFFCE5CD),
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                            12.0),
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
                                                    .loadRefDvhTTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 24.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 250.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'xcuhjh74' /* Good:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
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
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<GoodsRow>
                                                      goodsDDGoodsRowList =
                                                      snapshot.data!;

                                                  return FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .goodsDDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.goodsDDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        goodsDDGoodsRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        goodsDDGoodsRowList
                                                            .map((e) => e.item)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() =>
                                                            _model.goodsDDValue =
                                                                val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.item,
                                                      'brez izbire',
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'nstuvhay' /* Search for an item... */,
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
                                                        Color(0xFFFCE5CD),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 24.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 250.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '6f042ri4' /* Item description: */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 280.0,
                                                height: 50.0,
                                                child: custom_widgets
                                                    .GoodDescriptionTFDD(
                                                  width: 280.0,
                                                  height: 50.0,
                                                  goodDescriptionList:
                                                      FFAppState()
                                                          .goodDescriptionList,
                                                  action: () async {
                                                    FFAppState()
                                                            .goodDescriptionApiB =
                                                        true;
                                                    safeSetState(() {});
                                                    await action_blocks
                                                        .goodDescriptionApiAction(
                                                            context);
                                                    safeSetState(() {});
                                                  },
                                                  resetAction: () async {
                                                    FFAppState()
                                                            .goodDescriptionApiB =
                                                        false;
                                                    safeSetState(() {});
                                                    FFAppState()
                                                        .goodDescriptionApiV = '';
                                                    FFAppState()
                                                        .goodDescriptionApiId = '';
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 24.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 250.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '18qvpp0q' /* Packaging:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FutureBuilder<List<PackagingRow>>(
                                                future: FFAppState().packagings(
                                                  uniqueQueryKey:
                                                      widget.formsKey,
                                                  requestFn: () =>
                                                      PackagingTable()
                                                          .queryRows(
                                                    queryFn: (q) => q,
                                                  ),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<PackagingRow>
                                                      packagingDDPackagingRowList =
                                                      snapshot.data!;

                                                  return FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .packagingDDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.packagingDDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        packagingDDPackagingRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        packagingDDPackagingRowList
                                                            .map((e) =>
                                                                e.packaging)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .packagingDDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 50.0,
                                                    searchHintTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    searchTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        valueOrDefault<String>(
                                                      containerVistaOrderLevelExtendedRow
                                                          ?.packagingName,
                                                      'brez izbire',
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '2gywf2o3' /* Search for an item... */,
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
                                                        Color(0xFFFCE5CD),
                                                    borderWidth: 2.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                8.0, 0.0),
                                                    hidesUnderline: true,
                                                    isSearchable: true,
                                                    isMultiSelect: false,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'spunb0qj' /* Barcodes:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  if (valueOrDefault<bool>(
                                                    _model.checkboxValue,
                                                    true,
                                                  ))
                                                    Container(
                                                      width: 280.0,
                                                      height: 200.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Container(
                                                        width: 280.0,
                                                        child: TextFormField(
                                                          controller: _model
                                                                  .barcodesTFTextController ??=
                                                              TextEditingController(
                                                            text: functions.joinStrings(
                                                                containerVistaOrderLevelExtendedRow!
                                                                    .barcodeList
                                                                    .toList()),
                                                          ),
                                                          focusNode: _model
                                                              .barcodesTFFocusNode,
                                                          autofocus: false,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                              'x1apz81p' /* Insert new value... */,
                                                            ),
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFFCE5CD),
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                          maxLines: 50,
                                                          validator: _model
                                                              .barcodesTFTextControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        ),
                                                      ),
                                                    ),
                                                  if (!valueOrDefault<bool>(
                                                    _model.checkboxValue,
                                                    false,
                                                  ))
                                                    Container(
                                                      width: 280.0,
                                                      height: 200.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFFCE5CD),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    11.0,
                                                                    12.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          functions.joinStrings(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .barcodeList
                                                                  .toList()),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                                child: Checkbox(
                                                  value: _model
                                                      .checkboxValue ??= false,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() =>
                                                        _model.checkboxValue =
                                                            newValue!);
                                                  },
                                                  side: (FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  checkColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 32.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 160.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'm7gpyzpy' /* Repeated barcodes:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    if (valueOrDefault<bool>(
                                                      _model.checkboxValue,
                                                      true,
                                                    ))
                                                      Container(
                                                        width: 280.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Container(
                                                          width: 280.0,
                                                          child: TextFormField(
                                                            controller: _model
                                                                    .repeatedBarcodesTFTextController ??=
                                                                TextEditingController(
                                                              text: functions.joinStrings(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .repeatedBarcodes
                                                                      .toList()),
                                                            ),
                                                            focusNode: _model
                                                                .repeatedBarcodesTFFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                's7iw07q6' /* Insert new value... */,
                                                              ),
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFCE5CD),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            maxLines: 50,
                                                            validator: _model
                                                                .repeatedBarcodesTFTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    if (!valueOrDefault<bool>(
                                                      _model.checkboxValue,
                                                      false,
                                                    ))
                                                      Container(
                                                        width: 280.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFFCE5CD),
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      11.0,
                                                                      12.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: SelectionArea(
                                                              child: Text(
                                                            functions.joinStrings(
                                                                containerVistaOrderLevelExtendedRow!
                                                                    .repeatedBarcodes
                                                                    .toList()),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          )),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 32.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 160.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'u3jax3cb' /* Non-existent barcodes:   */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    if (_model.checkboxValue ??
                                                        true)
                                                      Container(
                                                        width: 280.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Container(
                                                          width: 280.0,
                                                          child: TextFormField(
                                                            controller: _model
                                                                    .nonExistentBarcodesTFTextController ??=
                                                                TextEditingController(
                                                              text: functions.joinStrings(
                                                                  containerVistaOrderLevelExtendedRow!
                                                                      .noBarcodes
                                                                      .toList()),
                                                            ),
                                                            focusNode: _model
                                                                .nonExistentBarcodesTFFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'wh7caubp' /* Insert new value... */,
                                                              ),
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFCE5CD),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            maxLines: 50,
                                                            validator: _model
                                                                .nonExistentBarcodesTFTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    if (!valueOrDefault<bool>(
                                                      _model.checkboxValue,
                                                      false,
                                                    ))
                                                      Container(
                                                        width: 280.0,
                                                        height: 80.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFFCE5CD),
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      11.0,
                                                                      12.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: SelectionArea(
                                                              child: Text(
                                                            functions.joinStrings(
                                                                containerVistaOrderLevelExtendedRow!
                                                                    .noBarcodes
                                                                    .toList()),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          )),
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
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Form(
                                  key: _model.formKey5,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'hynfks1q' /* Taric code:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .taricCodeTFTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.taricCode,
                                                  ),
                                                  focusNode: _model
                                                      .taricCodeTFFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'gqg8cd2q' /* Insert new value... */,
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
                                                                .tertiary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  validator: _model
                                                      .taricCodeTFTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'cpgkypfq' /* Customs %:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .customsPercentageTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        valueOrDefault<String>(
                                                      (100 *
                                                              valueOrDefault<
                                                                  double>(
                                                                containerVistaOrderLevelExtendedRow
                                                                    ?.customsPercentage,
                                                                0.0,
                                                              ))
                                                          .toString(),
                                                      '0',
                                                    ),
                                                  ),
                                                  focusNode: _model
                                                      .customsPercentageFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '7wp40f2e' /* Value between 0 and 100 */,
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
                                                                .tertiary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  validator: _model
                                                      .customsPercentageTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'aykejmha' /* Cost:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 280.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .costTFTextController ??=
                                                      TextEditingController(
                                                    text:
                                                        containerVistaOrderLevelExtendedRow
                                                            ?.initCost
                                                            ?.toString(),
                                                  ),
                                                  focusNode:
                                                      _model.costTFFocusNode,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'y1s1edcn' /* Insert new value... */,
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
                                                                .tertiary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  validator: _model
                                                      .costTFTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '8su4w4ph' /* Currency:  */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FlutterFlowChoiceChips(
                                                options: [
                                                  ChipData(FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'vqtq9jnm' /* Dolar */,
                                                  )),
                                                  ChipData(FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '4k3rj4dp' /* Euro */,
                                                  ))
                                                ],
                                                onChanged: (val) =>
                                                    safeSetState(() => _model
                                                            .choiceChipsValue =
                                                        val?.firstOrNull),
                                                selectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .info,
                                                  iconSize: 16.0,
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                unselectedChipStyle: ChipStyle(
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .accent4,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  iconSize: 16.0,
                                                  elevation: 0.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                chipSpacing: 8.0,
                                                rowSpacing: 8.0,
                                                multiselect: false,
                                                initialized:
                                                    _model.choiceChipsValue !=
                                                        null,
                                                alignment: WrapAlignment.start,
                                                controller: _model
                                                        .choiceChipsValueController ??=
                                                    FormFieldController<
                                                        List<String>>(
                                                  [
                                                    containerVistaOrderLevelExtendedRow!
                                                        .euroOrDolar!
                                                  ],
                                                ),
                                                wrapped: true,
                                              ),
                                            ].divide(SizedBox(width: 16.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 160.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'z4rr18as' /* Exchange rate:   */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100.0,
                                                child: TextFormField(
                                                  controller: _model
                                                          .exchangeRateTFTextController ??=
                                                      TextEditingController(
                                                    text: containerVistaOrderLevelExtendedRow
                                                                ?.exchangeRateUsed ==
                                                            0.0
                                                        ? valueOrDefault<
                                                            String>(
                                                            FFAppState()
                                                                .todayExchangeType
                                                                .toString(),
                                                            '0.0',
                                                          )
                                                        : containerVistaOrderLevelExtendedRow
                                                            ?.exchangeRateUsed
                                                            ?.toString(),
                                                  ),
                                                  focusNode: _model
                                                      .exchangeRateTFFocusNode,
                                                  autofocus: false,
                                                  readOnly: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
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
                                                                .tertiary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
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
                                                              12.0),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  validator: _model
                                                      .exchangeRateTFTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 28.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Builder(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                _model.unitLast = _model.unitTTextController.text != ''
                                    ? int.parse(_model.unitTTextController.text)
                                    : containerVistaOrderLevelExtendedRow!
                                        .unit!;
                                _model.numberOfBarcodes = functions
                                    .splitBarcodes(
                                        _model.barcodesTFTextController.text)
                                    .length;
                                safeSetState(() {});
                                if (_model.unitLast >=
                                    _model.numberOfBarcodes) {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: SureQueryWidget(
                                          saveChangesP: () async {
                                            if (_model.checkboxValue!) {
                                              await OrderLevelTable().update(
                                                data: {
                                                  'inv_status': _model.inventoryStatusDDValue !=
                                                              null &&
                                                          _model.inventoryStatusDDValue !=
                                                              ''
                                                      ? _model
                                                          .inventoryStatusDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.invStatus,
                                                  'order_no': _model.orderNoTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .orderNoTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.orderNo,
                                                  'flow': _model.flowDDValue !=
                                                              null &&
                                                          _model.flowDDValue !=
                                                              ''
                                                      ? _model.flowDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.flow,
                                                  'order_status': _model
                                                                  .orderStatusDDValue !=
                                                              null &&
                                                          _model.orderStatusDDValue !=
                                                              ''
                                                      ? _model
                                                          .orderStatusDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.orderStatus,
                                                  'admin': _model.adminDDValue !=
                                                              null &&
                                                          _model.adminDDValue !=
                                                              ''
                                                      ? _model.adminDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.admin,
                                                  'warehouse': _model
                                                                  .warehouseDDValue !=
                                                              null &&
                                                          _model.warehouseDDValue !=
                                                              ''
                                                      ? _model.warehouseDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.warehouse,
                                                  'eta_date': supaSerialize<
                                                      DateTime>(_model
                                                              .datePicked1 !=
                                                          null
                                                      ? _model.datePicked1
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaDate2!)),
                                                  'eta_i': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .announcedTime1T !=
                                                          null
                                                      ? _model.announcedTime1T
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaI2!))),
                                                  'eta_f': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .announcedTime2T !=
                                                          null
                                                      ? _model.announcedTime2T
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaF2!))),
                                                  'arrival': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .arrivalT !=
                                                          null
                                                      ? _model.arrivalT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .arrival2!))),
                                                  'loading_gate': _model
                                                                  .loadingGateDDValue !=
                                                              null &&
                                                          _model.loadingGateDDValue !=
                                                              ''
                                                      ? _model
                                                          .loadingGateDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingGate,
                                                  'loading_sequence': _model.sequenceTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .sequenceTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingSequence,
                                                  'start': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .startT !=
                                                          null
                                                      ? _model.startT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .start2!))),
                                                  'stop': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .stopT !=
                                                          null
                                                      ? _model.stopT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .stop2!))),
                                                  'licence_plate': _model.licencePlateTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .licencePlateTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.licencePlate,
                                                  'quantity': _model.quantityTTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .quantityTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.quantity,
                                                  'unit': _model.unitTTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .unitTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.unit,
                                                  'weight': _model.weightTTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .weightTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.weight,
                                                  'container_no': _model.containerTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .containerTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.containerNo,
                                                  'custom': _model.customDDValue !=
                                                              null &&
                                                          _model.customDDValue !=
                                                              ''
                                                      ? _model.customDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.custom,
                                                  'responsible': _model
                                                                  .responsibleDDValue !=
                                                              null &&
                                                          _model.responsibleDDValue !=
                                                              ''
                                                      ? _model
                                                          .responsibleDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.responsible,
                                                  'assistant1': _model
                                                                  .assistant1DDValue !=
                                                              null &&
                                                          _model.assistant1DDValue !=
                                                              ''
                                                      ? _model.assistant1DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant1,
                                                  'assistant2': _model
                                                                  .assistant2DDValue !=
                                                              null &&
                                                          _model.assistant2DDValue !=
                                                              ''
                                                      ? _model.assistant2DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant2,
                                                  'assistant3': _model
                                                                  .assistant3DDValue !=
                                                              null &&
                                                          _model.assistant3DDValue !=
                                                              ''
                                                      ? _model.assistant3DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant3,
                                                  'assistant4': _model
                                                                  .assistant4DDValue !=
                                                              null &&
                                                          _model.assistant4DDValue !=
                                                              ''
                                                      ? _model.assistant4DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant4,
                                                  'assistant5': _model
                                                                  .assistant5DDValue !=
                                                              null &&
                                                          _model.assistant5DDValue !=
                                                              ''
                                                      ? _model.assistant5DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant5,
                                                  'assistant6': _model
                                                                  .assistant6DDValue !=
                                                              null &&
                                                          _model.assistant6DDValue !=
                                                              ''
                                                      ? _model.assistant6DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant6,
                                                  'fms_ref': _model.fmsRefTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .fmsRefTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.fmsRef,
                                                  'load_ref_dvh': _model.loadRefDvhTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .loadRefDvhTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadRefDvh,
                                                  'universal_ref_no': _model.universalRefNumTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .universalRefNumTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.universalRefNo,
                                                  'comment': _model.commentTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .commentTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.comment,
                                                  'loading_type': _model
                                                                  .loadTypeDDValue !=
                                                              null &&
                                                          _model.loadTypeDDValue !=
                                                              ''
                                                      ? _model.loadTypeDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingType,
                                                  'loading_type2': _model
                                                                  .loadType2DDValue !=
                                                              null &&
                                                          _model.loadType2DDValue !=
                                                              ''
                                                      ? _model.loadType2DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingType2,
                                                  'internal_accounting': _model.internalAccTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .internalAccTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.internalAccounting,
                                                  'internal_ref_custom': _model.internalRefTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .internalRefTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.internalRefCustom,
                                                  'client': FFAppState()
                                                          .clientApiB
                                                      ? FFAppState().clientApiId
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.client,
                                                  'improvement': _model
                                                                  .improvementDDValue !=
                                                              null &&
                                                          _model.improvementDDValue !=
                                                              ''
                                                      ? _model
                                                          .improvementDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.improvement,
                                                  'other_manipulation': _model
                                                                  .otherManipulationDDValue !=
                                                              null &&
                                                          _model.otherManipulationDDValue !=
                                                              ''
                                                      ? _model
                                                          .otherManipulationDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.otherManipulation,
                                                  'good': _model.goodsDDValue !=
                                                              null &&
                                                          _model.goodsDDValue !=
                                                              ''
                                                      ? _model.goodsDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.good,
                                                  'good_description': FFAppState()
                                                          .goodDescriptionApiB
                                                      ? FFAppState()
                                                          .goodDescriptionApiId
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.goodDescription,
                                                  'packaging': _model
                                                                  .packagingDDValue !=
                                                              null &&
                                                          _model.packagingDDValue !=
                                                              ''
                                                      ? _model.packagingDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.packaging,
                                                  'checked': _model
                                                              .checkCBValue !=
                                                          null
                                                      ? _model.checkCBValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.checked,
                                                  'precheck': _model
                                                              .preCheckCBValue !=
                                                          null
                                                      ? _model.preCheckCBValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.precheck,
                                                  'received_barcodes': functions
                                                      .splitBarcodes(_model
                                                          .barcodesTFTextController
                                                          .text),
                                                  'barcodes':
                                                      FFAppState().emptyList,
                                                  'no_barcodes':
                                                      FFAppState().emptyList,
                                                  'repeated_barcodes':
                                                      FFAppState().emptyList,
                                                  'pallet_position': _model.palletPositionTTextController
                                                                  .text !=
                                                              ''
                                                      ? double.tryParse(_model
                                                          .palletPositionTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.palletPosition,
                                                  'created_at': supaSerialize<
                                                      DateTime>(_model
                                                              .datePicked2 !=
                                                          null
                                                      ? _model.datePicked2
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .createdAt2!)),
                                                  'taric_code': _model.taricCodeTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .taricCodeTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.taricCode,
                                                  'customs_percentage': _model.customsPercentageTextController
                                                                  .text !=
                                                              ''
                                                      ? (double.parse(_model
                                                              .customsPercentageTextController
                                                              .text) /
                                                          100)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.customsPercentage,
                                                  'init_cost': _model.costTFTextController
                                                                  .text !=
                                                              ''
                                                      ? double.tryParse(_model
                                                          .costTFTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.initCost,
                                                  'euro_or_dolar': _model
                                                                  .choiceChipsValue !=
                                                              null &&
                                                          _model.choiceChipsValue !=
                                                              ''
                                                      ? _model.choiceChipsValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.euroOrDolar,
                                                  'exchange_rate_used': /* NOT RECOMMENDED */ _model
                                                              .exchangeRateTFTextController
                                                              .text ==
                                                          'true'
                                                      ? double.tryParse(_model
                                                          .exchangeRateTFTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.exchangeRateUsed,
                                                },
                                                matchingRows: (rows) =>
                                                    rows.eqOrNull(
                                                  'id',
                                                  widget.orderId,
                                                ),
                                              );
                                            } else {
                                              await OrderLevelTable().update(
                                                data: {
                                                  'inv_status': _model.inventoryStatusDDValue !=
                                                              null &&
                                                          _model.inventoryStatusDDValue !=
                                                              ''
                                                      ? _model
                                                          .inventoryStatusDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.invStatus,
                                                  'order_no': _model.orderNoTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .orderNoTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.orderNo,
                                                  'flow': _model.flowDDValue !=
                                                              null &&
                                                          _model.flowDDValue !=
                                                              ''
                                                      ? _model.flowDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.flow,
                                                  'order_status': _model
                                                                  .orderStatusDDValue !=
                                                              null &&
                                                          _model.orderStatusDDValue !=
                                                              ''
                                                      ? _model
                                                          .orderStatusDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.orderStatus,
                                                  'admin': _model.adminDDValue !=
                                                              null &&
                                                          _model.adminDDValue !=
                                                              ''
                                                      ? _model.adminDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.admin,
                                                  'warehouse': _model
                                                                  .warehouseDDValue !=
                                                              null &&
                                                          _model.warehouseDDValue !=
                                                              ''
                                                      ? _model.warehouseDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.warehouse,
                                                  'eta_date': supaSerialize<
                                                      DateTime>(_model
                                                              .datePicked1 !=
                                                          null
                                                      ? _model.datePicked1
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaDate2!)),
                                                  'eta_i': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .announcedTime1T !=
                                                          null
                                                      ? _model.announcedTime1T
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaI2!))),
                                                  'eta_f': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .announcedTime2T !=
                                                          null
                                                      ? _model.announcedTime2T
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .etaF2!))),
                                                  'arrival': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .arrivalT !=
                                                          null
                                                      ? _model.arrivalT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .arrival2!))),
                                                  'loading_gate': _model
                                                                  .loadingGateDDValue !=
                                                              null &&
                                                          _model.loadingGateDDValue !=
                                                              ''
                                                      ? _model
                                                          .loadingGateDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingGate,
                                                  'loading_sequence': _model.sequenceTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .sequenceTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingSequence,
                                                  'start': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .startT !=
                                                          null
                                                      ? _model.startT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .start2!))),
                                                  'stop': supaSerialize<
                                                      PostgresTime>(PostgresTime(_model
                                                              .stopT !=
                                                          null
                                                      ? _model.stopT
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .stop2!))),
                                                  'licence_plate': _model.licencePlateTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .licencePlateTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.licencePlate,
                                                  'quantity': _model.quantityTTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .quantityTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.quantity,
                                                  'pallet_position': _model.palletPositionTTextController
                                                                  .text !=
                                                              ''
                                                      ? double.tryParse(_model
                                                          .palletPositionTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.palletPosition,
                                                  'weight': _model.weightTTextController
                                                                  .text !=
                                                              ''
                                                      ? int.tryParse(_model
                                                          .weightTTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.weight,
                                                  'container_no': _model.containerTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .containerTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.containerNo,
                                                  'custom': _model.customDDValue !=
                                                              null &&
                                                          _model.customDDValue !=
                                                              ''
                                                      ? _model.customDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.custom,
                                                  'responsible': _model
                                                                  .responsibleDDValue !=
                                                              null &&
                                                          _model.responsibleDDValue !=
                                                              ''
                                                      ? _model
                                                          .responsibleDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.responsible,
                                                  'assistant1': _model
                                                                  .assistant1DDValue !=
                                                              null &&
                                                          _model.assistant1DDValue !=
                                                              ''
                                                      ? _model.assistant1DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant1,
                                                  'assistant2': _model
                                                                  .assistant2DDValue !=
                                                              null &&
                                                          _model.assistant2DDValue !=
                                                              ''
                                                      ? _model.assistant2DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant2,
                                                  'assistant3': _model
                                                                  .assistant3DDValue !=
                                                              null &&
                                                          _model.assistant3DDValue !=
                                                              ''
                                                      ? _model.assistant3DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant3,
                                                  'assistant4': _model
                                                                  .assistant4DDValue !=
                                                              null &&
                                                          _model.assistant4DDValue !=
                                                              ''
                                                      ? _model.assistant4DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant4,
                                                  'assistant5': _model
                                                                  .assistant5DDValue !=
                                                              null &&
                                                          _model.assistant5DDValue !=
                                                              ''
                                                      ? _model.assistant5DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant5,
                                                  'assistant6': _model
                                                                  .assistant6DDValue !=
                                                              null &&
                                                          _model.assistant6DDValue !=
                                                              ''
                                                      ? _model.assistant6DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.assistant6,
                                                  'fms_ref': _model.fmsRefTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .fmsRefTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.fmsRef,
                                                  'load_ref_dvh': _model.loadRefDvhTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .loadRefDvhTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadRefDvh,
                                                  'universal_ref_no': _model.universalRefNumTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .universalRefNumTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.universalRefNo,
                                                  'comment': _model.commentTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .commentTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.comment,
                                                  'loading_type': _model
                                                                  .loadTypeDDValue !=
                                                              null &&
                                                          _model.loadTypeDDValue !=
                                                              ''
                                                      ? _model.loadTypeDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingType,
                                                  'loading_type2': _model
                                                                  .loadType2DDValue !=
                                                              null &&
                                                          _model.loadType2DDValue !=
                                                              ''
                                                      ? _model.loadType2DDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.loadingType2,
                                                  'internal_accounting': _model.internalAccTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .internalAccTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.internalAccounting,
                                                  'internal_ref_custom': _model.internalRefTTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .internalRefTTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.internalRefCustom,
                                                  'client': FFAppState()
                                                          .clientApiB
                                                      ? FFAppState().clientApiId
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.client,
                                                  'improvement': _model
                                                                  .improvementDDValue !=
                                                              null &&
                                                          _model.improvementDDValue !=
                                                              ''
                                                      ? _model
                                                          .improvementDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.improvement,
                                                  'other_manipulation': _model
                                                                  .otherManipulationDDValue !=
                                                              null &&
                                                          _model.otherManipulationDDValue !=
                                                              ''
                                                      ? _model
                                                          .otherManipulationDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.otherManipulation,
                                                  'good': _model.goodsDDValue !=
                                                              null &&
                                                          _model.goodsDDValue !=
                                                              ''
                                                      ? _model.goodsDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.good,
                                                  'good_description': FFAppState()
                                                          .goodDescriptionApiB
                                                      ? FFAppState()
                                                          .goodDescriptionApiId
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.goodDescription,
                                                  'packaging': _model
                                                                  .packagingDDValue !=
                                                              null &&
                                                          _model.packagingDDValue !=
                                                              ''
                                                      ? _model.packagingDDValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.packaging,
                                                  'checked': _model
                                                              .checkCBValue !=
                                                          null
                                                      ? _model.checkCBValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.checked,
                                                  'precheck': _model
                                                              .preCheckCBValue !=
                                                          null
                                                      ? _model.preCheckCBValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.precheck,
                                                  'barcodes':
                                                      FFAppState().emptyList,
                                                  'no_barcodes':
                                                      FFAppState().emptyList,
                                                  'repeated_barcodes':
                                                      FFAppState().emptyList,
                                                  'created_at': supaSerialize<
                                                      DateTime>(_model
                                                              .datePicked2 !=
                                                          null
                                                      ? _model.datePicked2
                                                      : functions
                                                          .parsePostgresTimestamp(
                                                              containerVistaOrderLevelExtendedRow!
                                                                  .createdAt2!)),
                                                  'taric_code': _model.taricCodeTFTextController
                                                                  .text !=
                                                              ''
                                                      ? _model
                                                          .taricCodeTFTextController
                                                          .text
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.taricCode,
                                                  'customs_percentage': _model.customsPercentageTextController
                                                                  .text !=
                                                              ''
                                                      ? (double.parse(_model
                                                              .customsPercentageTextController
                                                              .text) /
                                                          100)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.customsPercentage,
                                                  'init_cost': _model.costTFTextController
                                                                  .text !=
                                                              ''
                                                      ? double.tryParse(_model
                                                          .costTFTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.initCost,
                                                  'euro_or_dolar': _model
                                                                  .choiceChipsValue !=
                                                              null &&
                                                          _model.choiceChipsValue !=
                                                              ''
                                                      ? _model.choiceChipsValue
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.euroOrDolar,
                                                  'exchange_rate_used': /* NOT RECOMMENDED */ _model
                                                              .exchangeRateTFTextController
                                                              .text ==
                                                          'true'
                                                      ? double.tryParse(_model
                                                          .exchangeRateTFTextController
                                                          .text)
                                                      : containerVistaOrderLevelExtendedRow
                                                          ?.exchangeRateUsed,
                                                },
                                                matchingRows: (rows) =>
                                                    rows.eqOrNull(
                                                  'id',
                                                  widget.orderId,
                                                ),
                                              );
                                            }

                                            _model.refreshRowOP = await TablesGroup
                                                .refreshOrderLevelCalculatedColumnsCall
                                                .call(
                                              rowId: widget.orderId,
                                              userToken: currentJwtToken,
                                            );

                                            if ((_model
                                                    .refreshRowOP?.succeeded ??
                                                true)) {
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Refresh row error.',
                                                    style: TextStyle(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 12.0,
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
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(
                                      () => _model.sureQueryOP = value));

                                  if (_model.sureQueryOP!) {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'The value of unit is less than the number of barcodes.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                }

                                safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'kgb68azj' /* Save changes */,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
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
                                borderRadius: BorderRadius.circular(8.0),
                              ),
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
        );
      },
    );
  }
}
