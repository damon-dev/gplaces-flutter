package co.codezens.places_autocomplete

import MViewport
import co.codezens.places_autocomplete.models.*
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.LatLngBounds
import com.google.android.libraries.places.api.model.AutocompleteSessionToken
import com.google.android.libraries.places.api.model.Place.Field
import com.google.android.libraries.places.api.model.RectangularBounds
import com.google.android.libraries.places.api.model.TypeFilter
import com.google.android.libraries.places.api.net.FetchPlaceRequest
import com.google.android.libraries.places.api.net.FetchPlaceResponse
import com.google.android.libraries.places.api.net.FindAutocompletePredictionsRequest
import com.google.android.libraries.places.api.net.FindAutocompletePredictionsResponse
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

fun MethodChannel.Result.failure(msg: String) {
    error("error", msg, null)
}

fun MethodCall.placeDetailsRequest(result: MethodChannel.Result): FetchPlaceRequest? {
    val placeId = argument<String?>(Arguments.PLACE_ID)
    if (placeId == null) {
        result.failure("place id can't be null")
        return null
    }

    val fields = argument<List<String>?>(Arguments.FIELDS)
    return FetchPlaceRequest.builder(placeId, fields.fields()).build()
}

fun FetchPlaceResponse.placeDetails(): MPlaceDetails {
    val placeDetails = place.let {
        MPlaceDetail(
            address = it.address,
            attributions = it.attributions,
            addressComponents = addressComponents(),
            businessStatus = it.businessStatus?.name,
            id = it.id,
            iconUrl = it.iconUrl,
            isOpen = it.isOpen,
            iconBackgroundColor = it.iconBackgroundColor,
            latLng = it.latLng,
            name = it.name,
            openingHours = openingHours(),
            phoneNumber = it.phoneNumber,
            photoMetadatas = photoMetadatas(),
            plusCode = plusCode(),
            priceLevel = it.priceLevel?.priceLevel(),
            rating = it.rating,
            types = it.types?.map { value -> value.name },
            userRatingsTotal = it.userRatingsTotal,
            utcOffsetMinutes = it.utcOffsetMinutes,
            viewport = viewport(),
            websiteUri = it.websiteUri?.toString(),
        )
    }

    return MPlaceDetails(details = placeDetails)
}

fun Int.priceLevel(): String? {
    return when (this) {
        0 -> "FREE"
        1 -> "CHEAP"
        2 -> "MEDIUM"
        3 -> "HIGH"
        4 -> "EXPENSIVE"
        else -> null
    }
}

fun FetchPlaceResponse.viewport(): MViewport? {
    return place.viewport?.let {
        MViewport(
            northeast = it.northeast, southwest = it.southwest
        )
    }
}

fun FetchPlaceResponse.plusCode(): MPlusCode? {
    return place.plusCode?.let {
        MPlusCode(
            compoundCode = it.compoundCode, globalCode = it.globalCode
        )
    }
}

fun FetchPlaceResponse.photoMetadatas(): List<MPhotoMetaData>? {
    return place.photoMetadatas?.map {
        MPhotoMetaData(
            attributions = it.attributions, width = it.width, height = it.height
        )
    }
}

fun FetchPlaceResponse.addressComponents(): MAddressComponents? {
    return place.addressComponents?.let { components ->
        MAddressComponents(asList = components.asList().map {
            MAddressComponent(
                name = it.name, shortName = it.shortName, types = it.types
            )
        })
    }
}

fun FetchPlaceResponse.openingHours(): MOpeningHours? {
    return place.openingHours?.let { openingHours ->
        MOpeningHours(
            periods = openingHours.periods.map {
                MPeriod(
                    open = MTimeOfWeek(
                        day = it?.open?.day?.name, time = MTime(
                            hours = it.open?.time?.hours, minutes = it.open?.time?.minutes
                        )
                    ),
                    close = MTimeOfWeek(
                        day = it?.close?.day?.name, time = MTime(
                            hours = it.close?.time?.hours, minutes = it.close?.time?.minutes
                        )
                    ),
                )
            }, weeklyText = openingHours.weekdayText
        )
    }
}

fun MethodCall.placesAutoCompleteRequest(): FindAutocompletePredictionsRequest {
    val query = argument<String?>(Arguments.QUERY) ?: ""
    val countries = argument<List<String>?>(Arguments.COUNTRIES)

    val southWestLat = argument<Double?>(Arguments.SOUTH_WEST_LAT)
    val southWestLng = argument<Double?>(Arguments.SOUTH_WEST_LNG)
    val northEastLat = argument<Double?>(Arguments.NORTH_EAST_LAT)
    val northEastLng = argument<Double?>(Arguments.NORTH_EAST_LNG)

    val bounds =
        if (southWestLat == null || southWestLng == null || northEastLat == null || northEastLng == null) {
            null
        } else {
            RectangularBounds.newInstance(
                LatLngBounds(
                    LatLng(southWestLat, southWestLng),
                    LatLng(northEastLat, northEastLng),
                )
            )
        }
    val filter = argument<String?>(Arguments.TYPE_FILTER)

    return FindAutocompletePredictionsRequest.builder().apply {
        setQuery(query)
        if (bounds != null) locationBias = bounds
        if (countries != null) setCountries(countries)
        if (filter != null) typeFilter = filter.typeFiler()
        sessionToken = AutocompleteSessionToken.newInstance()
    }.build()
}

fun FindAutocompletePredictionsResponse.predictions(): MPredictions {
    val predictions = autocompletePredictions.map {
        MPrediction(placeId = it.placeId,
            distanceMeters = it.distanceMeters,
            description = it.getFullText(null).toString(),
            primaryText = it.getPrimaryText(null).toString(),
            secondaryText = it.getSecondaryText(null).toString(),
            types = it.placeTypes.map { type -> type.name })
    }

    return MPredictions(predictions = predictions)
}

fun String?.typeFiler(): TypeFilter? {
    return this?.let { TypeFilter.valueOf(it) }
}

fun field(value: String): Field {
    return Field.valueOf(value)
}

fun List<String>?.fields(): List<Field> {
    return this?.map { value -> field(value) }?.toList()?.distinct() ?: Defaults.FIELDS
}

inline fun <R> safeCall(call: () -> R): Result<R> {
    return try {
        Result.success(call())
    } catch (e: Exception) {
        Result.failure(e)
    }
}