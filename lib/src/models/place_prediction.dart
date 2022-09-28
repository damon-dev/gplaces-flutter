class PlacePrediction {
  /// [description] contains the human-readable name for the returned result. For establishment results, this is usually
  /// the business name.
  final String? description;
  final String? primaryDescription;
  final String? secondaryDescription;

  /// [distanceMeters] contains an integer indicating the straight-line distance between the predicted place,
  /// and the specified origin point, in meters. This field is only returned when the origin point is specified in the request.
  /// This field is not returned in predictions of type route.
  final int? distanceMeters;

  /// [placeId] is a textual identifier that uniquely identifies a place. To retrieve information about the place,
  /// pass this identifier in the placeId field of a Places API request. For more information about place IDs.
  final String? placeId;

  /// [types] contains an array of types that apply to this place. For example: [ "political", "locality" ] or
  /// [ "establishment", "geocode", "beauty_salon" ]. The array can contain multiple values.
  final List<String>? types;

  PlacePrediction({
    this.placeId,
    this.description,
    this.primaryDescription,
    this.secondaryDescription,
    this.distanceMeters,
    this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      description: json['description'] as String?,
      primaryDescription: json['primaryText'] as String?,
      secondaryDescription: json['secondaryText'] as String?,
      distanceMeters: json['distanceMeters'] as int?,
      placeId: json['placeId'] as String?,
      types: json['types'] != null
          ? (json['types'] as List<dynamic>).cast<String>()
          : null,
    );
  }
}
