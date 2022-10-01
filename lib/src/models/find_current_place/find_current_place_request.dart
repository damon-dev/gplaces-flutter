import 'package:places_autocomplete/src/constants/field.dart';

class FindCurrentPlaceRequest {
  ///Use the values of [Field] to specify which place data types to return.
  final List<Field> placeFields;

  FindCurrentPlaceRequest({
    required this.placeFields,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "fields": placeFields.map((e) => e.name).toList(),
      };

  Map<String, dynamic> get arguments =>
      <String, dynamic>{"currentPlaceRequest": toJson()};
}
