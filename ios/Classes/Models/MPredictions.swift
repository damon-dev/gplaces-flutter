//
//  MPredictions.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 27/09/22.
//

import Foundation

struct MPredictions: Encodable {
    let autocompletePredictions: [MPrediction]?
}

struct MPrediction: Encodable {
    let placeId: String?
    let distanceMeters: Int?
    let description: String?
    let primaryText: String?
    let secondaryText: String?
    let types: [String]?
}
