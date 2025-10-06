import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'documents_model.dart';
export 'documents_model.dart';

class DocumentsWidget extends StatefulWidget {
  const DocumentsWidget({
    super.key,
    String? orderId,
  }) : this.orderId = orderId ?? 'd310d1bc-a931-4f53-a03a-1bf4c3f85e0b';

  final String orderId;

  @override
  State<DocumentsWidget> createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> {
  late DocumentsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DocumentsModel());

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

    return FutureBuilder<List<OrderLevelRow>>(
      future: (_model.requestCompleter ??= Completer<List<OrderLevelRow>>()
            ..complete(OrderLevelTable().querySingleRow(
              queryFn: (q) => q.eqOrNull(
                'id',
                widget.orderId,
              ),
            )))
          .future,
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
        List<OrderLevelRow> documentsOrderLevelRowList = snapshot.data!;

        final documentsOrderLevelRow = documentsOrderLevelRowList.isNotEmpty
            ? documentsOrderLevelRowList.first
            : null;

        return Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: 600.0,
            height: 400.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'dfjn6g41' /* Documents */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Roboto',
                              fontSize: 28.0,
                              letterSpacing: 0.0,
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
                          Icons.close_outlined,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final documentsList =
                          documentsOrderLevelRow?.documents.toList() ?? [];

                      return DataTable2(
                        columns: [
                          DataColumn2(
                            label: DefaultTextStyle.merge(
                              softWrap: true,
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '0a2yk14h' /* Pdf */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            fixedWidth: 50.0,
                          ),
                          DataColumn2(
                            label: DefaultTextStyle.merge(
                              softWrap: true,
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'url3h1t4' /* Name */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          DataColumn2(
                            label: DefaultTextStyle.merge(
                              softWrap: true,
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    FFAppState().fileUrl = '';
                                    safeSetState(() {});
                                    await actions.documentPicker();
                                    if (FFAppState().fileUrl != '') {
                                      _model.pdfList = documentsOrderLevelRow!
                                          .documents
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                      _model.addToPdfList(FFAppState().fileUrl);
                                      safeSetState(() {});
                                      await OrderLevelTable().update(
                                        data: {
                                          'documents': _model.pdfList,
                                        },
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'id',
                                          widget.orderId,
                                        ),
                                      );
                                      safeSetState(
                                          () => _model.requestCompleter = null);
                                      await _model.waitForRequestCompleted();
                                      _model.pdfList = documentsOrderLevelRow
                                          .documents
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                    }
                                  },
                                  child: Icon(
                                    Icons.add_circle,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            fixedWidth: 40.0,
                          ),
                        ],
                        rows: documentsList
                            .mapIndexed((documentsListIndex,
                                    documentsListItem) =>
                                [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await actions.openLink(
                                          documentsListItem,
                                        );
                                      },
                                      child: Icon(
                                        Icons.picture_as_pdf_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: SelectionArea(
                                                child: Text(
                                              valueOrDefault<String>(
                                                functions.urlName(
                                                    valueOrDefault<String>(
                                                  documentsListItem,
                                                  '/',
                                                )),
                                                '/',
                                              ).maybeHandleOverflow(
                                                maxChars: 50,
                                                replacement: '…',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0.0,
                                                      ),
                                            )),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: documentsListItem));
                                          },
                                          child: Icon(
                                            Icons.content_copy,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
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
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: SureQueryWidget(
                                                  saveChangesP: () async {
                                                    _model.pdfList =
                                                        documentsOrderLevelRow!
                                                            .documents
                                                            .toList()
                                                            .cast<String>();
                                                    safeSetState(() {});
                                                    await actions
                                                        .deleteSupaFile(
                                                      'documents',
                                                      documentsListItem,
                                                    );
                                                    _model
                                                        .removeAtIndexFromPdfList(
                                                            documentsListIndex);
                                                    safeSetState(() {});
                                                    await OrderLevelTable()
                                                        .update(
                                                      data: {
                                                        'documents':
                                                            _model.pdfList,
                                                      },
                                                      matchingRows: (rows) =>
                                                          rows.eqOrNull(
                                                        'id',
                                                        widget.orderId,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );

                                          safeSetState(() =>
                                              _model.requestCompleter = null);
                                          await _model
                                              .waitForRequestCompleted();
                                          _model.pdfList =
                                              documentsOrderLevelRow!.documents
                                                  .toList()
                                                  .cast<String>();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: FlutterFlowTheme.of(context)
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
                        dataRowHeight: 56.0,
                        border: TableBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        dividerThickness: 1.0,
                        columnSpacing: 0.0,
                        showBottomBorder: true,
                        minWidth: 49.0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
