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

class GoodDescriptionTFDD extends StatefulWidget {
  const GoodDescriptionTFDD({
    super.key,
    this.width,
    this.height,
    // === Parámetros de estilo / tamaño ===
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.dropdownMaxHeight,
    // === Inicialización ===
    this.initialText,
    this.initialId,
    // =====================================
    required this.goodDescriptionList,
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

  final List<GoodDescriptionRowStruct> goodDescriptionList;
  final Future Function() action;
  final Future Function() resetAction;

  @override
  State<GoodDescriptionTFDD> createState() => _GoodDescriptionTFDDState();
}

class _GoodDescriptionTFDDState extends State<GoodDescriptionTFDD> {
  final TextEditingController _textController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry; // capa para detectar taps fuera
  bool _isDropdownVisible = false;

  String? _selectedValue; // ID seleccionado desde el dropdown
  Timer? _debounce; // debounce para onChanged

  @override
  void initState() {
    super.initState();
    _prefillFromInitials();

    // ⚠️ Importante: NO cerrar por pérdida de foco (rompía el primer tap)
    // Si quieres autoabrir al enfocar, descomenta abajo:
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus && !_isDropdownVisible) {
    //     _showDropdown();
    //   }
    // });
  }

  void _prefillFromInitials() {
    if ((widget.initialId ?? '').isNotEmpty) {
      final matchById = widget.goodDescriptionList.firstWhere(
        (e) => e.id == widget.initialId,
        orElse: () => GoodDescriptionRowStruct(
          id: widget.initialId!,
          opisBlaga: widget.initialText ?? '',
        ),
      );

      _selectedValue = widget.initialId;
      final label = (matchById.opisBlaga.isNotEmpty)
          ? matchById.opisBlaga
          : (widget.initialText ?? '');

      _textController.text = label;
      FFAppState().goodDescriptionApiV = label;
      FFAppState().goodDescriptionApiId = _selectedValue!;
      return;
    }

    if ((widget.initialText ?? '').isNotEmpty) {
      _textController.text = widget.initialText!;
      FFAppState().goodDescriptionApiV = widget.initialText!;
    }
  }

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
    if (_isDropdownVisible) return;

    // Mantener foco ayuda a evitar cambios de foco al tocar el overlay
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;

    // Barrera para capturar taps fuera y cerrar
    _barrierEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _hideDropdown,
          child: const SizedBox.expand(),
        ),
      ),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            color: Colors.transparent,
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

    // Orden: primero barrera (debajo), luego dropdown (encima)
    overlay.insert(_barrierEntry!);
    overlay.insert(_overlayEntry!);

    setState(() => _isDropdownVisible = true);
  }

  Widget _buildDropdownList() {
    final items = widget.goodDescriptionList;
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          dense: true,
          title: Text(
            item.opisBlaga,
            style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => _selectItem(item),
        );
      },
    );
  }

  void _hideDropdown() {
    _overlayEntry?..remove();
    _overlayEntry = null;

    _barrierEntry?..remove();
    _barrierEntry = null;

    if (_isDropdownVisible && mounted) {
      setState(() => _isDropdownVisible = false);
    } else {
      _isDropdownVisible = false;
    }
  }

  Future<void> _selectItem(GoodDescriptionRowStruct item) async {
    _selectedValue = item.id;
    _textController.text = item.opisBlaga;

    FFAppState().goodDescriptionApiV = item.opisBlaga;
    FFAppState().goodDescriptionApiId = _selectedValue!;

    _hideDropdown();
    if (mounted) setState(() {});
    await widget.action();
  }

  Future<void> _onChangedDebounced(String newText) async {
    _selectedValue = null;
    FFAppState().goodDescriptionApiId = '';
    FFAppState().goodDescriptionApiV = newText;

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
      FFAppState().goodDescriptionApiV = '';
      FFAppState().goodDescriptionApiId = '';
      FFAppState().goodDescriptionApiB = false;
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CompositedTransformTarget(
            link: _layerLink,
            child: SizedBox(
              height: totalHeight,
              width: widget.width,
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
                  hintText: 'Good description',
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
                        tooltip: _isDropdownVisible
                            ? 'Cerrar opciones'
                            : 'Ver opciones',
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hideDropdown();
    _debounce?.cancel();
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
