class LatLng {
  double? latitude;
  double? longitude;

  LatLng({
    this.latitude,
    this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      latitude: json["latitude"] as double?,
      longitude: json["longitude"] as double?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
      };
}
