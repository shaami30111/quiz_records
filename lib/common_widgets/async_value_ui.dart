import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_records/localization/string_hardcoded.dart';

import '../exceptions/app_exception.dart';
import 'alert_dialogs.dart';

/// A helper [AsyncValue] extension to show an alert dialog on error
extension AsyncValueUI on AsyncValue {
  /// show an alert dialog if the current [AsyncValue] has an error and the
  /// state is not loading.
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: message,
      );
    }
  }

  String _errorMessage(Object? error) {
    if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}
