package co.codezens.places_autocomplete.extensions

import co.codezens.places_autocomplete.Arguments
import co.codezens.places_autocomplete.models.MPlaceDetails
import co.codezens.places_autocomplete.models.requests.PlaceRequest
import co.codezens.places_autocomplete.utils.GsonUtils
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
    return MPlaceDetails(details = place.placeDetail())
}