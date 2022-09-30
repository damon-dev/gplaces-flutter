package co.codezens.places_autocomplete

object Channel {
    const val NAME = "gpa_method_channel"
}

object Methods {
    const val INITIALIZE = "initialize"
    const val IS_INITIALIZED = "isInitialized"
    const val GET_PREDICTIONS = "getPredictions"
    const val GET_PLACE_DETAILS = "getPlaceDetails"
    const val GET_PLACE_PHOTO = "getPlacePhoto"
}

object Arguments {
    const val PREDICTIONS_REQUEST = "predictionsRequest"
    const val PLACE_REQUEST = "placeRequest"
    const val PHOTO_REQUEST = "photoRequest"
}