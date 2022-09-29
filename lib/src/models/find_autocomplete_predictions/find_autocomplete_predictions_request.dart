import 'package:places_autocomplete/src/constants/type_filter.dart';
import 'package:places_autocomplete/src/models/lat_lng.dart';
import 'package:places_autocomplete/src/models/location_bias.dart';

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
  final List<String>? countries;

  ///Sets the filter that restricts the type of the results
  ///included in the response.
  final TypeFilter? typeFilter;

  FindAutocompletePredictionsRequest({
    required this.query,
    this.origin,
    this.locationBias,
    this.countries,
    this.typeFilter,
  });

  Map<String, dynamic> get arguments => <String, dynamic>{
        "query": query,
        "countries": countries,
        "typeFilter": typeFilter?.name,
        "southWestLat": locationBias?.southwest?.latitude,
        "southWestLng": locationBias?.southwest?.longitude,
        "northEastLat": locationBias?.northeast?.latitude,
        "northEastLng": locationBias?.northeast?.longitude,
        "originLat": origin?.latitude,
        "originLng": origin?.longitude,
      };
}
