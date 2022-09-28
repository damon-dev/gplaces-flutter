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
}

class AddressComponent {
  String? name;
  String? shortName;
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
}
