// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class SelectedFile {
  final String storagePath;
  final Uint8List bytes;

  const SelectedFile({
    required this.storagePath,
    required this.bytes,
  });
}

Future<void> documentPicker() async {
  final selectedFiles = await selectFiles(
    allowedExtensions: ['pdf', 'png', 'jpg'],
    multiFile: false,
  );

  if (selectedFiles != null && selectedFiles.isNotEmpty) {
    final SelectedFile selectedFile = selectedFiles.first;
    final Uint8List fileBytes = selectedFile.bytes;
    final String firstFileName = selectedFile.storagePath.split('/').last;
    DateTime now = DateTime.now();
    String dateFormat = DateFormat("dd.MM.yy-HH:mm").format(now);
    final String fileName = '${dateFormat}_$firstFileName';

    // Subir archivo a Supabase
    final String bucket =
        'documents'; // Asegúrate de cambiar esto al nombre de tu bucket
    final String path =
        '$fileName'; // Asegúrate de usar la ruta correcta para tu bucket

    final supabase = SupaFlow.client;
    final storageResponse = await supabase.storage.from(bucket).uploadBinary(
          path,
          fileBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    // Si la carga es exitosa, guarda el nombre del archivo y obtén la URL pública
    final publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
    FFAppState().fileUrl = publicUrl;
  }
}

Future<List<SelectedFile>?> selectFiles({
  List<String>? allowedExtensions,
  bool multiFile = false,
}) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
    withData: true,
    allowMultiple: multiFile,
  );

  if (result == null) {
    return null;
  }

  return result.files.where((file) => file.bytes != null).map((file) {
    return SelectedFile(
      storagePath: file.name,
      bytes: file.bytes!,
    );
  }).toList();
}
