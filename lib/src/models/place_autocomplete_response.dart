import 'dart:convert';

import 'package:places_autocomplete/src/models/place_prediction.dart';

/// The Autocomplete response contains place predictions and status
class PlaceAutocompleteResponse {
  final List<PlacePrediction>? predictions;

  PlaceAutocompleteResponse({this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      predictions: json['predictions']
          ?.map<PlacePrediction>((json) => PlacePrediction.fromJson(json))
          .toList(),
    );
  }

  static PlaceAutocompleteResponse parseAutocompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}
