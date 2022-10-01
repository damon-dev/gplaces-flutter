package co.codezens.places_autocomplete.models

data class MPlaceLikelihoods(
    val placeLikelihoods: List<MCurrentPlace>
)

data class MCurrentPlace(
    val likelihood: Double?,
    val place: MPlaceDetail?
)
