import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import 'package:flutter/material.dart';
import 'edit_details_model.dart';
export 'edit_details_model.dart';

class EditDetailsWidget extends StatefulWidget {
  const EditDetailsWidget({
    super.key,
    required this.idDetailsP,
    required this.warehouseId,
    this.editDetailsKey,
    required this.refreshQueries,
    required this.flow,
  });

  final String? idDetailsP;
  final String? warehouseId;
  final String? editDetailsKey;
  final Future Function()? refreshQueries;
  final String? flow;

  @override
  State<EditDetailsWidget> createState() => _EditDetailsWidgetState();
}

class _EditDetailsWidgetState extends State<EditDetailsWidget> {
  late EditDetailsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditDetailsModel());

    _model.barcodeTFFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: FutureBuilder<List<DetailsViewRow>>(
        future: FFAppState().detailsView(
          uniqueQueryKey: valueOrDefault<String>(
            widget.editDetailsKey,
            'editDetailsDefKey',
          ),
          requestFn: () => DetailsViewTable().querySingleRow(
            queryFn: (q) => q.eqOrNull(
              'id',
              widget.idDetailsP,
            ),
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
          List<DetailsViewRow> detailsViewContainerDetailsViewRowList =
              snapshot.data!;

          final detailsViewContainerDetailsViewRow =
              detailsViewContainerDetailsViewRowList.isNotEmpty
                  ? detailsViewContainerDetailsViewRowList.first
                  : null;

          return Container(
            width: 800.0,
            height: 800.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(28.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 4.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(28.0, 0.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'j79j5yyd' /* Edit record */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'eby9i6es' /* Good:   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              detailsViewContainerDetailsViewRow
                                                  ?.item,
                                              'brez izbire',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child:
                                                  FutureBuilder<List<GoodsRow>>(
                                                future: FFAppState().goods(
                                                  uniqueQueryKey:
                                                      valueOrDefault<String>(
                                                    widget.editDetailsKey,
                                                    'editDetailsDefKey',
                                                  ),
                                                  requestFn: () =>
                                                      GoodsTable().queryRows(
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
                                                  List<GoodsRow>
                                                      goodDDGoodsRowList =
                                                      snapshot.data!;

                                                  return FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .goodDDValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: List<String>.from(
                                                        goodDDGoodsRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        goodDDGoodsRowList
                                                            .map((e) => e.item)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() =>
                                                            _model.goodDDValue =
                                                                val),
                                                    width: 280.0,
                                                    height: 40.0,
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
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'zwxjnc97' /* Please select... */,
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '7piqz5sc' /* Search for an item... */,
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
                                                            .primary,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'qfqrlwsg' /* Description:   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              detailsViewContainerDetailsViewRow
                                                  ?.opisBlaga,
                                              'brez izbire',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: FutureBuilder<
                                                  List<GoodDescriptionsRow>>(
                                                future: FFAppState()
                                                    .goodDescription(
                                                  uniqueQueryKey:
                                                      valueOrDefault<String>(
                                                    widget.editDetailsKey,
                                                    'editDetailsDefKey',
                                                  ),
                                                  requestFn: () =>
                                                      GoodDescriptionsTable()
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
                                                  List<GoodDescriptionsRow>
                                                      descriptionDDGoodDescriptionsRowList =
                                                      snapshot.data!;

                                                  return FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .descriptionDDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.descriptionDDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        descriptionDDGoodDescriptionsRowList
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        descriptionDDGoodDescriptionsRowList
                                                            .map((e) =>
                                                                e.opisBlaga)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .descriptionDDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 40.0,
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
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      '67o19ah6' /* Please select... */,
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'uloafuuz' /* Search for an item... */,
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
                                                            .primary,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'q3fbzpds' /* Packaging:   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              detailsViewContainerDetailsViewRow
                                                  ?.packagingDescription,
                                              'brez izbire',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: FutureBuilder<
                                                  List<PackagingRow>>(
                                                future: FFAppState().packagings(
                                                  uniqueQueryKey:
                                                      valueOrDefault<String>(
                                                    widget.editDetailsKey,
                                                    'editDetailsDefKey',
                                                  ),
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
                                                    height: 40.0,
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
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'dp689g4e' /* Please select... */,
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'slwgvnbp' /* Search for an item... */,
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
                                                            .primary,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '2pmsi25l' /* Warehouse position:   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              detailsViewContainerDetailsViewRow
                                                  ?.warehousePositionName,
                                              'brez izbire',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: FutureBuilder<
                                                  List<WarehousePositionsRow>>(
                                                future: FFAppState()
                                                    .warehousePositions(
                                                  uniqueQueryKey:
                                                      valueOrDefault<String>(
                                                    widget.editDetailsKey,
                                                    'editDetailsDefKey',
                                                  ),
                                                  requestFn: () =>
                                                      WarehousePositionsTable()
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
                                                  List<WarehousePositionsRow>
                                                      warehpusePositionDDWarehousePositionsRowList =
                                                      snapshot.data!;

                                                  return FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .warehpusePositionDDValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.warehpusePositionDDValue ??=
                                                          '',
                                                    ),
                                                    options: List<String>.from(
                                                        warehpusePositionDDWarehousePositionsRowList
                                                            .where((e) =>
                                                                e.warehouse ==
                                                                widget
                                                                    .warehouseId)
                                                            .toList()
                                                            .map((e) => e.id)
                                                            .toList()),
                                                    optionLabels:
                                                        warehpusePositionDDWarehousePositionsRowList
                                                            .where((e) =>
                                                                e.warehouse ==
                                                                widget
                                                                    .warehouseId)
                                                            .toList()
                                                            .map((e) =>
                                                                e.position)
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .warehpusePositionDDValue =
                                                            val),
                                                    width: 280.0,
                                                    height: 40.0,
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
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'qpecaokf' /* Please select... */,
                                                    ),
                                                    searchHintText:
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                      'b01g0obk' /* Search for an item... */,
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
                                                            .primary,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'ebn4opmu' /* Barcode:   */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            () {
                                              if (widget.flow == 'in') {
                                                return valueOrDefault<String>(
                                                  detailsViewContainerDetailsViewRow
                                                      ?.barcode,
                                                  '/',
                                                );
                                              } else if (widget.flow ==
                                                  'out') {
                                                return valueOrDefault<String>(
                                                  detailsViewContainerDetailsViewRow
                                                      ?.barcodeOut,
                                                  '/',
                                                );
                                              } else {
                                                return '/';
                                              }
                                            }(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          )),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 280.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: TextFormField(
                                                controller: _model
                                                        .barcodeTFTextController ??=
                                                    TextEditingController(
                                                  text: () {
                                                    if (widget.flow == 'in') {
                                                      return valueOrDefault<
                                                          String>(
                                                        detailsViewContainerDetailsViewRow
                                                            ?.barcode,
                                                        '/',
                                                      );
                                                    } else if (widget.flow ==
                                                        'out') {
                                                      return valueOrDefault<
                                                          String>(
                                                        detailsViewContainerDetailsViewRow
                                                            ?.barcodeOut,
                                                        '/',
                                                      );
                                                    } else {
                                                      return '/';
                                                    }
                                                  }(),
                                                ),
                                                focusNode:
                                                    _model.barcodeTFFocusNode,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  labelText: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'orv8tifl' /* Insert new value... */,
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
                                                    .barcodeTFTextControllerValidator
                                                    .asValidator(context),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 28.0, 28.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
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
                                      await DetailsTable().update(
                                        data: {
                                          'good': _model.goodDDValue != null &&
                                                  _model.goodDDValue != ''
                                              ? _model.goodDDValue
                                              : detailsViewContainerDetailsViewRow
                                                  ?.good,
                                          'good_description': _model
                                                          .descriptionDDValue !=
                                                      null &&
                                                  _model.descriptionDDValue !=
                                                      ''
                                              ? _model.descriptionDDValue
                                              : detailsViewContainerDetailsViewRow
                                                  ?.goodDescription,
                                          'packaging': _model
                                                          .packagingDDValue !=
                                                      null &&
                                                  _model.packagingDDValue != ''
                                              ? _model.packagingDDValue
                                              : detailsViewContainerDetailsViewRow
                                                  ?.packaging,
                                          'warehouse_position': _model
                                                          .warehpusePositionDDValue !=
                                                      null &&
                                                  _model.warehpusePositionDDValue !=
                                                      ''
                                              ? _model.warehpusePositionDDValue
                                              : detailsViewContainerDetailsViewRow
                                                  ?.warehousePosition,
                                        },
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'id',
                                          widget.idDetailsP,
                                        ),
                                      );
                                      if (widget.flow == 'in') {
                                        await DetailsTable().update(
                                          data: {
                                            'barcode': _model.barcodeTFTextController
                                                            .text !=
                                                        ''
                                                ? _model.barcodeTFTextController
                                                    .text
                                                : detailsViewContainerDetailsViewRow
                                                    ?.barcode,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            widget.idDetailsP,
                                          ),
                                        );
                                      }
                                      if (widget.flow == 'out') {
                                        await DetailsTable().update(
                                          data: {
                                            'barcode_out': _model.barcodeTFTextController
                                                            .text !=
                                                        ''
                                                ? _model.barcodeTFTextController
                                                    .text
                                                : detailsViewContainerDetailsViewRow
                                                    ?.barcodeOut,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            widget.idDetailsP,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            ).then((value) =>
                                safeSetState(() => _model.sureQueryOP = value));

                            if (_model.sureQueryOP!) {
                              await widget.refreshQueries?.call();
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'mor3o7pl' /* Save changes */,
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
  }
}
