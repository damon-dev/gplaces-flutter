import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:places_autocomplete/src/places_client.dart';

class Places {
  Places._();

  static bool _isLogsEnabled = true;
  static const MethodChannel _methodChannel =
      MethodChannel('gpa_method_channel');

  static PlacesClient createClient() {
    return PlacesClient(
      _methodChannel,
      showLogs: _isLogsEnabled,
    );
  }

  static void initialize() async {
    _methodChannel.invokeMethod('initialize').then((_) {
      _log("🚀🚀🚀 places initialized successfully");
    }).catchError((error) {
      _errorLogs("⚠️⚠️⚠️ $error");
    });
  }

  static Future<bool> get isInitialized async {
    try {
      return await _methodChannel.invokeMethod('isInitialized');
    } catch (error) {
      _errorLogs("⚠️⚠️⚠️ $error");
      return false;
    }
  }

  static void showLogs(bool toSet) {
    _isLogsEnabled = toSet;
  }

  static void _log(message) {
    if (!_isLogsEnabled) return;
    if (kDebugMode) {
      print(message);
    }
  }

  static void _errorLogs(message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
