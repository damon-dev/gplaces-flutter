import 'dart:convert';

import 'package:places_autocomplete/src/models/find_current_place/place_likelihood.dart';

class FindCurrentPlaceResponse {
  final List<PlaceLikelihood>? placeLikelihoods;

  FindCurrentPlaceResponse({this.placeLikelihoods});

  factory FindCurrentPlaceResponse.fromJson(Map<String, dynamic> json) {
    return FindCurrentPlaceResponse(
      placeLikelihoods: json['placeLikelihoods']
          ?.map<PlaceLikelihood>((json) => PlaceLikelihood.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'placeLikelihoods': placeLikelihoods,
      };

  static FindCurrentPlaceResponse parseResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return FindCurrentPlaceResponse.fromJson(parsed);
  }
}
