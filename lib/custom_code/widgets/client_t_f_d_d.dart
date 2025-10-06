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

import 'dart:async';

class ClientTFDD extends StatefulWidget {
  const ClientTFDD({
    super.key,
    this.width,
    this.height,
    // ==== Parámetros de estilo/tamaño ====
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.dropdownMaxHeight,
    // ==== Inicialización ====
    this.initialText,
    this.initialId,
    // ========================
    required this.clientList,
    required this.action,
    required this.resetAction,
  });

  final double? width;
  final double? height;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final double? dropdownMaxHeight;

  final String? initialText;
  final String? initialId;

  final List<ClientRowStruct> clientList;
  final Future Function() action;
  final Future Function() resetAction;

  @override
  State<ClientTFDD> createState() => _ClientTFDDState();
}

class _ClientTFDDState extends State<ClientTFDD> {
  final TextEditingController _textController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  String? _selectedValue; // guarda el id seleccionado
  bool _isDropdownVisible = false;

  OverlayEntry? _dropdownEntry;
  OverlayEntry? _barrierEntry;

  Timer? _debounce; // para onChanged con debounce

  @override
  void initState() {
    super.initState();
    _prefillFromInitials();

    // 👇 Importante: ya NO cerramos por pérdida de foco para no "comernos" el primer tap.
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus) {
    //     _hideDropdown();
    //   }
    // });
  }

  void _prefillFromInitials() {
    // 1) Si llega initialId, intentar buscar su label
    if ((widget.initialId ?? '').isNotEmpty) {
      final matchById = widget.clientList.firstWhere(
        (e) => e.id == widget.initialId,
        orElse: () => ClientRowStruct(
          id: widget.initialId!,
          client: widget.initialText ?? '',
        ),
      );

      _selectedValue = widget.initialId;
      final label = (matchById.client.isNotEmpty)
          ? matchById.client
          : (widget.initialText ?? '');

      _textController.text = label;
      FFAppState().clientApiV = label;
      FFAppState().clientApiId = _selectedValue!;
      return;
    }

    // 2) Si no hay initialId pero sí initialText
    if ((widget.initialText ?? '').isNotEmpty) {
      _textController.text = widget.initialText!;
      FFAppState().clientApiV = widget.initialText!;
      // No seteamos ID porque no sabemos cuál corresponde hasta que seleccione.
    }
  }

  // ===== Utilidades de estilo según parámetros =====
  BorderRadius _fieldBorderRadius() {
    final double rTL = widget.radiusTopLeft ?? 8.0;
    final double rTR = widget.radiusTopRight ?? 8.0;
    final double rBL = widget.radiusBottomLeft ?? 8.0;
    final double rBR = widget.radiusBottomRight ?? 8.0;
    return BorderRadius.only(
      topLeft: Radius.circular(rTL),
      topRight: Radius.circular(rTR),
      bottomLeft: Radius.circular(rBL),
      bottomRight: Radius.circular(rBR),
    );
  }

  OutlineInputBorder _outline(Color color) {
    final double w = widget.borderWidth ?? 2.0;
    return OutlineInputBorder(
      borderRadius: _fieldBorderRadius(),
      borderSide: BorderSide(color: color, width: w),
    );
  }

  // =================== Dropdown overlay ===================
  void _toggleDropdown() {
    if (_isDropdownVisible) {
      _hideDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;

    // 1) Barrier transparente para cerrar al tocar fuera (y NO cerrar al tocar dentro)
    _barrierEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // Tocar fuera cierra dropdown
            _hideDropdown();
            // Opcional: quitar foco
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );

    // 2) Dropdown propiamente
    _dropdownEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.dropdownMaxHeight ?? 200.0,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                border: Border.all(
                  color: widget.borderColor ?? Colors.grey,
                  width: widget.borderWidth ?? 2.0,
                ),
                borderRadius: _fieldBorderRadius(),
              ),
              child: _buildDropdownList(),
            ),
          ),
        ),
      ),
    );

    // El orden importa: primero barrier, luego dropdown
    overlay.insert(_barrierEntry!);
    overlay.insert(_dropdownEntry!);

    setState(() => _isDropdownVisible = true);
  }

  Widget _buildDropdownList() {
    final items = widget.clientList;
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        // Usamos GestureDetector para asegurar que "tap down" ya marque la intención
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _selectItem(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              item.client,
              style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  void _hideDropdown() {
    bool changed = false;

    if (_dropdownEntry != null) {
      _dropdownEntry!.remove();
      _dropdownEntry = null;
      changed = true;
    }
    if (_barrierEntry != null) {
      _barrierEntry!.remove();
      _barrierEntry = null;
      changed = true;
    }
    if (_isDropdownVisible && changed) {
      setState(() => _isDropdownVisible = false);
    }
  }

  Future<void> _selectItem(ClientRowStruct item) async {
    _selectedValue = item.id;
    _textController.text = item.client;
    FFAppState().clientApiV = item.client;
    FFAppState().clientApiId = _selectedValue!;
    _hideDropdown();
    if (mounted) setState(() {});
    await widget.action();
  }

  Future<void> _onChangedDebounced(String newText) async {
    // Al tipear, invalidar ID hasta confirmar selección
    _selectedValue = null;
    FFAppState().clientApiId = '';
    FFAppState().clientApiV = newText;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (!mounted) return;
      if (newText.isEmpty) {
        await widget.resetAction();
        await widget.action();
      } else {
        await widget.action();
      }
    });
  }

  Future<void> _resetTextField() async {
    _hideDropdown();
    _debounce?.cancel();
    setState(() {
      _textController.clear();
      _selectedValue = null;
      FFAppState().clientApiV = '';
      FFAppState().clientApiId = '';
      FFAppState().clientApiB = false;
    });
    await widget.resetAction();
    await widget.action();
  }

  @override
  Widget build(BuildContext context) {
    final double totalHeight = widget.height ?? 44.0;
    final Color borderColor = widget.borderColor ?? Colors.black;
    final Color bgColor = widget.backgroundColor ?? Colors.white;

    return SizedBox(
      width: widget.width,
      height: totalHeight,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          focusNode: _focusNode,
          controller: _textController,
          style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) async => await widget.action(),
          onChanged: (newText) => _onChangedDebounced(newText),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            hintText: 'Client',
            filled: true,
            fillColor: bgColor,
            border: _outline(borderColor),
            enabledBorder: _outline(borderColor),
            focusedBorder: _outline(borderColor),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Limpiar',
                  icon: const Icon(Icons.clear),
                  onPressed: _resetTextField,
                  splashRadius: 18,
                ),
                IconButton(
                  tooltip:
                      _isDropdownVisible ? 'Cerrar opciones' : 'Ver opciones',
                  icon: Icon(
                    _isDropdownVisible
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                  onPressed: _toggleDropdown,
                  splashRadius: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideDropdown(); // desmontar overlays si están abiertos
    _debounce?.cancel(); // cancelar debounce
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
