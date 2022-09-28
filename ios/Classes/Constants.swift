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
    static let GET_PREDICTIONS = "get_predictions";
    static let GET_PLACE_DETAILS = "get_place_details";
}

struct Arguments {
    static let FIELDS = "fields";
    static let PLACE_ID = "placeId";
    static let TYPE_FILTER = "typeFiler";
    static let NORTH_EAST_LNG = "northEastLng";
    static let NORTH_EAST_LAT = "northEastLat";
    static let SOUTH_WEST_LNG = "southWestLng";
    static let SOUTH_WEST_LAT = "southWestLat";
    static let COUNTRIES = "countries";
    static let QUERY = "query";
}
