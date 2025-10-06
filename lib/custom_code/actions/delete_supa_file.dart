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

import 'package:supabase_flutter/supabase_flutter.dart';

Future deleteSupaFile(
  String bucket,
  String filePath,
) async {
  // Add your function code here!
  final fileName = filePath.contains('/') ? filePath.split('/').last : filePath;

  final supabase = SupaFlow.client;
  final List<FileObject> objects =
      await supabase.storage.from(bucket).remove([fileName]);
}
