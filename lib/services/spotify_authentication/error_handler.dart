import 'dart:io';
import 'package:flutter/foundation.dart';
import "package:path_provider/path_provider.dart";

class ErrorHandler {
  Future<void> _logErrorToFile(String message) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/error_log.txt');
    final timestamp = DateTime.now().toIso8601String();
    await file.writeAsString('$timestamp: $message\n', mode: FileMode.append);
  }

  void handleResponseError(int statusCode) {
    final errorMessage = 'Failed to obtain token: $statusCode';
    if (kDebugMode) {
      debugPrint(errorMessage);
    } else {
      _logErrorToFile(errorMessage);
    }
  }

  void handleExceptionError(dynamic exception) {
    final errorMessage = 'Error obtaining token: $exception';
    if (kDebugMode) {
      debugPrint(errorMessage);
    } else {
      _logErrorToFile(errorMessage);
    }
  }
}
