package co.codezens.places_autocomplete.models.requests

import co.codezens.places_autocomplete.extensions.fields
import com.google.android.libraries.places.api.net.FetchPlaceRequest

data class PlaceRequest(
    val placeId: String,
    val fields: List<String>?
) {
    fun createRequest(): FetchPlaceRequest {
        return FetchPlaceRequest.builder(
            placeId,
            fields.fields()
        ).build()
    }
}