package co.codezens.places_autocomplete.extensions

import co.codezens.places_autocomplete.Arguments
import co.codezens.places_autocomplete.models.MCurrentPlace
import co.codezens.places_autocomplete.models.MPlaceLikelihoods
import co.codezens.places_autocomplete.models.requests.CurrentPlaceRequest
import co.codezens.places_autocomplete.utils.GsonUtils
import com.google.android.libraries.places.api.net.FindCurrentPlaceRequest
import com.google.android.libraries.places.api.net.FindCurrentPlaceResponse
import io.flutter.plugin.common.MethodCall

fun MethodCall.findCurrentPlaceRequest(): FindCurrentPlaceRequest {
    val mCurrentPlaceRequest = GsonUtils.convertFromJson(
        argument<Map<String, Any?>>(Arguments.CURRENT_PLACE_REQUEST),
        CurrentPlaceRequest::class.java
    )

    return mCurrentPlaceRequest.createRequest()
}

fun FindCurrentPlaceResponse.currentPlaceData(): MPlaceLikelihoods {
    val mPlaceLikelihoods = placeLikelihoods.map {
        MCurrentPlace(
            likelihood = it.likelihood,
            place = it.place.placeDetail()
        )
    }

    return MPlaceLikelihoods(placeLikelihoods = mPlaceLikelihoods)
}