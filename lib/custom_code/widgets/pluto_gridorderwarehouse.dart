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

import '/custom_code/widgets/index.dart'; // Otros widgets
import '/custom_code/actions/index.dart'; // Custom actions
import '/flutter_flow/custom_functions.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart'; // firstWhereOrNull
import 'package:provider/provider.dart'; // para context.watch

/// Vistas cuyo layout se persiste
const _allowedViews = {
  'orderWarehouse',
  'warehouse2',
  'calendar',
  'reportsGeneral',
  'reportsStock',
  'customs',
  'editForm', // esta vista no tendrá filtrado
};

class PlutoGridorderwarehouse extends StatefulWidget {
  const PlutoGridorderwarehouse({
    super.key,
    this.width,
    this.height,
    this.data,
    required this.defaultColumnWidth,
    this.columns,
    required this.language,
    required this.editAction,
    this.copyAction,
    this.pdfAction,
    this.detailsAction,
    this.deleteAction, // NUEVO
    this.cellSelectAction,
    this.documentsAction,
    required this.viewName,
    this.filtersAction,
    this.gridStateAction,
    this.filteredColumns, // NUEVO: lista de columnas filtradas para colorear iconos
  });

  final double? width;
  final double? height;
  final List<dynamic>? data; // lista de maps
  final double defaultColumnWidth;
  final List<dynamic>? columns; // metadatos columnas
  final String language; // 'es', 'en', 'sl'

  // acciones iconos
  final Future Function() editAction;
  final Future Function()? copyAction;
  final Future Function()? pdfAction;
  final Future Function()? detailsAction;
  final Future Function()? deleteAction; // NUEVO
  final Future Function()? cellSelectAction;
  final Future Function()? documentsAction;
  final Future Function()? filtersAction;
  final Future Function()? gridStateAction;

  final String viewName;

  /// NUEVO: columnas actualmente filtradas (para colorear iconos del header)
  final List<String>? filteredColumns;

  @override
  State<PlutoGridorderwarehouse> createState() =>
      _PlutoGridorderwarehouseState();
}

class _PlutoGridorderwarehouseState extends State<PlutoGridorderwarehouse> {
  /* ---------- estado interno ---------- */
  late String _language;
  late PlutoGridStateManager _stateManager;
  bool _gridLoaded = false;

  late List<PlutoColumn> _columns;
  late Map<String, ValueNotifier<bool>> _notifiers;

  int _gridVersion = 0; // se incrementa SOLO en reset grid
  PlutoCell? _lastCell;
  bool _layoutRestored = false;
  bool _isRestoring = false;
  bool _isResetting =
      false; // Nueva bandera para evitar restauración tras reset

  /// Firma inmutable de filteredColumns para detectar cambios aunque se mute la misma lista
  late String _filteredSig;

  /// Firma inmutable del arreglo de columnas (para detectar mutaciones in-place)
  late String _columnsSig;

  /// Firma (signature) del último layout aplicado al grid (para reacciones desde AppState)
  String _lastAppliedLayoutSig = '';

  /// Estimación del padding horizontal que aplica Pluto a cada celda.
  static const double _cellSidePadding = 8.0;

  /// Filtros deshabilitados para la vista `editForm`
  bool get _filtersEnabledForCurrentView => widget.viewName != 'editForm';

  /// Fila resaltada tras ejecutar la acción de celda
  dynamic _highlightedRowId;

  /// Set normalizado de columnas filtradas (para comparaciones rápidas)
  Set<String> get _filteredSet {
    final list = widget.filteredColumns ?? const <String>[];
    return list.map((e) => e.toString()).toSet();
  }

  /// Cache de formateadores (mejor performance)
  static final NumberFormat _fmtInt = NumberFormat('#,##0', 'en_US');
  static final NumberFormat _fmtDouble = NumberFormat('#,##0.000', 'en_US');
  static final DateFormat _fmtDate = DateFormat('yyyy-MM-dd');

  String _computeFilteredSig(List<String>? list) {
    if (list == null || list.isEmpty) return '';
    final s = list.map((e) => e.toString()).toSet().toList()..sort();
    return s.join('||');
  }

  String _computeColumnsSig(List<dynamic>? columns) {
    if (columns == null || columns.isEmpty) return '';
    // Firma orden-insensible basada en las props relevantes
    final sigParts = <String>[];
    for (final raw in columns) {
      final m = Map<String, dynamic>.from(raw as Map);
      final name = '${m['column_name']}';
      final width = '${m['width']}';
      final dtype = '${m['datatype']}';
      final uiEn = '${m['ui_en']}';
      final uiEs = '${m['ui_es']}';
      final uiSl = '${m['ui_sl']}';
      sigParts.add('$name|$width|$dtype|$uiEn|$uiEs|$uiSl');
    }
    sigParts.sort();
    return sigParts.join(';;');
  }

  /// ==== Firma determinística del payload (deduplicación) ====
  String _computePayloadSignature(Map<String, dynamic> payload) {
    final vis = List<String>.from(payload['visible'] ?? const <String>[]);
    final hid = List<String>.from(payload['hidden'] ?? const <String>[]);
    final wMap = Map<String, dynamic>.from(payload['widths'] ?? const {});

    // visible: importa el orden
    final visPart = vis.join('|');

    // hidden: orden-insensible → ordenamos
    hid.sort();
    final hidPart = hid.join('|');

    // widths: orden-insensible → ordenamos por key y normalizamos double
    final keys = wMap.keys.map((e) => e.toString()).toList()..sort();
    final widthParts = <String>[];
    for (final k in keys) {
      final v = (wMap[k] as num?)?.toDouble() ?? 0.0;
      widthParts.add('$k=${v.toStringAsFixed(3)}');
    }
    final widPart = widthParts.join('|');

    return 'V:${visPart}__H:${hidPart}__W:${widPart}';
  }

