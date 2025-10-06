import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import 'edit_account_widget.dart' show EditAccountWidget;
import 'package:flutter/material.dart';

class EditAccountModel extends FlutterFlowModel<EditAccountWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        's3vvyxm6' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for lastName widget.
  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;
  // State field(s) for userTypeDD widget.
  String? userTypeDDValue;
  FormFieldController<String>? userTypeDDValueController;
  // State field(s) for statusDD widget.
  String? statusDDValue;
  FormFieldController<String>? statusDDValueController;
  bool isDataUploading_editPhotoUploaded = false;
  FFUploadedFile uploadedLocalFile_editPhotoUploaded =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_editPhotoUploaded = '';

  // State field(s) for job widget.
  FocusNode? jobFocusNode;
  TextEditingController? jobTextController;
  String? Function(BuildContext, String?)? jobTextControllerValidator;
  Completer<List<UsersRow>>? requestCompleter;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    jobFocusNode?.dispose();
    jobTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
