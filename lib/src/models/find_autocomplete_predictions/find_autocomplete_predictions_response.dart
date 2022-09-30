import 'dart:convert';

import 'autocomplete_prediction.dart';

/// The FindAutocompletePredictionsResponse contains list of [AutocompletePrediction]
class FindAutocompletePredictionsResponse {
  final List<AutocompletePrediction>? autocompletePredictions;

  FindAutocompletePredictionsResponse({this.autocompletePredictions});

  factory FindAutocompletePredictionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return FindAutocompletePredictionsResponse(
      autocompletePredictions: json['predictions']
          ?.map<AutocompletePrediction>(
              (json) => AutocompletePrediction.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic> {
    'autocompletePredictions': autocompletePredictions,
  };

  static FindAutocompletePredictionsResponse parseResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return FindAutocompletePredictionsResponse.fromJson(parsed);
  }
}
