import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:places_autocomplete/places_autocomplete.dart';

class PlacesClient {
  final MethodChannel _methodChannel;
  final bool showLogs;

  PlacesClient(this._methodChannel, {this.showLogs = true});

  ///Fetches autocomplete predictions.
  ///The [request] specifying the place of interest.
  ///Response containing the place of interest or an
  ///Exception if an error occurred.
  Future<FindAutocompletePredictionsResponse?> findAutoCompletePredictions({
    required FindAutocompletePredictionsRequest request,
  }) async {
    try {
      final predictions = await _methodChannel.invokeMethod(
        'get_predictions',
        request.arguments,
      );
      _log(predictions);

      return FindAutocompletePredictionsResponse.parseResult(predictions);
    } catch (error) {
      _errorLogs(error);
      return null;
    }
  }

  ///Fetches the details of a place.
  ///The [request] specifying the place of interest.
  ///Response containing the place of interest or an Exception
  ///if an error occurred.
  Future<FetchPlaceResponse?> fetchPlace({
    required FetchPlaceRequest request,
  }) async {
    try {
      final details = await _methodChannel.invokeMethod('get_place_details', {
        'placeId': request.placeId,
        'fields': request.mappedFields,
      });
      _log(details);
      return FetchPlaceResponse.parseResult(details);
    } catch (error) {
      _log(error);
      return null;
    }
  }

  void _log(message) {
    if (!showLogs) return;
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
