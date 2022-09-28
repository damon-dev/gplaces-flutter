package co.codezens.places_autocomplete

import com.google.android.libraries.places.api.model.Place.Field

object Channel {
    const val NAME = "gpa_method_channel"
}

object Methods {
    const val INITIALIZE = "initialize"
    const val IS_INITIALIZED = "isInitialized"
    const val GET_PREDICTIONS = "get_predictions"
    const val GET_PLACE_DETAILS = "get_place_details"
}

object Arguments {
    const val FIELDS = "fields"
    const val PLACE_ID = "placeId"
    const val TYPE_FILTER = "typeFiler"
    const val NORTH_EAST_LNG = "northEastLng"
    const val NORTH_EAST_LAT = "northEastLat"
    const val SOUTH_WEST_LNG = "southWestLng"
    const val SOUTH_WEST_LAT = "southWestLat"
    const val COUNTRIES = "countries"
    const val QUERY = "query"
}

object Defaults {
    //place details
    val FIELDS: List<Field> = Field.values().asList()
}