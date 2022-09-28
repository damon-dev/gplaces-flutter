import 'dart:convert';

import 'package:places_autocomplete/places_autocomplete.dart';
import 'package:places_autocomplete/src/models/place_details.dart';

/// The response contains place details
class PlaceDetailsResponse {
  final PlaceDetails? details;

  PlaceDetailsResponse({this.details});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsResponse(
      details: json['details'] == null
          ? null
          : PlaceDetails.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'details': details,
      };

  static PlaceDetailsResponse parseDetailsResult(
    String responseBody,
  ) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceDetailsResponse.fromJson(parsed);
  }
}
