import 'package:gplaces/src/models/fetch_place/place.dart';

class PlaceLikelihood {
  ///Returns a value indicating the degree of confidence that
  ///the device is at the corresponding Place from LIKELIHOOD_MIN_VALUE (0.0)
  ///to LIKELIHOOD_MAX_VALUE (1.0) (inclusive).
  final double? likelihood;

  ///Returns the [Place] associated with this PlaceLikelihood.
  final Place? place;

  PlaceLikelihood({this.likelihood, this.place});

  factory PlaceLikelihood.fromJson(Map<String, dynamic> json) {
    return PlaceLikelihood(
      likelihood: json['likelihood'] as double?,
      place: json['place'] == null ? null : Place.fromJson(json['place']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'likelihood': likelihood,
        'place': place,
      };

  @override
  bool operator ==(other) =>
      other is PlaceLikelihood &&
      other.place == place &&
      other.likelihood == likelihood;

  @override
  int get hashCode => place.hashCode ^ likelihood.hashCode;
}
