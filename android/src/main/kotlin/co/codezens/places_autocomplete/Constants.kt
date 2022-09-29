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
    const val GET_PLACE_PHOTO = "get_place_photo"
}

object Arguments {
    const val FIELDS = "fields"
    const val PLACE_ID = "placeId"

    const val PREDICTIONS_REQUEST = "predictionsRequest"
    const val PHOTO_REQUEST = "photoRequest"
}

object Defaults {
    //place details
    val FIELDS: List<Field> = Field.values().asList()
}