import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gplaces/src/models/fetch_photo/fetch_photo_request.dart';
import 'package:gplaces/src/models/fetch_photo/fetch_photo_response.dart';
import 'package:gplaces/src/models/fetch_place/fetch_place_request.dart';
import 'package:gplaces/src/models/fetch_place/fetch_place_response.dart';
import 'package:gplaces/src/models/find_autocomplete_predictions/find_autocomplete_predictions_request.dart';
import 'package:gplaces/src/models/find_autocomplete_predictions/find_autocomplete_predictions_response.dart';
import 'package:gplaces/src/models/find_current_place/find_current_place_request.dart';
import 'package:gplaces/src/models/find_current_place/find_current_place_response.dart';

import 'constants/plugin.dart';

///Client that exposes the Places API methods.
///To get a PlacesClient, use Places.createClient().
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
        Methods.FIND_AUTO_COMPLETE_PREDICTIONS,
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
        Methods.FETCH_PLACE,
        request.arguments,
      );
      _log(details);

      return FetchPlaceResponse.parseResult(details);
    } catch (error) {
      _log(error);
      return null;
    }
  }

  ///Fetches the photo of a place.
  ///The photos service may cache the image data. If the
  ///requested photo does not exist in the cache then a network
  ///lookup will be performed.
  Future<FetchPhotoResponse?> fetchPhoto({
    required FetchPhotoRequest request,
  }) async {
    try {
      final data = await _methodChannel.invokeMethod(
        Methods.FETCH_PHOTO,
        request.arguments,
      );
      _log(data);

      return FetchPhotoResponse.parseResult(data);
    } catch (error) {
      _log(error);
      return null;
    }
  }

  ///Fetches the approximate current location of the user's device.
  ///The device must have Location Services enabled, and the app
  /// must have the following permissions granted.
  ///ACCESS_FINE_LOCATION && ACCESS_WIFI_STATE.
  ///Calling this method without granting this permission will
  ///result in a SecurityException being thrown.
  ///This API assumes Fused Location Provider is available on
  ///the device, in order to retrieve it's current location.
  ///
  ///Note : IMPORTANT! findCurrentPlace: does not support the following fields:
  ///[Field.ADDRESS_COMPONENTS], [Field.OPENING_HOURS],
  ///[Field.PHONE_NUMBER], [Field.UTC_OFFSET] and [Field.WEBSITE_URI]].
  Future<FindCurrentPlaceResponse?> findCurrentPlace({
    required FindCurrentPlaceRequest request,
  }) async {
    try {
      final data = await _methodChannel.invokeMethod(
        Methods.FIND_CURRENT_PLACE,
        request.arguments,
      );
      _log(data);

      return FindCurrentPlaceResponse.parseResult(data);
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
