package co.codezens.places_autocomplete.models

import MLocationBias
import com.google.android.gms.maps.model.LatLng

data class MPlaceDetails(
    val details: MPlaceDetail?
)

data class MPlaceDetail(
    val address: String?,
    val attributions: List<String>?,
    val addressComponents: MAddressComponents?,
    val businessStatus: String?,
    val id: String?,
    val iconUrl: String?,
    val isOpen: Boolean?,
    val iconBackgroundColor: Int?,
    val latLng: LatLng?,
    val name: String?,
    val openingHours: MOpeningHours?,
    val phoneNumber: String?,
    val photoMetadatas: List<MPhotoMetaData>?,
    val plusCode: MPlusCode?,
    val priceLevel: String?,
    val rating: Double?,
    val types: List<String>?,
    val userRatingsTotal: Int?,
    val utcOffsetMinutes: Int?,
    val viewport: MLocationBias?,
    val websiteUri: String?,
)