//
//  Constants.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 27/09/22.
//

import Foundation

struct Channel {
    static let NAME = "gpa_method_channel";
}

struct Methods {
    static let INITIALIZE = "initialize";
    static let IS_INITIALIZED = "isInitialized";
    static let GET_PREDICTIONS = "getPredictions";
    static let GET_PLACE_DETAILS = "getPlaceDetails";
    static let GET_PHOTO_DETAILS = "getPlacePhoto";
}

struct Arguments {
    static let PREDICTIONS_REQUEST = "predictionsRequest"
    static let PLACE_REQUEST = "placeRequest"
    static let PHOTO_REQUEST = "photoRequest"
}
