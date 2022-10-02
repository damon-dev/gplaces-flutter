import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:places_autocomplete/src/constants/plugin.dart';
import 'package:places_autocomplete/src/places_client.dart';

///provides programmatic access to Google's database of local
///place and business information, as well as the device's current place.
class Places {
  Places._();

  static bool _isLogsEnabled = true;
  static const MethodChannel _methodChannel =
      MethodChannel(CHANNEL_NAME);

  ///Client that exposes the Places API methods.
  static PlacesClient createClient() {
    return PlacesClient(
      _methodChannel,
      showLogs: _isLogsEnabled,
    );
  }

  ///provides programmatic access to Google's database of local
  ///place and business information, as well as the device's current place.
  static Future<void> initialize({bool showLogs = true}) async {
    _isLogsEnabled = showLogs;
    _methodChannel.invokeMethod(Methods.INITIALIZE).then((_) {
      _log("🚀🚀🚀 places initialized successfully");
    }).catchError((error) {
      _errorLogs("⚠️⚠️⚠️ $error");
    });
  }

  static Future<bool> get isInitialized async {
    try {
      return await _methodChannel.invokeMethod(Methods.IS_INITIALIZE);
    } catch (error) {
      _errorLogs("⚠️⚠️⚠️ $error");
      return false;
    }
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
