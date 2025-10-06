// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pluto_grid/pluto_grid.dart';

class DetailsPlutogridWidget extends StatefulWidget {
  const DetailsPlutogridWidget({
    super.key,
    this.width,
    this.height,
    this.editAction,
    this.deleteAction,
    this.data,
    this.language,
    this.columns,
    this.checkAction,
    this.xAction,
    this.flow = 'in',
  });

  final double? width;
  final double? height;
  final Future<void> Function()? editAction;
  final Future<void> Function()? deleteAction;
  final List<dynamic>? data;
  final String? language;
  final List<dynamic>? columns;
  final Future<void> Function()? checkAction;
  final Future<void> Function()? xAction;
  final String? flow;

  @override
  State<DetailsPlutogridWidget> createState() => _DetailsPlutogridWidgetState();
}

class _DetailsPlutogridWidgetState extends State<DetailsPlutogridWidget> {
  late PlutoGridStateManager _stateManager;
  late List<PlutoColumn> _columns;
  PlutoCell? _lastCell;

  @override
  void initState() {
    super.initState();
    _columns = _buildColumns(widget.data);
  }

  @override
  void dispose() {
    _stateManager.removeListener(_handleSelectionChange);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DetailsPlutogridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data ||
        oldWidget.columns != widget.columns ||
        oldWidget.language != widget.language ||
        oldWidget.flow != widget.flow) {
      setState(() => _columns = _buildColumns(widget.data));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _stateManager.removeAllRows();
        _stateManager.appendRows(_buildRows(widget.data ?? []));
      });
    }
  }

  // ---------- ACTUALIZA FFAppState ----------
  void _populateDetailsRow(Map<String, PlutoCell>? cellsMap) {
    if (cellsMap == null) return;
    final v = (String key) => cellsMap[key]?.value;

    FFAppState().update(() {
      FFAppState().detailsRow = DetailsViewRowStruct(
        id: v('id'),
        orderId: v('order_id'),
        barcode: v('barcode'),
        barcodeOut: v('barcode_out'),
        // Agrega aquí más campos si lo necesitas para detailsRow
      );
    });
  }

  // ---------- HANDLER UNIVERSAL: LLENA APPSTATE Y LUEGO ACCIÓN ----------
  Future<void> _handleAction(
      Map<String, PlutoCell>? cells, Future<void> Function()? action) async {
    _populateDetailsRow(cells);
    await Future.delayed(Duration.zero); // asegura propagación
    if (action != null) await action();
  }

  // ---------- LISTENER DE SELECCIÓN ----------
  void _handleSelectionChange() async {
    final current = _stateManager.currentCell;
    if (current == null || current == _lastCell) return;
    _lastCell = current;
    _populateDetailsRow(current.row!.cells);
  }

  // ---------- CREA COLUMNAS ----------
  List<PlutoColumn> _buildColumns(List<dynamic>? data) {
    final cols = <PlutoColumn>[];

    // Columna de índice (visible)
    cols.add(
      PlutoColumn(
        title: '#',
        field: 'row',
        type: PlutoColumnType.number(),
        width: 60,
        readOnly: true,
        enableEditingMode: false,
        suppressedAutoSize: true,
        renderer: (ctx) => Center(child: Text(ctx.cell.value.toString())),
      ),
    );

    // Columnas visibles definidas por widget.columns
    for (final raw in widget.columns ?? []) {
      final def = raw as Map<String, dynamic>;
      final field = def['column_name'] as String;
      final datatype = def['datatype'] as String? ?? 'String';
      final width = (def['width'] as num?)?.toDouble() ?? 120.0;
      final lang = (widget.language ?? 'en').toLowerCase();
      final title = def['ui_$lang'] as String? ?? def['ui_en'] ?? field;

      // Columna check (íconos check/x)
      if (field == 'check') {
        cols.add(
          PlutoColumn(
            title: title,
            field: field,
            width: width,
            type: PlutoColumnType.text(),
            readOnly: true,
            enableEditingMode: false,
            suppressedAutoSize: true,
            renderer: (ctx) {
              final cells = ctx.row.cells;
              final isChecked = ctx.cell.value == true;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isChecked)
                    IconButton(
                      icon:
                          Icon(Icons.check, color: Colors.lightGreen, size: 18),
                      onPressed: () => _handleAction(cells, widget.checkAction),
                    ),
                  if (!isChecked)
                    IconButton(
                      icon:
                          Icon(Icons.close, color: Colors.redAccent, size: 18),
                      onPressed: () => _handleAction(cells, widget.xAction),
                    ),
                ],
              );
            },
          ),
        );
        continue;
      }

      // Columnas de íconos (edit, delete, row_action)
      if (datatype == 'Icon') {
        cols.add(
          PlutoColumn(
            title: title,
            field: field,
            width: width,
            type: PlutoColumnType.text(),
            readOnly: true,
            enableEditingMode: false,
            suppressedAutoSize: true,
            renderer: (ctx) {
              final cells = ctx.row.cells;
              IconData icon;
              Future<void> Function()? action;
              switch (field) {
                case 'edit':
                  icon = Icons.edit;
                  action = widget.editAction;
                  break;
                case 'delete':
                  icon = Icons.delete;
                  action = widget.deleteAction;
                  break;
                case 'row_action':
                  icon = Icons.more_vert;
                  action = null;
                  break;
                default:
                  icon = Icons.help_outline;
                  action = null;
              }
              return IconButton(
                icon: Icon(icon, color: Colors.purple, size: 18),
                onPressed: () => _handleAction(cells, action),
              );
            },
          ),
        );
        continue;
      }

      // Otros tipos normales
      PlutoColumnType type;
      switch (datatype) {
        case 'int':
        case 'double':
          type = PlutoColumnType.number();
          break;
        case 'bool':
          type = PlutoColumnType.select([true, false]);
          break;
        case 'DateTime':
          type = PlutoColumnType.date(format: 'yyyy-MM-dd');
          break;
        default:
          type = PlutoColumnType.text();
      }
      cols.add(
        PlutoColumn(
          title: title,
          field: field,
          width: width,
          type: type,
          readOnly: true,
          enableEditingMode: false,
          suppressedAutoSize: true,
        ),
      );
    }

    // ------ Agrega campos ocultos para TODAS las claves del JSON ------
    if (data != null && data.isNotEmpty) {
      final first = Map<String, dynamic>.from(data.first as Map);
      for (final key in first.keys) {
        final exists = cols.any((c) => c.field == key);
        if (!exists) {
          cols.add(
            PlutoColumn(
              title: key,
              field: key,
              type: PlutoColumnType.text(),
              hide: true,
              suppressedAutoSize: true,
              readOnly: true,
              enableEditingMode: false,
            ),
          );
        }
      }
    }
    return cols;
  }

  // ---------- CREA FILAS ----------
  List<PlutoRow> _buildRows(List<dynamic> data) {
    int idx = 1;
    final useOut = widget.flow == 'out';
    return data.map((e) {
      final rowMap = Map<String, dynamic>.from(e as Map);
      rowMap['row'] = idx++;
      rowMap['barcode_list'] =
          (useOut ? rowMap['barcode_out'] : rowMap['barcode'])?.toString() ??
              '';
      // Todos los campos, tanto visibles como ocultos
      return PlutoRow(
        cells: {
          for (final c in _columns) c.field: PlutoCell(value: rowMap[c.field])
        },
      );
    }).toList();
  }

  // ---------- BUILD ----------
  @override
  Widget build(BuildContext context) {
    _columns = _buildColumns(widget.data);
    final rows = _buildRows(widget.data ?? []);

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 400,
      child: PlutoGrid(
        mode: PlutoGridMode.normal,
        columns: _columns,
        rows: rows,
        configuration: const PlutoGridConfiguration(
          columnSize: PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.none,
            resizeMode: PlutoResizeMode.normal,
          ),
          style: PlutoGridStyleConfig(rowHeight: 40),
        ),
        onLoaded: (e) {
          _stateManager = e.stateManager;
          _stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
          _stateManager.addListener(_handleSelectionChange);
        },
        onSelected: (evt) {
          if (evt.row != null) _populateDetailsRow(evt.row!.cells);
        },
        onRowDoubleTap: (evt) async {
          await _handleAction(evt.row.cells, null);
          _stateManager.setCurrentCell(evt.cell, evt.rowIdx);
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _stateManager.setEditing(true));
        },
      ),
    );
  }
}
