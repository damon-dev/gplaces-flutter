import 'package:gplaces/src/models/lat_lng.dart';

///[LocationBias] will favor results within the specified geographical bounds.
class LocationBias {
  ///Northeast corner of the bound.
  LatLng? northeast;

  ///Southwest corner of the bound.
  LatLng? southwest;

  LocationBias({
    this.southwest,
    this.northeast,
  });

  factory LocationBias.fromJson(Map<String, dynamic> json) {
    return LocationBias(
      northeast: json["northeast"] == null
          ? null
          : LatLng.fromJson(json["northeast"] as Map<String, dynamic>),
      southwest: json["southwest"] == null
          ? null
          : LatLng.fromJson(json["southwest"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'northeast': northeast?.toJson(),
        'southwest': southwest?.toJson(),
      };

  @override
  bool operator ==(other) =>
      other is LocationBias && other.northeast == northeast && other.southwest == southwest;

  @override
  int get hashCode => southwest.hashCode ^ northeast.hashCode;
}
