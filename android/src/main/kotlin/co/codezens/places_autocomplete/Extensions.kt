package co.codezens.places_autocomplete

import MLocationBias
import android.graphics.Bitmap
import co.codezens.places_autocomplete.models.*
import co.codezens.places_autocomplete.models.requests.PhotoRequest
import co.codezens.places_autocomplete.models.requests.PredictionsRequest
import com.google.android.libraries.places.api.model.Place.Field
import com.google.android.libraries.places.api.model.TypeFilter
import com.google.android.libraries.places.api.net.*
import com.google.gson.Gson
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

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

fun MethodCall.placesAutoCompleteRequest(): FindAutocompletePredictionsRequest {
    val gson = Gson()
    val mPredictionsRequest = gson.fromJson(
        gson.toJson(argument<Map<String, Any?>>(Arguments.PREDICTIONS_REQUEST)),
        PredictionsRequest::class.java
    )

    return mPredictionsRequest.createRequest()
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

fun MethodCall.createPhotoRequest(): FetchPhotoRequest {
    val gson = Gson()
    val data = argument<Map<String, Any?>>(Arguments.PHOTO_REQUEST)
    val mPhotoRequest = gson.fromJson(
        gson.toJson(data), PhotoRequest::class.java
    )

    return mPhotoRequest.createRequest()
}

fun FetchPhotoResponse.photoData(): MPlacePhoto {
    return bitmap.let {
        val stream = ByteArrayOutputStream()
        it.compress(Bitmap.CompressFormat.PNG, 100, stream)
        val bytes = stream.toByteArray()
        bitmap.recycle()
        MPlacePhoto(imageBytes = bytes)
    }
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