import '../../constants/field.dart';

class FetchPlaceRequest {
  ///[placeId] is the unique ID of this Place.
  ///Place ID data is constantly changing, so it is possible for
  ///subsequent requests using the same ID to fail (for example,
  ///if the place no longer exists in the database). A returned Place
  /// may also have a different ID from the ID specified in the request,
  /// as there may be multiple IDs for a given place.
  final String placeId;

  ///Use the values of [Field] to specify which place data types to return.
  final List<Field>? placeFields;

  FetchPlaceRequest({
    required this.placeId,
    this.placeFields,
  });

  List<String>? get mappedFields {
    return placeFields?.map((e) => e.name).toList();
  }
}
