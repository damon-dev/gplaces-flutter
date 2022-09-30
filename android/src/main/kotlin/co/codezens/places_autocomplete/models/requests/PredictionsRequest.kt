package co.codezens.places_autocomplete.models.requests

import MLocationBias
import co.codezens.places_autocomplete.extensions.typeFiler
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.LatLngBounds
import com.google.android.libraries.places.api.model.AutocompleteSessionToken
import com.google.android.libraries.places.api.model.RectangularBounds
import com.google.android.libraries.places.api.net.FindAutocompletePredictionsRequest

data class PredictionsRequest(
    val query: String,
    val countries: List<String>,
    val bounds: MLocationBias?,
    val origin: LatLng?,
    val typeFilter: String?,
) {
    fun createRequest(): FindAutocompletePredictionsRequest {
        val mBounds = bounds?.let {
            RectangularBounds.newInstance(
                LatLngBounds(
                    LatLng(it.southwest.latitude, it.southwest.longitude),
                    LatLng(it.northeast.latitude, it.northeast.longitude),
                )
            )
        }
        val filter = typeFilter.typeFiler()

        return FindAutocompletePredictionsRequest.builder()
            .setQuery(query)
            .setCountries(countries)
            .setOrigin(origin)
            .setLocationBias(mBounds)
            .setTypeFilter(filter)
            .setSessionToken(AutocompleteSessionToken.newInstance())
            .build()
    }
}