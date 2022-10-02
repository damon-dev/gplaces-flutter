class LatLng {
  double latitude;
  double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  bool operator ==(other) =>
      other is LatLng && other.latitude == latitude && other.longitude == longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
