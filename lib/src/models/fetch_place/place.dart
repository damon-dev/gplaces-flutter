import 'package:places_autocomplete/src/models/lat_lng.dart';
import 'package:places_autocomplete/src/models/location_bias.dart';
import 'package:places_autocomplete/src/models/photo_metadatas.dart';
import 'package:places_autocomplete/src/models/plus_code.dart';

import '../address_components.dart';
import '../opening_hours.dart';

class Place {
  ///Returns a human-readable address for this Place.
  ///May return null if the address is unknown.
  final String? address;

  ///Returns the attributions that must be shown to the user,
  ///if data from the Place is used.
  final List<String>? attributions;

  ///Returns the address components for this Place's location.
  ///The attributions in HTML format,
  ///or null if there are no attributions to display.
  final AddressComponents? addressComponents;

  ///Returns the BusinessStatus for this Place.
  ///CLOSED_PERMANENTLY, CLOSED_TEMPORARILY, OPERATIONAL
  final String? businessStatus;

  ///[id] is the unique ID of this Place.
  ///Place ID data is constantly changing, so it is possible for
  ///subsequent requests using the same ID to fail (for example,
  ///if the place no longer exists in the database). A returned Place
  /// may also have a different ID from the ID specified in the request,
  /// as there may be multiple IDs for a given place.
  final String? id;

  ///Returns the icon PNG URL string to the Places's type.
  ///Returns null if not available.
  ///The URL link does not expire and the image size aspect ratio
  ///may be different depending on type.
  final String? iconUrl;

  ///Calculates if the place is open at the device's current time.
  final bool? isOpen;

  ///Returns the @ColorInt of the icon background color.
  ///Returns null if not available.
  ///The background color is according to the Place's type.
  ///It can be used to color the view behind the icon.
  final int? iconBackgroundColor;

  ///Returns the location of this Place.
  ///The location is not necessarily the center of the Place, or
  ///any particular entry or exit point, but some arbitrarily chosen
  ///point within the geographic extent of the Place.
  final LatLng? latLng;

  ///Returns the name of this Place.
  final String? name;

  ///Returns the [OpeningHours] of this Place.
  final OpeningHours? openingHours;

  ///Returns the place's phone number in international format.
  ///Returns null if no phone number is known, or the place has no phone number.
  ///International format includes the country code, and is prefixed
  ///with the plus (+) sign. For example, the international phone number
  ///for Google's Mountain View, USA office is +1 650-253-0000.
  final String? phoneNumber;

  ///Returns the metadata for a photo associated with a place.
  ///Photos are sourced from a variety of locations, including
  ///business owners and photos contributed by Google+ users.
  ///In most cases, these photos can be used without attribution,
  ///or will have the required attribution included as a part of the image.
  ///However, you must call PhotoMetadata.getAttributions() to retrieve any
  ///additional attributions required, and display those attributions in your
  ///application wherever you display the image.
  final List<Metadata>? photoMetadatas;

  ///Returns the PlusCode location of this Place.
  ///The location is not necessarily the center of the Place,
  ///or any particular entry or exit point, but some arbitrarily
  ///chosen point within the geographic extent of the Place.
  final PlusCode? plusCode;

  ///Returns the price level for this place on a scale from
  ///PRICE_LEVEL_MIN_VALUE to PRICE_LEVEL_MAX_VALUE.
  ///If no price level is known, null is returned.
  ///The exact amount indicated by a specific value will vary from
  ///region to region, though a value of PRICE_LEVEL_MIN_VALUE always
  /// denotes that this place is free.
  /// 0 -> "FREE"
  /// 1 -> "CHEAP"
  /// 2 -> "MEDIUM"
  /// 3 -> "HIGH"
  /// 4 -> "EXPENSIVE"
  final String? priceLevel;

  ///Returns the place's rating, from RATING_MIN_VALUE(1.0) to RATING_MAX_VALUE(5.0),
  ///based on aggregated user reviews.
  final double? rating;

  ///Returns a list of place types for this Place.
  ///The elements of this list are drawn from
  ///[https://developers.google.com/maps/documentation/places/android-sdk/reference/com/google/android/libraries/places/api/model/Place.Type]
  ///constants, though one should expect there could be new place types returned
  ///that were introduced after an app was published
  final List<String>? types;

  ///Returns the total number of user ratings of this Place.
  ///Returns null if the number of user ratings is not known.
  final int? userRatingsTotal;

  ///Returns the number of minutes this place’s current timezone is
  ///offset from UTC.
  final int? utcOffsetMinutes;

  ///Returns a viewport for displaying this Place. May return null
  ///if the size of the place is not known.
  ///This returns a viewport of a size that is suitable for displaying
  ///this Place. For example, a Place representing a store may have a
  ///relatively small viewport, while a Place representing a country may
  ///have a very large viewport.
  final LocationBias? viewport;

  ///Returns the URI of the website of this Place. Returns null
  ///if no website is known. This is the URI of the website maintained
  ///by the Place, if available. This link is always for a third-party
  ///website not affiliated with the Places API.
  final String? websiteUri;

  Place({
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

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
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
          : LocationBias.fromJson(json['viewport'] as Map<String, dynamic>),
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

  @override
  bool operator ==(other) =>
      other is Place &&
      other.address == address &&
      other.addressComponents == addressComponents &&
      other.attributions == attributions &&
      other.businessStatus == businessStatus &&
      other.id == id &&
      other.iconUrl == other.iconUrl &&
      other.isOpen == isOpen &&
      other.iconBackgroundColor == iconBackgroundColor &&
      other.latLng == latLng &&
      other.name == name &&
      other.openingHours == openingHours &&
      other.photoMetadatas == photoMetadatas &&
      other.phoneNumber == phoneNumber &&
      other.plusCode == plusCode &&
      other.priceLevel == priceLevel &&
      other.rating == rating &&
      other.types == types &&
      other.utcOffsetMinutes == utcOffsetMinutes &&
      other.userRatingsTotal == userRatingsTotal &&
      other.viewport == viewport &&
      other.websiteUri == websiteUri;

  @override
  int get hashCode =>
      address.hashCode ^
      addressComponents.hashCode ^
      attributions.hashCode ^
      businessStatus.hashCode ^
      id.hashCode ^
      isOpen.hashCode ^
      iconUrl.hashCode ^
      iconBackgroundColor.hashCode ^
      latLng.hashCode ^
      name.hashCode ^
      openingHours.hashCode ^
      priceLevel.hashCode ^
      plusCode.hashCode ^
      phoneNumber.hashCode ^
      photoMetadatas.hashCode ^
      rating.hashCode ^
      types.hashCode ^
      userRatingsTotal.hashCode ^
      utcOffsetMinutes.hashCode ^
      viewport.hashCode ^
      websiteUri.hashCode;
}