  /* --------------- INIT --------------- */
  @override
  void initState() {
    super.initState();
    assert(_allowedViews.contains(widget.viewName));

    // Migración a nuevo shape si fuera necesario
    _maybeMigratePlutoGridTableInfo();

    FFAppState().plutogridTableInfo ??= [];
    FFAppState().currentGridSet ??= [];
    FFAppState().filtersDisplay ??= <String>[];

    // Inicializar listas de selección por vista (NO se crea ninguna para editForm)
    FFAppState().filtersSelectedOrderwarehouse ??= <String>[];
    FFAppState().filtersSelectedCalendar ??= <String>[];
    FFAppState().filtersSelectedReports ??= <String>[];
    FFAppState().filtersSelectedWarehouse2 ??= <String>[];
    FFAppState().filtersSelectedCustoms ??= <String>[]; // sin editForm

    _language = widget.language;

    // Asegurar desde el arranque que la lista tenga como máximo 1 elemento
    _enforceSingleFilter();

    _filteredSig = _computeFilteredSig(widget.filteredColumns);
    _columnsSig = _computeColumnsSig(widget.columns);

    _buildNotifiers();
    _columns = _buildColumns(widget.data);
  }

  /// ==== Migración de formato viejo → nuevo (1 JSON por vista con hasta 3 states) ====
  void _maybeMigratePlutoGridTableInfo() {
    final rawList = FFAppState().plutogridTableInfo;
    if (rawList == null || rawList.isEmpty) return;

    final hasNewShape = rawList.any((e) {
      if (e is Map) {
        return e.containsKey('states') && e.containsKey('activeId');
      }
      return false;
    });

    final hasOldShape = rawList.any((e) {
      if (e is Map) {
        return e.containsKey('visible') ||
            e.containsKey('hidden') ||
            e.containsKey('widths');
      }
      return false;
    });

    if (!hasOldShape || hasNewShape) {
      if (hasNewShape) {
        final newList = List<Map<String, dynamic>>.from(
            rawList.map((e) => Map<String, dynamic>.from(e as Map)));
        final cg = <Map<String, dynamic>>[];
        for (final entry in newList) {
          final view = entry['view'];
          final activeId = entry['activeId'];
          if (view != null && activeId != null) {
            cg.add({'view': view, 'id': activeId});
          }
        }
        if (cg.isNotEmpty) {
          FFAppState().currentGridSet = cg;
        }
      }
      return;
    }

    // Agrupamos por 'view' del formato viejo
    final byView = <String, List<Map<String, dynamic>>>{};
    for (final e in rawList) {
      if (e is Map && e.containsKey('view')) {
        final view = e['view']?.toString() ?? '';
        if (view.isEmpty) continue;
        final payload = <String, dynamic>{
          'visible': List<String>.from(e['visible'] ?? const <String>[]),
          'hidden': List<String>.from(e['hidden'] ?? const <String>[]),
          'widths': Map<String, dynamic>.from(e['widths'] ?? const {}),
        };
        byView.putIfAbsent(view, () => <Map<String, dynamic>>[]).add({
          'payload': payload,
        });
      }
    }

    if (byView.isEmpty) return;

    final migrated = <Map<String, dynamic>>[];
    final cgList = <Map<String, dynamic>>[];
    final nowIso = DateTime.now().toUtc().toIso8601String();

    byView.forEach((view, items) {
      final limited = items.take(3).toList();

      final states = <Map<String, dynamic>>[];
      for (var i = 0; i < limited.length; i++) {
        states.add({
          'id': '$view-$i',
          'name': 'Migrado #${i + 1}',
          'updatedAt': nowIso,
          'payload': limited[i]['payload'],
        });
      }

      final activeId = states.isNotEmpty ? '$view-0' : null;
      migrated.add({
        'view': view,
        'states': states,
        'activeId': activeId,
      });
      if (activeId != null) {
        cgList.add({'view': view, 'id': activeId});
      }
    });

    if (migrated.isNotEmpty) {
      FFAppState().plutogridTableInfo = migrated;
      if (cgList.isNotEmpty) {
        FFAppState().currentGridSet = cgList;
      }
    }
  }

  /* -------- notifiers filtro -------- */
  void _buildNotifiers() {
    if (!_filtersEnabledForCurrentView) {
      _notifiers = <String, ValueNotifier<bool>>{};
      return;
    }

    final selectedNow = _readSelectedForCurrentView();

    _notifiers = {
      for (final raw in widget.columns ?? [])
        if (FFAppState()
            .filtersDisplay
            .contains((raw as Map)['column_name'] as String))
          (raw)['column_name'] as String: ValueNotifier(
            selectedNow.contains((raw)['column_name'] as String),
          )
    };
  }

  @override
  void dispose() {
    for (final n in _notifiers.values) n.dispose();
    if (mounted) _stateManager.removeListener(_handleSelectionChange);
    _saveLayout(); // guarda y dispara acción
    super.dispose();
  }

