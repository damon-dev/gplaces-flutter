import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../places_autocomplete.dart';

//A new Flutter package for handle google place api that
//place search and details and photos and autocomplete
//and query autocomplete requests are available
class PlacesAutocomplete {
  PlacesAutocomplete();

  bool _isLogEnabled = true;

  static const MethodChannel _methodChannel =
      MethodChannel('gpa_method_channel');

  Future initializePlaces() async {
    _methodChannel.invokeMethod('initialize').then((_) {
      _log("🚀🚀🚀 places initialized successfully");
    }).catchError((error) {
      _errorLogs("⚠️⚠️⚠️ $error");
    });
  }

  Future<bool> get isInitialized async {
    try {
      return await _methodChannel.invokeMethod('isInitialized');
    } catch (error) {
      _errorLogs("⚠️⚠️⚠️ $error");
      return false;
    }
  }

  Future<PlaceDetailsResponse?> getPlaceDetails({
    required String placeId,
    List<Field>? fields,
  }) async {
    try {
      final details = await _methodChannel.invokeMethod('get_place_details', {
        'placeId': placeId,
        'fields': fields?.map((e) => e.name).toList(),
      });
      _log(details);
      return PlaceDetailsResponse.parseDetailsResult(details);
    } catch (error) {
      _log(error);
      return null;
    }
  }

  Future<PlaceAutocompleteResponse?> getPredictions({
    required String query,
    List<String>? countries,
    TypeFilter? typeFilter,
    Bounds? bounds,
  }) async {
    try {
      final predictions = await _methodChannel.invokeMethod('get_predictions', {
        "query": query,
        "countries": countries,
        "typeFilter": typeFilter?.name,
        "southWestLat": bounds?.southWestBounds.latitude,
        "southWestLng": bounds?.southWestBounds.longitude,
        "northEastLat": bounds?.northEastBounds.latitude,
        "northEastLng": bounds?.northEastBounds.longitude,
      });
      _log(predictions);

      return PlaceAutocompleteResponse.parseAutocompleteResult(predictions);
    } catch (error) {
      _errorLogs(error);
      return null;
    }
  }

  set showLogs(bool toSet) {
    _isLogEnabled = toSet;
  }

  void _log(message) {
    if (!_isLogEnabled) return;
    if (kDebugMode) {
      print(message);
    }
  }

  void _errorLogs(message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
