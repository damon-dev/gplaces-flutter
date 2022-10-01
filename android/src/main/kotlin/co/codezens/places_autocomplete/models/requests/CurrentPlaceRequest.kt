package co.codezens.places_autocomplete.models.requests

import co.codezens.places_autocomplete.extensions.fields
import com.google.android.libraries.places.api.net.FindCurrentPlaceRequest

data class CurrentPlaceRequest(
    val fields: List<String>?
) {
    fun createRequest(): FindCurrentPlaceRequest {
        return FindCurrentPlaceRequest.builder(fields.fields()).build()
    }
}