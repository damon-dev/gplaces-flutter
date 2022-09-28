package co.codezens.places_autocomplete.models

data class MAddressComponents(
    val asList: List<MAddressComponent>?
)

data class MAddressComponent(
    val name: String?,
    val shortName: String?,
    val types: List<String>?
)