  /* -------- didUpdateWidget -------- */
  @override
  void didUpdateWidget(covariant PlutoGridorderwarehouse old) {
    super.didUpdateWidget(old);

    final languageChanged = old.language != widget.language;
    final columnsRefChanged = old.columns != widget.columns;
    final dataChanged = old.data != widget.data;

    final newFilteredSig = _computeFilteredSig(widget.filteredColumns);
    final filteredChanged = _filteredSig != newFilteredSig;
    _filteredSig = newFilteredSig;

    final newColumnsSig = _computeColumnsSig(widget.columns);
    final columnsSigChanged = _columnsSig != newColumnsSig;
    _columnsSig = newColumnsSig;

    // NUEVO: Detectar cambio en activeId de plutogridTableInfo
    final currentLayout = _cachedLayout();
    final currentLayoutSig = _computePayloadSignature(currentLayout);
    final layoutChanged = currentLayoutSig != _lastAppliedLayoutSig;

    if (languageChanged || columnsRefChanged || columnsSigChanged) {
      _language = widget.language;
      _enforceSingleFilter();

      for (final n in _notifiers.values) n.dispose();
      _buildNotifiers();
    }

    if (languageChanged ||
        columnsRefChanged ||
        columnsSigChanged ||
        dataChanged ||
        filteredChanged) {
      setState(() => _columns = _buildColumns(widget.data));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_gridLoaded) return;
        _stateManager
          ..removeAllRows()
          ..appendRows(_buildRows(widget.data ?? []));
        _layoutRestored = false;
        _restoreLayout();
      });
    }

    // NUEVO: Si cambió el layout (activeId diferente), restaurar
    // PERO solo si NO estamos en medio de un reset
    if (layoutChanged && _gridLoaded && !_isResetting) {
      _layoutRestored = false;
      WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLayout());
    }

    if (!_layoutRestored && _columns.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLayout());
    }
  }

  /* -------- layout cache -------- */
  Map<String, dynamic> _cachedLayout() {
    final list = List<dynamic>.from(FFAppState().plutogridTableInfo ?? []);
    final raw = list.firstWhere(
      (e) => e is Map && e['view'] == widget.viewName,
      orElse: () => <String, dynamic>{},
    );

    if (raw is! Map || raw.isEmpty) return <String, dynamic>{};

    final String? activeId = raw['activeId'] as String?;
    final states = List<Map<String, dynamic>>.from(
      (raw['states'] ?? const <Map<String, dynamic>>[])
          .map((e) => Map<String, dynamic>.from(e as Map)),
    );

    Map<String, dynamic> state = <String, dynamic>{};

    if (activeId != null) {
      state = states.firstWhere(
        (s) => s['id'] == activeId,
        orElse: () => states.isNotEmpty ? states.first : <String, dynamic>{},
      );
    } else if (states.isNotEmpty) {
      state = states.first;
    }

    return Map<String, dynamic>.from(state['payload'] ?? <String, dynamic>{});
  }

  /// Guarda estado → muestra snackbar → ejecuta gridStateAction (con deduplicación por signature)
  Future<void> _saveLayout() async {
    if (!_gridLoaded || _stateManager.refColumns.isEmpty) return;

    final payload = _buildCurrentGridPayload();
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final newSig = _computePayloadSignature(payload);

    Map<String, dynamic> entry = {};
    int entryIdx = -1;

    FFAppState().plutogridTableInfo ??= [];
    final list = List<dynamic>.from(FFAppState().plutogridTableInfo);

    entryIdx = list.indexWhere((e) => e is Map && e['view'] == widget.viewName);
    if (entryIdx >= 0) {
      entry = Map<String, dynamic>.from(list[entryIdx] as Map);
    } else {
      entry = {
        'view': widget.viewName,
        'states': <Map<String, dynamic>>[],
        'activeId': null,
      };
    }

    final states = List<Map<String, dynamic>>.from(
      (entry['states'] ?? const <Map<String, dynamic>>[])
          .map((e) => Map<String, dynamic>.from(e as Map)),
    );

    final String? activeId = entry['activeId'] as String?;

    // 0-A) DEDUP contra el ACTIVO: si la firma coincide, no guardamos nada
    if (activeId != null) {
      final activeState =
          states.firstWhereOrNull((s) => s['id'] == activeId) ?? const {};
      final activePayload =
          Map<String, dynamic>.from(activeState['payload'] ?? const {});
      final activeSig = _computePayloadSignature(activePayload);

      if (activeSig == newSig) {
        final snackTxt = {
              'es': 'Sin cambios por guardar',
              'en': 'No changes to save',
              'sl': 'Ni sprememb za shranjevanje',
            }[_language] ??
            'No changes to save';

        final messenger = ScaffoldMessenger.maybeOf(context);
        if (mounted && messenger != null) {
          messenger.showSnackBar(
            SnackBar(
              content: Text(snackTxt),
              duration: const Duration(milliseconds: 900),
            ),
          );
        }
        return;
      }
    }

    // 0-B) DEDUP contra TODOS los states: si ya existe, activar ese y salir
    final existingIdx = states.indexWhere((s) {
      final pay = Map<String, dynamic>.from(s['payload'] ?? const {});
      return _computePayloadSignature(pay) == newSig;
    });
    if (existingIdx >= 0) {
      final existingId = (states[existingIdx]['id'] ?? '').toString();
      entry['activeId'] = existingId;

      // Persistir en AppState (plutogridTableInfo y currentGridSet)
      FFAppState().update(() {
        if (entryIdx >= 0) {
          list[entryIdx] = entry;
        } else {
          entry['states'] = states;
          list.add(entry);
        }
        FFAppState().plutogridTableInfo = list;

        final cg = List<dynamic>.from(FFAppState().currentGridSet ?? []);
        final i =
            cg.indexWhere((e) => e is Map && e['view'] == widget.viewName);
        final obj = {'view': widget.viewName, 'id': existingId};
        if (i >= 0) {
          cg[i] = obj;
        } else {
          cg.add(obj);
        }
        FFAppState().currentGridSet = cg;
      });

      _lastAppliedLayoutSig = newSig;

      final snackTxt = {
            'es': 'Perfil existente activado',
            'en': 'Existing profile activated',
            'sl': 'Obstoječi profil aktiviran',
          }[_language] ??
          'Existing profile activated';
      final messenger = ScaffoldMessenger.maybeOf(context);
      if (mounted && messenger != null) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(snackTxt),
            duration: const Duration(milliseconds: 800),
          ),
        );
      }

      if (widget.gridStateAction != null) {
        await widget.gridStateAction!();
      }
      return;
    }

    // Política: guardar en el slot del activo; si no hay, en el siguiente libre; si lleno, slot 0
    int slotIndex = -1;
    if (activeId != null) {
      slotIndex = int.tryParse(activeId.split('-').last) ?? -1;
    }
    if (slotIndex < 0) {
      slotIndex = states.length < 3 ? states.length : 0;
    }

    final id = '${widget.viewName}-$slotIndex';
    final name = (slotIndex < states.length)
        ? (states[slotIndex]['name'] ?? 'Perfil #${slotIndex + 1}')
        : 'Perfil #${slotIndex + 1}';

    final stateObj = {
      'id': id,
      'name': name,
      'updatedAt': nowIso,
      'payload': payload,
    };

    if (slotIndex < states.length) {
      states[slotIndex] = stateObj;
    } else {
      states.add(stateObj);
    }

    entry['states'] = states;
    entry['activeId'] = id;

    FFAppState().update(() {
      if (entryIdx >= 0) {
        list[entryIdx] = entry;
      } else {
        list.add(entry);
      }
      FFAppState().plutogridTableInfo = list;
    });

    // Actualiza currentGridSet
    FFAppState().update(() {
      final cg = List<dynamic>.from(FFAppState().currentGridSet ?? []);
      final i = cg.indexWhere((e) => e is Map && e['view'] == widget.viewName);
      final obj = {'view': widget.viewName, 'id': id};
      if (i >= 0) {
        cg[i] = obj;
      } else {
        cg.add(obj);
      }
      FFAppState().currentGridSet = cg;
    });

    _lastAppliedLayoutSig = newSig;

    final snackTxt = {
          'es': 'Vista guardada',
          'en': 'View saved',
          'sl': 'Pogled shranjen',
        }[_language] ??
        'View saved';

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (mounted && messenger != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(snackTxt),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }

    if (widget.gridStateAction != null) {
      await widget.gridStateAction!();
    }
  }

  /* ------------ Reset grid ------------ */
  void _resetGrid() {
    // Solo resetear visualmente al estado por defecto (columns del widget)
    // NO eliminar de plutogridTableInfo ni currentGridSet
    // El usuario puede guardar después si quiere sobrescribir un perfil
    _isResetting = true; // Activar bandera para evitar restauración automática

    setState(() {
      _columns = _buildColumns(widget.data);
      _layoutRestored = true; // Marcar como restaurado para evitar auto-restore
      _gridVersion++;
    });

    // Después de rebuild, actualizar signature para coincidir con layout actual
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_gridLoaded) {
        _isResetting = false;
        return;
      }
      // Actualizar signature para que didUpdateWidget no detecte cambio
      final currentLayout = _cachedLayout();
      _lastAppliedLayoutSig = _computePayloadSignature(currentLayout);
      _isResetting = false;
    });

    // Mostrar snackbar informativo
    final snackTxt = {
          'es': 'Vista reseteada a configuración por defecto',
          'en': 'View reset to default configuration',
          'sl': 'Pogled resetovan na privzeto konfiguracijo',
        }[_language] ??
        'View reset to default';

    final messenger = ScaffoldMessenger.maybeOf(context);
    if (mounted && messenger != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(snackTxt),
          duration: const Duration(milliseconds: 1200),
        ),
      );
    }
  }

  /* ------------- filtros ------------- */

  @deprecated
  bool _isFilterPopupOpenForCurrentView() {
    switch (widget.viewName) {
      case 'orderwarehouse':
      case 'orderWarehouse':
        return FFAppState().showFiltersPopUpOrderwarehouse == true;
      case 'warehouse2':
      case 'filtersSelectedWarehouse2':
        return FFAppState().showFiltersPopUpWarehouse2 == true;
      case 'calendar':
      case 'filtersSelectedCalendar':
        return FFAppState().showFiltersPopUpCalendar == true;
      case 'customs':
        return FFAppState().showFiltersPopUpCustoms == true;
      case 'reportsGeneral':
      case 'reportsStock':
      case 'reports':
      case 'filtersSelectedReports':
        return FFAppState().showFiltersPopUpReports == true;
      default:
        return FFAppState().showFiltersPopUpOrderwarehouse == true;
    }
  }

  @deprecated
  void _showFilterOpenSnack() {
    final txt = {
          'es': 'Ya hay un filtro abierto.',
          'en': 'A filter is already open.',
          'sl': 'Filter je že odprt.',
        }[_language] ??
        'A filter is already open.';
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (mounted && messenger != null) {
      messenger.showSnackBar(
        SnackBar(
            content: Text(txt), duration: const Duration(milliseconds: 900)),
      );
    }
  }

  // Lista seleccionada por vista
  List<String> _readSelectedForCurrentView() {
    if (!_filtersEnabledForCurrentView) return const <String>[];

    switch (widget.viewName) {
      case 'orderwarehouse':
      case 'orderWarehouse':
        return List<String>.from(FFAppState().filtersSelectedOrderwarehouse);
      case 'calendar':
      case 'filtersSelectedCalendar':
        return List<String>.from(FFAppState().filtersSelectedCalendar);
      case 'warehouse2':
      case 'filtersSelectedWarehouse2':
        return List<String>.from(FFAppState().filtersSelectedWarehouse2);
      case 'customs':
        return List<String>.from(FFAppState().filtersSelectedCustoms);
      case 'reportsGeneral':
      case 'reportsStock':
      case 'reports':
      case 'filtersSelectedReports':
        return List<String>.from(FFAppState().filtersSelectedReports);
      default:
        return List<String>.from(FFAppState().filtersSelectedOrderwarehouse);
    }
  }

  void _writeSelectedForCurrentView(List<String> next) {
    if (!_filtersEnabledForCurrentView) return;

    switch (widget.viewName) {
      case 'orderwarehouse':
      case 'orderWarehouse':
        FFAppState().filtersSelectedOrderwarehouse = next;
        break;
      case 'calendar':
      case 'filtersSelectedCalendar':
        FFAppState().filtersSelectedCalendar = next;
        break;
      case 'warehouse2':
      case 'filtersSelectedWarehouse2':
        FFAppState().filtersSelectedWarehouse2 = next;
        break;
      case 'customs':
        FFAppState().filtersSelectedCustoms = next;
        break;
      case 'reportsGeneral':
      case 'reportsStock':
      case 'reports':
      case 'filtersSelectedReports':
        FFAppState().filtersSelectedReports = next;
        break;
      default:
        FFAppState().filtersSelectedOrderwarehouse = next;
    }
  }

  bool _isFieldFiltered(String f) {
    if (!_filtersEnabledForCurrentView) return false;
    return _readSelectedForCurrentView().contains(f);
  }

  bool _hasFilterIconForField(String f) {
    return _filtersEnabledForCurrentView &&
        (FFAppState().filtersDisplay.contains(f) || _filteredSet.contains(f));
  }

  void _enforceSingleFilter() {
    final sel = _readSelectedForCurrentView();
    if (sel.length > 1) {
      _writeSelectedForCurrentView([sel.first]);
    }
  }

  void _toggleFilter(String f) async {
    if (!_filtersEnabledForCurrentView) return;
    if (!FFAppState().filtersDisplay.contains(f)) return;

    final current = _readSelectedForCurrentView();
    final prev = current.isNotEmpty ? current.first : null;

    if (prev == f) {
      return;
    }

    _writeSelectedForCurrentView([f]);

    if (prev != null && _notifiers.containsKey(prev)) {
      _notifiers[prev]!.value = false;
    }
    _notifiers[f]?.value = true;

    if (widget.filtersAction != null) {
      await widget.filtersAction!();
    }
  }

  /* ------------ iconos header ------------ */
  Widget _filterIcon(String f) {
    final bool isActive = _filteredSet.contains(f);
    return GestureDetector(
      onTap: () => _toggleFilter(f),
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Icon(
          Icons.filter_list,
          size: 14,
          color: isActive ? Colors.green : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _saveIcon() => GestureDetector(
        onTap: () => _saveLayout(),
        child: const Padding(
          padding: EdgeInsets.only(right: 2),
          child: Icon(Icons.save, size: 14, color: Colors.orange),
        ),
      );

  Widget _resetIcon() => GestureDetector(
        onTap: _resetGrid,
        child: const Padding(
          padding: EdgeInsets.only(right: 2),
          child: Icon(Icons.refresh, size: 14, color: Colors.red),
        ),
      );

  InlineSpan _titleSpan(String f, String lbl) {
    final children = <InlineSpan>[
      const WidgetSpan(child: SizedBox.shrink()),
    ];

    if (_hasFilterIconForField(f)) {
      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _filterIcon(f),
        ),
      );
    }

    if (f == 'icons') {
      children
        ..add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _resetIcon(),
        ))
        ..add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _saveIcon(),
        ));
    }

    children.add(TextSpan(text: lbl));
    return TextSpan(children: children);
  }

  /* -------- formateo -------- */
  String _formatDouble(num? value) {
    if (value == null) return '';
    final formatted = _fmtDouble.format(value);
    return formatted.replaceAll(',', ' ');
  }

  String _formatInt(num? value) {
    if (value == null) return '';
    final formatted = _fmtInt.format(value);
    return formatted.replaceAll(',', ' ');
  }

  String _formatDate(dynamic v) {
    if (v == null) return '';
    if (v is DateTime) return _fmtDate.format(v);
    final s = v.toString();
    final parsed = DateTime.tryParse(s);
    if (parsed != null) return _fmtDate.format(parsed);
    return s.length > 10 ? s.substring(0, 10) : s;
  }

  /* ------- helpers highlight ------- */
  dynamic _rowKey(Map<String, PlutoCell> cells) =>
      cells['id']?.value ?? cells['order_no']?.value;

  bool _isHighlightedRow(PlutoRow row) {
    final key = _rowKey(row.cells);
    return _highlightedRowId != null && key == _highlightedRowId;
  }

  Color _availabilityTint(Map<String, PlutoCell> cells) {
    final raw = cells['availability']?.value;
    if (raw == null) return Colors.transparent;

    final v = raw.toString().toLowerCase().trim();
    if (v == 'consumed') {
      return Colors.greenAccent.withOpacity(0.10);
    }
    if (v.startsWith('disassoc')) {
      return Colors.pinkAccent.withOpacity(0.10);
    }
    if (v == 'error') {
      return Colors.redAccent.withOpacity(0.10);
    }
    return Colors.transparent;
  }

  Widget _wrapRowBg(
    PlutoColumnRendererContext ctx,
    Widget child, {
    Alignment? align,
    bool compact = false,
  }) {
    final Color baseTint = _availabilityTint(ctx.row.cells);

    final Color selectionOverlay = _isHighlightedRow(ctx.row)
        ? Colors.lightBlueAccent.withOpacity(0.15)
        : Colors.transparent;

    final double pad = compact ? 0.0 : _cellSidePadding;

    Widget content = Align(
      alignment: align ?? (compact ? Alignment.center : Alignment.centerLeft),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: pad),
        child: child,
      ),
    );

    if (compact) {
      content = Transform.translate(
        offset: const Offset(-_cellSidePadding, 0),
        child: content,
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -_cellSidePadding,
          right: -_cellSidePadding,
          top: 0,
          bottom: 0,
          child: ColoredBox(color: baseTint),
        ),
        if (selectionOverlay.opacity > 0)
          Positioned(
            left: -_cellSidePadding,
            right: -_cellSidePadding,
            top: 0,
            bottom: 0,
            child: ColoredBox(color: selectionOverlay),
          ),
        content,
      ],
    );
  }

  /* ------------- COLUMNS & ROWS ------------- */

  PlutoColumn _makeColumn(Map<String, dynamic> def, {required bool hidden}) {
    final field = def['column_name'] as String;
    final ui = (def['ui_${_language}'] as String?) ??
        (def['ui_en'] as String?) ??
        field;

    final width =
        (def['width'] as num?)?.toDouble() ?? widget.defaultColumnWidth;
    final dtype = def['datatype'] as String? ?? 'String';

    final isHeaderlessIcon =
        const {'edit', 'copy', 'pdf', 'details', 'delete'}.contains(field);

    final span =
        isHeaderlessIcon ? const TextSpan(text: '') : _titleSpan(field, ' $ui');

    final bool hideMenu = const {
      'icons',
      'edit',
      'copy',
      'pdf',
      'details',
      'delete'
    }.contains(field);

    final bool hasFilterIcon = _hasFilterIconForField(field);
    final bool enableDrag = !hideMenu && !hasFilterIcon;

    const disableSetCols = false;

    if (field == 'icons') {
      return PlutoColumn(
        title: ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        type: PlutoColumnType.text(),
        readOnly: true,
        enableEditingMode: false,
        renderer: (_) => Container(),
      );
    }

    if (field == 'documents') {
      return PlutoColumn(
        title: isHeaderlessIcon ? '' : ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        type: PlutoColumnType.text(),
        readOnly: true,
        enableEditingMode: false,
        renderer: (ctx) => _wrapRowBg(
          ctx,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 18,
                icon: const Icon(Icons.table_chart, color: Colors.purple),
                onPressed: () async {
                  _populateTablesRow(ctx.row.cells);
                  if (widget.documentsAction != null) {
                    await widget.documentsAction!();
                  }
                },
              ),
              ...(() {
                final docs =
                    (ctx.row.cells['documents']?.value as List?) ?? const [];
                return docs.isNotEmpty
                    ? [
                        Text(
                          '${docs.length}',
                          style: const TextStyle(fontSize: 12),
                        )
                      ]
                    : <Widget>[];
              })(),
            ],
          ),
        ),
      );
    }

    if (dtype == 'Icon') {
      return PlutoColumn(
        title: isHeaderlessIcon ? '' : ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        textAlign: PlutoColumnTextAlign.center,
        type: PlutoColumnType.text(),
        readOnly: true,
        enableEditingMode: false,
        renderer: (ctx) => _wrapRowBg(
          ctx,
          IconButton(
            icon: Icon(
              field == 'edit'
                  ? Icons.edit
                  : field == 'copy'
                      ? Icons.copy
                      : field == 'details'
                          ? Icons.more_vert
                          : field == 'delete'
                              ? Icons.delete
                              : Icons.picture_as_pdf,
              color: Colors.purple,
              size: 18,
            ),
            onPressed: () async {
              _populateTablesRow(ctx.row.cells);
              final act = field == 'edit'
                  ? widget.editAction
                  : field == 'copy'
                      ? widget.copyAction
                      : field == 'details'
                          ? widget.detailsAction
                          : field == 'delete'
                              ? widget.deleteAction
                              : widget.pdfAction;
              if (act != null) await act();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          align: Alignment.center,
          compact: true,
        ),
      );
    }

    if (dtype == 'bool') {
      return PlutoColumn(
        title: ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        readOnly: true,
        enableEditingMode: false,
        type: PlutoColumnType.select(<bool>[true, false]),
        renderer: (ctx) => _wrapRowBg(
          ctx,
          Center(
            child: Icon(
              ctx.cell.value == true ? Icons.check_circle : Icons.cancel,
              color:
                  ctx.cell.value == true ? Colors.lightGreen : Colors.redAccent,
              size: 18,
            ),
          ),
        ),
      );
    }

    if (dtype == 'double') {
      return PlutoColumn(
        title: ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        type: PlutoColumnType.number(format: '#,##0.000'),
        renderer: (ctx) => _wrapRowBg(
          ctx,
          Align(
            alignment: Alignment.centerRight,
            child: Text(_formatDouble(ctx.cell.value)),
          ),
        ),
      );
    }

    if (dtype == 'int') {
      return PlutoColumn(
        title: ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        type: PlutoColumnType.number(format: '#,##0'),
        renderer: (ctx) => _wrapRowBg(
          ctx,
          Align(
            alignment: Alignment.centerRight,
            child: Text(_formatInt(ctx.cell.value)),
          ),
        ),
      );
    }

    if (dtype == 'DateTime') {
      return PlutoColumn(
        title: ui,
        field: field,
        width: width,
        hide: hidden,
        enableFilterMenuItem: false,
        enableContextMenu: !hideMenu,
        enableSetColumnsMenuItem: disableSetCols,
        enableColumnDrag: enableDrag,
        suppressedAutoSize: true,
        titleSpan: span,
        type: PlutoColumnType.date(format: 'yyyy-MM-dd'),
        renderer: (ctx) => _wrapRowBg(
          ctx,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(_formatDate(ctx.cell.value)),
          ),
        ),
      );
    }

    return PlutoColumn(
      title: ui,
      field: field,
      width: width,
      hide: hidden,
      enableFilterMenuItem: false,
      enableContextMenu: !hideMenu,
      enableSetColumnsMenuItem: disableSetCols,
      enableColumnDrag: enableDrag,
      suppressedAutoSize: true,
      titleSpan: span,
      type: PlutoColumnType.text(),
      renderer: (ctx) => _wrapRowBg(
        ctx,
        Align(
          alignment: Alignment.centerLeft,
          child: Text('${ctx.cell.value ?? ''}'),
        ),
      ),
    );
  }

  List<PlutoColumn> _buildColumns(List<dynamic>? data) {
    final cols = <PlutoColumn>[];
    final layout = _cachedLayout();
    final vis = List<String>.from(layout['visible'] ?? []);
    final hidden = Set<String>.from(layout['hidden'] ?? []);

    final defs = {
      for (final raw in widget.columns ?? [])
        (raw as Map)['column_name']: Map<String, dynamic>.from(raw)
    };

    for (final f in vis) {
      final d = defs[f];
      if (d != null) cols.add(_makeColumn(d, hidden: hidden.contains(f)));
    }
    for (final raw in widget.columns ?? []) {
      final d = Map<String, dynamic>.from(raw as Map);
      final f = d['column_name'];
      if (!vis.contains(f)) {
        cols.add(_makeColumn(d, hidden: hidden.contains(f)));
      }
    }

    if (data != null &&
        data.isNotEmpty &&
        (data.first as Map).containsKey('id') &&
        !cols.any((c) => c.field == 'id')) {
      cols.insert(
        0,
        PlutoColumn(
          title: 'id',
          field: 'id',
          hide: true,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSetColumnsMenuItem: false,
          enableColumnDrag: false,
          suppressedAutoSize: true,
          titleSpan: _titleSpan('id', ' id'),
          type: PlutoColumnType.text(),
        ),
      );
    }
    return cols;
  }

  List<PlutoRow> _buildRows(List<dynamic> data) => data
      .map((e) => PlutoRow(
            cells: {
              for (final c in _columns)
                c.field: PlutoCell(value: (e as Map)[c.field])
            },
          ))
      .toList();

  PlutoColumn? _findColumn(String f) {
    try {
      return _stateManager.refColumns.originalList
          .firstWhere((c) => c.field == f);
    } catch (_) {
      return null;
    }
  }

  void _populateTablesRow(Map<String, PlutoCell> c) {
    Map<String, dynamic> raw = <String, dynamic>{};

    final dynamic rowId = c['id']?.value;
    if (rowId != null) {
      raw = (widget.data ?? []).cast<Map<String, dynamic>>().firstWhere(
            (m) => m['id'] == rowId,
            orElse: () => <String, dynamic>{},
          );
    }
    if (raw.isEmpty) {
      raw = (widget.data ?? []).cast<Map<String, dynamic>>().firstWhere(
            (m) => m['order_no'] == c['order_no']?.value,
            orElse: () => <String, dynamic>{},
          );
    }

    dynamic _get(String k) =>
        raw.containsKey(k) && raw[k] != null ? raw[k] : c[k]?.value;

    FFAppState().tablesRow = OrderWarehouseRowStruct(
      id: _get('id'),
      orderNo: _get('order_no'),
      flow: _get('flow'),
      clientName: _get('client_name'),
      client: _get('client'),
      custom: _get('custom'),
      warehouseName: _get('warehouse_name'),
      warehouse: _get('warehouse'),
      warehousePositionName: _get('warehouse_position_name'),
      invStatus: _get('inv_status'),
      orderStatus: _get('order_status'),
      availability: _get('availability'),
      quantity: _get('quantity'),
      quantityAvailable: _get('quantity_available'),
      containerNo: _get('container_no'),
      licencePlate: _get('licence_plate'),
      universalRefNo: _get('universal_ref_no'),
      fmsRef: _get('fms_ref'),
      loadRefDvh: _get('load_ref_dvh'),
      associatedOrder: _get('associated_order'),
      associatedOrders:
          (_get('associated_orders') as List?)?.map((e) => '$e').toList(),
      item: _get('item'),
      good: _get('good'),
      goodDescription: _get('good_description'),
      opisBlaga: _get('opis_blaga'),
      packaging: _get('packaging'),
      packagingName: _get('packaging_name'),
      weight: _get('weight'),
      palletPosition: _get('pallet_position'),
      damageMark: _get('damage_mark'),
      improvement: _get('improvement'),
      loadingType: _get('loading_type'),
      loadingType2: _get('loading_type2'),
      otherManipulation: _get('other_manipulation'),
      loadingGateRamp: _get('loading_gate_ramp'),
      loadingSequence: _get('loading_sequence'),
      etaDate2: _get('eta_date2'),
      etaI2: _get('eta_i2'),
      etaF2: _get('eta_f2'),
      arrival2: _get('arrival2'),
      start2: _get('start2'),
      stop2: _get('stop2'),
      createdAt2: _get('created_at2'),
      customName: _get('custom_name'),
      responsibleName: _get('responsible_name'),
      responsibleLastName: _get('responsible_last_name'),
      adminName: _get('admin_name'),
      adminLastName: _get('admin_last_name'),
      admin: _get('admin'),
      assistant1Name: _get('assistant1_name'),
      assistant1LastName: _get('assistant1_last_name'),
      assistant1: _get('assistant1'),
      assistant2Name: _get('assistant2_name'),
      assistant2LastName: _get('assistant2_last_name'),
      assistant2: _get('assistant2'),
      assistant3Name: _get('assistant3_name'),
      assistant3LastName: _get('assistant3_last_name'),
      assistant3: _get('assistant3'),
      assistant4Name: _get('assistant4_name'),
      assistant4LastName: _get('assistant4_last_name'),
      assistant4: _get('assistant4'),
      assistant5Name: _get('assistant5_name'),
      assistant5LastName: _get('assistant5_last_name'),
      assistant5: _get('assistant5'),
      assistant6Name: _get('assistant6_name'),
      assistant6LastName: _get('assistant6_last_name'),
      assistant6: _get('assistant6'),
      acepted: _get('acepted'),
      precheck: _get('precheck'),
      checked: _get('checked'),
      internalRefCustom: _get('internal_ref_custom'),
      internalAccounting: _get('internal_accounting'),
      weightBalance: _get('weight_balance'),

      // NUEVOS CAMPOS ADUANAS
      taricCode: _get('taric_code'),
      customsPercentage: _get('customs_percentage'),
      euroOrDolar: _get('euro_or_dolar'),
      exchangeRateUsed: _get('exchange_rate_used'),
      initCost: _get('init_cost'),
      exchangedCost: _get('exchanged_cost'),
      valuePerUnit: _get('value_per_unit'),
      customPercentagePerCost: _get('custom_percentage_per_cost'),
      acumulatedCustomsPercentages: _get('acumulated_customs_percentages'),
      currentCustomsWarranty: _get('current_customs_warranty'),
      remainingCustomsThreshold: _get('remaining_customs_threshold'),
      euros: _get('euros'),
      dolars: _get('dolars'),
      groupConsumedThreshold: _get('group_consumed_threshold'),

      details: _get('details'),
      documents: (_get('documents') as List?)?.map((e) => '$e').toList(),
      barcodes: (_get('barcodes') as List?)?.map((e) => '$e').toList(),
      noBarcodes: (_get('no_barcodes') as List?)?.map((e) => '$e').toList(),
      repeatedBarcodes:
          (_get('repeated_barcodes') as List?)?.map((e) => '$e').toList(),
      comment: _get('comment'),
      unit: _get('unit'),
      responsible: _get('responsible'),
      loadingGate: _get('loading_gate'),
    );
  }

  Widget _documentsRenderer(PlutoColumnRendererContext ctx) {
    final docs = (ctx.row.cells['documents']?.value as List?) ?? const [];
    final n = docs.length;
    return _wrapRowBg(
      ctx,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 18,
            icon: const Icon(Icons.table_chart, color: Colors.purple),
            onPressed: () async {
              _populateTablesRow(ctx.row.cells);
              if (widget.documentsAction != null) {
                await widget.documentsAction!();
              }
            },
          ),
          if (n > 0) Text('$n', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _iconRenderer(PlutoColumnRendererContext ctx) {
    final f = ctx.column.field;
    IconData ic;
    Future Function()? act;
    if (f == 'edit') {
      ic = Icons.edit;
      act = widget.editAction;
    } else if (f == 'copy') {
      ic = Icons.copy;
      act = widget.copyAction;
    } else if (f == 'details') {
      ic = Icons.more_vert;
      act = widget.detailsAction;
    } else if (f == 'delete') {
      ic = Icons.delete;
      act = widget.deleteAction;
    } else {
      ic = Icons.picture_as_pdf;
      act = widget.pdfAction;
    }
    return _wrapRowBg(
      ctx,
      IconButton(
        icon: Icon(ic, color: Colors.purple, size: 18),
        onPressed: () async {
          _populateTablesRow(ctx.row.cells);
          if (act != null) await act();
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
      align: Alignment.center,
      compact: true,
    );
  }

  /* ---------------- BUILD ---------------- */
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    if (!_allowedViews.contains(widget.viewName)) {
      return const SizedBox.shrink();
    }

    if (_columns.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeApplyExternalActiveState();
    });

    final rows = _buildRows(widget.data ?? []);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PlutoGrid(
        key: ValueKey(
          'grid_${widget.language}_${_gridVersion}_$_filteredSig',
        ),
        mode: PlutoGridMode.normal,
        columns: _columns,
        rows: rows,
        configuration: PlutoGridConfiguration(
          columnSize: PlutoGridColumnSizeConfig(
            autoSizeMode: PlutoAutoSizeMode.none,
            resizeMode: PlutoResizeMode.normal,
          ),
          style: PlutoGridStyleConfig(
            // Altura de fila con mejor espaciado
            rowHeight: 48,

            // Colores de fondo según tema
            gridBackgroundColor:
                FlutterFlowTheme.of(context).secondaryBackground,
            oddRowColor: FlutterFlowTheme.of(context).secondaryBackground,
            evenRowColor: FlutterFlowTheme.of(context).primaryBackground,

            // Colores de header con mejor contraste
            columnTextStyle: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),

            // Estilos de celda con buen contraste
            cellTextStyle: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 14,
              fontFamily: 'Roboto',
            ),

            // Bordes sutiles
            borderColor: FlutterFlowTheme.of(context).accent1,
            gridBorderColor: FlutterFlowTheme.of(context).accent1,

            // Color de selección
            activatedColor: FlutterFlowTheme.of(context).accent2,
            activatedBorderColor: FlutterFlowTheme.of(context).primary,

            // Padding de celdas para mejor espaciado
            defaultCellPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            defaultColumnTitlePadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

            // Color de iconos en header
            iconColor: FlutterFlowTheme.of(context).secondaryText,
            disabledIconColor: FlutterFlowTheme.of(context).accent1,

            // Menú contextual
            menuBackgroundColor:
                FlutterFlowTheme.of(context).secondaryBackground,
          ),
        ),
        onRowDoubleTap: (e) {
          final col = e.cell.column;
          if ((col.readOnly ?? false) || !(col.enableEditingMode ?? true)) {
            return;
          }
          _stateManager.setCurrentCell(e.cell, e.rowIdx);
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _stateManager.setEditing(true));
        },
        onLoaded: (e) {
          _stateManager = e.stateManager
            ..setSelectingMode(PlutoGridSelectingMode.cell);
          _stateManager.addListener(_handleSelectionChange);
          _gridLoaded = true;
          _restoreLayout();
        },
      ),
    );
  }

  void _maybeApplyExternalActiveState() {
    if (!_gridLoaded) return;

    final payload = _cachedLayout();
    if (payload.isEmpty) return;

    final sig = _computePayloadSignature(payload);
    if (sig.isEmpty) return;

    if (sig != _lastAppliedLayoutSig) {
      _applyGridPayload(payload);
      _lastAppliedLayoutSig = sig;
    }
  }

  /* ----- selección celda ----- */
  void _handleSelectionChange() async {
    final cell = _stateManager.currentCell;
    if (cell == null || cell == _lastCell) return;
    _lastCell = cell;

    _populateTablesRow(cell.row!.cells);

    if (widget.cellSelectAction != null) {
      await widget.cellSelectAction!();
    }

    final dynamic selectedId =
        cell.row!.cells['id']?.value ?? cell.row!.cells['order_no']?.value;
    if (mounted) {
      setState(() => _highlightedRowId = selectedId);
    }

    if (cell.value is String) {
      await Clipboard.setData(ClipboardData(text: cell.value as String));
    }
  }

  /* -------- restore layout -------- */
  void _restoreLayout() {
    if (_layoutRestored ||
        !_gridLoaded ||
        _stateManager.refColumns.originalList.isEmpty ||
        _isRestoring) return;

    final layout = _cachedLayout();
    final vis = List<String>.from(layout['visible'] ?? []);
    final hid =
        List<String>.from(layout['hidden'] ?? []); // NUEVO: agregar hidden

    // Conversión segura de widths -> Map<String,double>
    final savedWidths = <String, double>{};
    final rawWidths = layout['widths'];
    if (rawWidths is Map) {
      rawWidths.forEach((k, v) {
        savedWidths[k.toString()] = (v as num?)?.toDouble() ?? 0.0;
      });
    }

    _isRestoring = true;

    // Nota: La restauración del orden de columnas tiene limitaciones en PlutoGrid
    // Por ahora solo restauramos visibilidad y anchos que son más importantes
    // El orden se guarda en el payload pero no se restaura automáticamente

    // Aplicar visibilidad
    for (final field in vis) {
      final col = _findColumn(field);
      if (col != null && col.hide) {
        _stateManager.hideColumn(col, false);
      }
    }
    for (final field in hid) {
      final col = _findColumn(field);
      if (col != null && !col.hide) {
        _stateManager.hideColumn(col, true);
      }
    }

    for (final col in _stateManager.refColumns.originalList) {
      final saved = savedWidths[col.field];
      if (saved != null) {
        final delta = saved - col.width;
        if (delta.abs() > 0.1) _stateManager.resizeColumn(col, delta);
      }
    }

    _stateManager.notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) => _isRestoring = false);
    _layoutRestored = true;

    _lastAppliedLayoutSig = _computePayloadSignature(layout);
  }

  /// ===== Helpers de payload (exportar/aplicar) =====

  Map<String, dynamic> _buildCurrentGridPayload() {
    final cols = _stateManager.refColumns.originalList;
    final visibles = cols.where((c) => !c.hide).map((c) => c.field).toList();
    final hiddens = cols.where((c) => c.hide).map((c) => c.field).toList();
    final widths = {for (final c in cols) c.field: c.width};
    final order = cols.map((c) => c.field).toList(); // NUEVO: guardar orden

    return {
      'visible': visibles,
      'hidden': hiddens,
      'widths': widths,
      'order': order, // NUEVO: incluir orden de columnas
    };
  }

  Future<void> _applyGridPayload(Map<String, dynamic> p) async {
    if (!_gridLoaded || _stateManager.refColumns.originalList.isEmpty) return;

    final visible = List<String>.from(p['visible'] ?? const <String>[]);
    final hidden = Set<String>.from(p['hidden'] ?? const <String>{});
    final widths = Map<String, dynamic>.from(p['widths'] ?? const {});

    for (int i = visible.length - 1; i >= 0; i--) {
      final col = _findColumn(visible[i]);
      if (col == null) continue;
      if (col.hide) _stateManager.hideColumn(col, false);
      final target = _stateManager.refColumns.originalList.first;
      _stateManager.moveColumn(column: col, targetColumn: target);
    }

    for (final f in hidden) {
      final col = _findColumn(f);
      if (col != null && !col.hide) _stateManager.hideColumn(col, true);
    }

    widths.forEach((f, w) {
      final col = _findColumn(f);
      if (col == null) return;
      final double targetW = (w as num).toDouble();
      final delta = targetW - col.width;
      if (delta.abs() > 0.1) _stateManager.resizeColumn(col, delta);
    });

    _stateManager.notifyListeners();
  }
}
