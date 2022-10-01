package co.codezens.places_autocomplete.extensions

import MLocationBias
import co.codezens.places_autocomplete.models.*
import com.google.android.libraries.places.api.model.Place

fun Place.placeDetail(): MPlaceDetail {
    return MPlaceDetail(
        address = address,
        attributions = attributions,
        addressComponents = addressComponents(),
        businessStatus = businessStatus?.name,
        id = id,
        iconUrl = iconUrl,
        isOpen = isOpen,
        iconBackgroundColor = iconBackgroundColor,
        latLng = latLng,
        name = name,
        openingHours = openingHours(),
        phoneNumber = phoneNumber,
        photoMetadatas = photoMetadatas(),
        plusCode = plusCode(),
        priceLevel = priceLevel?.priceLevel(),
        rating = rating,
        types = types?.map { value -> value.name },
        userRatingsTotal = userRatingsTotal,
        utcOffsetMinutes = utcOffsetMinutes,
        viewport = viewport(),
        websiteUri = websiteUri?.toString(),
    )
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

fun Place.viewport(): MLocationBias? {
    return viewport?.let {
        MLocationBias(
            northeast = it.northeast, southwest = it.southwest
        )
    }
}

fun Place.plusCode(): MPlusCode? {
    return plusCode?.let {
        MPlusCode(
            compoundCode = it.compoundCode, globalCode = it.globalCode
        )
    }
}

fun Place.photoMetadatas(): List<MPhotoMetaData>? {
    return photoMetadatas?.map {
        MPhotoMetaData(
            attributions = it.attributions,
            width = it.width,
            height = it.height,
            photoReference = it.zza()
        )
    }
}

fun Place.addressComponents(): MAddressComponents? {
    return addressComponents?.let { components ->
        MAddressComponents(asList = components.asList().map {
            MAddressComponent(
                name = it.name, shortName = it.shortName, types = it.types
            )
        })
    }
}

fun Place.openingHours(): MOpeningHours? {
    return openingHours?.let { openingHours ->
        MOpeningHours(
            periods = openingHours.periods.map {
                MPeriod(
                    open = MTimeOfWeek(
                        day = it?.open?.day?.name,
                        time = MTime(
                            hours = it.open?.time?.hours,
                            minutes = it.open?.time?.minutes
                        )
                    ),
                    close = MTimeOfWeek(
                        day = it?.close?.day?.name,
                        time = MTime(
                            hours = it.close?.time?.hours,
                            minutes = it.close?.time?.minutes
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