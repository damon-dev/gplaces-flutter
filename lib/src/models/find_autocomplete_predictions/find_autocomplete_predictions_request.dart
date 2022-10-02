import 'package:gplaces/src/constants/type_filter.dart';
import 'package:gplaces/src/models/lat_lng.dart';
import 'package:gplaces/src/models/location_bias.dart';

class FindAutocompletePredictionsRequest {
  ///Sets the user [query] string used to generate autocomplete
  /// predictions. If empty, no predictions will be included
  /// in the response.
  final String query;

  ///Sets the location where AutocompletePrediction distanceMeters
  ///is calculated from. If null, no distances will be included
  ///in the response.
  final LatLng? origin;

  ///Sets the [locationBias] applied for autocomplete predictions.
  ///If null, location biases will not be applied.
  final LocationBias? locationBias;

  ///Sets the list of [countries] that restrict the location of
  ///the results. This must be a list of ISO 3166-1 Alpha-2 country
  ///codes (case insensitive). If empty, country restrictions will
  ///not be applied.
  final List<String> countries;

  ///Sets the filter that restricts the type of the results
  ///included in the response.
  final TypeFilter? typeFilter;

  FindAutocompletePredictionsRequest({
    required this.query,
    this.origin,
    this.locationBias,
    this.countries = const [""],
    this.typeFilter,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "query": query,
        "countries": countries,
        "typeFilter": typeFilter?.name,
        "bounds": locationBias?.toJson(),
        "origin": origin?.toJson(),
      };

  Map<String, dynamic> get arguments =>
      <String, dynamic>{"predictionsRequest": toJson()};
}
