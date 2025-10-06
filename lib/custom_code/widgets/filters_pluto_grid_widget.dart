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

class FiltersPlutoGridWidget extends StatefulWidget {
  const FiltersPlutoGridWidget({
    super.key,
    this.width,
    this.height,
    this.orderNoTF,
  });

  final double? width;
  final double? height;

  /// Constructor recibe un widget builder para el TextField de Order No.
  final Widget Function()? orderNoTF;

  @override
  State<FiltersPlutoGridWidget> createState() => _FiltersPlutoGridWidgetState();
}

class _FiltersPlutoGridWidgetState extends State<FiltersPlutoGridWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila de filtro para Order No.
            Row(
              children: [
                Text(
                  'Order No.',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
                const SizedBox(width: 12),
                // Aquí se inserta el TextField pasado via parámetro
                if (widget.orderNoTF != null) ...[
                  SizedBox(
                    width: 200,
                    child: widget.orderNoTF!(),
                  ),
                ],
              ],
            ),
            // Espacio para futuras filas de filtros
          ],
        ),
      ),
    );
  }
}
