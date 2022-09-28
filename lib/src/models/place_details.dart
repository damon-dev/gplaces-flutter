import 'package:places_autocomplete/src/models/lat_lng.dart';
import 'package:places_autocomplete/src/models/photo_metadatas.dart';
import 'package:places_autocomplete/src/models/plus_code.dart';
import 'package:places_autocomplete/src/models/viewport.dart';

import 'address_components.dart';
import 'opening_hours.dart';

class PlaceDetails {
  final String? address;
  final List<String>? attributions;
  final AddressComponents? addressComponents;
  final String? businessStatus;
  final String? id;
  final String? iconUrl;
  final bool? isOpen;
  final int? iconBackgroundColor;
  final LatLng? latLng;
  final String? name;
  final OpeningHours? openingHours;
  final String? phoneNumber;
  final List<Metadata>? photoMetadatas;
  final PlusCode? plusCode;
  final String? priceLevel;
  final double? rating;
  final List<String>? types;
  final int? userRatingsTotal;
  final int? utcOffsetMinutes;
  final Viewport? viewport;
  final String? websiteUri;

  PlaceDetails({
    this.address,
    this.attributions,
    this.addressComponents,
    this.businessStatus,
    this.id,
    this.iconUrl,
    this.isOpen,
    this.iconBackgroundColor,
    this.latLng,
    this.name,
    this.openingHours,
    this.phoneNumber,
    this.photoMetadatas,
    this.plusCode,
    this.priceLevel,
    this.rating,
    this.types,
    this.userRatingsTotal,
    this.utcOffsetMinutes,
    this.viewport,
    this.websiteUri,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      address: json['address'] as String?,
      attributions: (json['attributions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      addressComponents: json['addressComponents'] == null
          ? null
          : AddressComponents.fromJson(
              json['addressComponents'] as Map<String, dynamic>,
            ),
      businessStatus: json['businessStatus'] as String?,
      id: json['id'] as String?,
      iconBackgroundColor: json['iconBackgroundColor'] as int?,
      iconUrl: json['iconUrl'] as String?,
      isOpen: json['isOpen'] as bool?,
      latLng: json['latLng'] == null
          ? null
          : LatLng.fromJson(json['latLng'] as Map<String, dynamic>),
      name: json['name'] as String?,
      openingHours: json['openingHours'] == null
          ? null
          : OpeningHours.fromJson(json['openingHours'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      photoMetadatas: (json['photoMetadatas'] as List<dynamic>?)
          ?.map((e) => Metadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      plusCode: json['plusCode'] == null
          ? null
          : PlusCode.fromJson(json['plusCode'] as Map<String, dynamic>),
      priceLevel: json['priceLevel'] as String?,
      rating: json['rating'] as double?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => (e as String).toUpperCase())
          .toList(),
      userRatingsTotal: json['userRatingsTotal'] as int?,
      utcOffsetMinutes: json['utcOffsetMinutes'] as int?,
      viewport: json['viewport'] == null
          ? null
          : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
      websiteUri: json['websiteUri'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'attributions': attributions,
        'addressComponents': addressComponents,
        'businessStatus': businessStatus,
        'id': id,
        'iconUrl': iconUrl,
        'isOpen': isOpen,
        'iconBackgroundColor': iconBackgroundColor,
        'latLng': latLng,
        'name': name,
        'openingHours': openingHours,
        'phoneNumber': phoneNumber,
        'photoMetadatas': photoMetadatas,
        'plusCode': plusCode,
        'priceLevel': priceLevel,
        'rating': rating,
        'types': types,
        'userRatingsTotal': userRatingsTotal,
        'utcOffsetMinutes': utcOffsetMinutes,
        'viewport': viewport,
        'websiteUri': websiteUri,
      };
}
