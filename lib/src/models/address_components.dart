import 'package:collection/collection.dart';

class AddressComponents {
  List<AddressComponent>? asList;

  AddressComponents({this.asList});

  factory AddressComponents.fromJson(Map<String, dynamic> json) {
    return AddressComponents(
      asList: (json['asList'] as List<dynamic>?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'asList': asList,
      };

  @override
  bool operator ==(o) =>
      o is AddressComponents && const ListEquality().equals(o.asList, asList);

  @override
  int get hashCode => asList.hashCode;
}

class AddressComponent {
  ///Name of the address component, e.g. "Sydney".
  String? name;

  ///Short name of the address component, e.g. "AU".
  String? shortName;

  ///Types of the [AddressComponent].
  List<String>? types;

  AddressComponent({
    this.name,
    this.shortName,
    this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'shortName': shortName,
        'types': types,
      };

  @override
  bool operator ==(o) =>
      o is AddressComponent &&
      o.name == name &&
      o.shortName == shortName &&
      const ListEquality().equals(o.types, types);

  @override
  int get hashCode => name.hashCode ^ types.hashCode ^ shortName.hashCode;
}
