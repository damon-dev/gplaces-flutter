import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:places_autocomplete/places_autocomplete.dart';

import 'autocomplete_prediction.dart';

/// The FindAutocompletePredictionsResponse contains list of [AutocompletePrediction]
class FindAutocompletePredictionsResponse {
  final List<AutocompletePrediction>? autocompletePredictions;

  FindAutocompletePredictionsResponse({this.autocompletePredictions});

  factory FindAutocompletePredictionsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return FindAutocompletePredictionsResponse(
      autocompletePredictions: json['autocompletePredictions']
          ?.map<AutocompletePrediction>(
              (json) => AutocompletePrediction.fromJson(json))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'autocompletePredictions': autocompletePredictions,
      };

  static FindAutocompletePredictionsResponse parseResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return FindAutocompletePredictionsResponse.fromJson(parsed);
  }

  @override
  bool operator ==(o) =>
      o is FindAutocompletePredictionsResponse &&
      const ListEquality()
          .equals(o.autocompletePredictions, autocompletePredictions);

  @override
  int get hashCode => autocompletePredictions.hashCode;
}
