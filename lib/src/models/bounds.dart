import 'package:places_autocomplete/src/models/lat_lng.dart';

class Bounds {
  final LatLng southWestBounds;
  final LatLng northEastBounds;

  Bounds(
    this.southWestBounds,
    this.northEastBounds,
  );
}
