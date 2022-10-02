package co.codezens.places_autocomplete.models

data class MPredictions(
    val autocompletePredictions: List<MPrediction>?
)

data class MPrediction(
    val placeId: String?,
    val distanceMeters: Int?,
    val description: String?,
    val primaryText: String?,
    val secondaryText: String?,
    val types: List<String>?
)