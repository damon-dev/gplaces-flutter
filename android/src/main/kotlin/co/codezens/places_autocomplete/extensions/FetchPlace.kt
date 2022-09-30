package co.codezens.places_autocomplete.extensions

import MLocationBias
import co.codezens.places_autocomplete.Arguments
import co.codezens.places_autocomplete.models.*
import co.codezens.places_autocomplete.models.requests.PlaceRequest
import co.codezens.places_autocomplete.utils.GsonUtils
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.api.net.FetchPlaceRequest
import com.google.android.libraries.places.api.net.FetchPlaceResponse
import io.flutter.plugin.common.MethodCall

fun MethodCall.placeDetailsRequest(): FetchPlaceRequest {
    val mPlaceRequest = GsonUtils.convertFromJson(
        argument<Map<String, Any?>>(Arguments.PLACE_REQUEST),
        PlaceRequest::class.java
    )

    return mPlaceRequest.createRequest()
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

fun FetchPlaceResponse.viewport(): MLocationBias? {
    return place.viewport?.let {
        MLocationBias(
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
            attributions = it.attributions,
            width = it.width,
            height = it.height,
            photoReference = it.zza()
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

fun field(value: String): Place.Field {
    return Place.Field.valueOf(value)
}

fun List<String>?.fields(): List<Place.Field> {
    return this?.map { value -> field(value) }?.toList()?.distinct()
        ?: Place.Field.values().asList()
}