import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/floating/sure_query/sure_query_widget.dart';
import '/pages/floating/warehouse_details/warehouse_details_widget.dart';
import 'package:flutter/material.dart';
import 'clients_t_f_model.dart';
export 'clients_t_f_model.dart';

class ClientsTFWidget extends StatefulWidget {
  const ClientsTFWidget({
    super.key,
    this.rowId,
  });

  final String? rowId;

  @override
  State<ClientsTFWidget> createState() => _ClientsTFWidgetState();
}

class _ClientsTFWidgetState extends State<ClientsTFWidget> {
  late ClientsTFModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientsTFModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_model.editSave)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: Container(
              width: 280.0,
              child: TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: FFLocalizations.of(context).getText(
                    'tfcqb0zh' /* Insert new value... */,
                  ),
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Roboto',
                        letterSpacing: 0.0,
                      ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Roboto',
                        letterSpacing: 0.0,
                      ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Roboto',
                      letterSpacing: 0.0,
                    ),
                validator: _model.textControllerValidator.asValidator(context),
              ),
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.all(4.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FFAppState().clearWarehousePositionsCache();
                      FFAppState().clearLoadingGatesCache();
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: WarehouseDetailsWidget(
                              warehouseId: widget.rowId!,
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ),
            if (!_model.editSave)
              Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.editSave = true;
                    safeSetState(() {});
                  },
                  child: Icon(
                    Icons.edit_square,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                ),
              ),
            if (_model.editSave)
              Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (_model.textController.text != '') {
                      await WarehousesTable().update(
                        data: {
                          'warehouse': _model.textController.text,
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.rowId,
                        ),
                      );
                      _model.editSave = false;
                      safeSetState(() {});
                    } else {
                      _model.editSave = false;
                      safeSetState(() {});
                    }
                  },
                  child: Icon(
                    Icons.save_sharp,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                ),
              ),
            Builder(
              builder: (context) => Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
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
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: SureQueryWidget(
                            saveChangesP: () async {
                              await WarehousesTable().delete(
                                matchingRows: (rows) => rows.eqOrNull(
                                  'id',
                                  widget.rowId,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_sharp,
                    color: FlutterFlowTheme.of(context).warning,
                    size: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
