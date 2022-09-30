package co.codezens.places_autocomplete.extensions

import co.codezens.places_autocomplete.Arguments
import co.codezens.places_autocomplete.models.MPrediction
import co.codezens.places_autocomplete.models.MPredictions
import co.codezens.places_autocomplete.models.requests.PredictionsRequest
import co.codezens.places_autocomplete.utils.GsonUtils
import com.google.android.libraries.places.api.model.TypeFilter
import com.google.android.libraries.places.api.net.FindAutocompletePredictionsRequest
import com.google.android.libraries.places.api.net.FindAutocompletePredictionsResponse
import io.flutter.plugin.common.MethodCall

fun MethodCall.placesAutoCompleteRequest(): FindAutocompletePredictionsRequest {
    val mPredictionsRequest = GsonUtils.convertFromJson(
        argument<Map<String, Any?>>(Arguments.PREDICTIONS_REQUEST),
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

fun String?.typeFiler(): TypeFilter? {
    return this?.let { TypeFilter.valueOf(it) }
}