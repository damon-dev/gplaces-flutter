import 'lat_lng.dart';

class Viewport {
  LatLng? northeast;
  LatLng? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: json["northeast"] == null
          ? null
          : LatLng.fromJson(json["northeast"] as Map<String, dynamic>),
      southwest: json["southwest"] == null
          ? null
          : LatLng.fromJson(json["southwest"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'northeast': northeast,
        'southwest': southwest,
      };
}
