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
        'getPredictions',
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
      final details = await _methodChannel.invokeMethod(
        'getPlaceDetails',
        request.arguments,
      );
      _log(details);
      return FetchPlaceResponse.parseResult(details);
    } catch (error) {
      _log(error);
      return null;
    }
  }

  ///Fetches a photo.
  ///The photos service may cache the image data. If the
  ///requested photo does not exist in the cache then a network
  ///lookup will be performed.
  Future<FetchPhotoResponse?> fetchPhotos({
    required FetchPhotoRequest request,
  }) async {
    try {
      final data = await _methodChannel.invokeMethod(
        'getPlacePhoto',
        request.arguments,
      );
      _log(data);

      return FetchPhotoResponse.parseResult(data);
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
