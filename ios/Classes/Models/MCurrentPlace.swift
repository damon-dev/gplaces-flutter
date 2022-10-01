//
//  MCurrentPlace.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 02/10/22.
//

import Foundation

struct MCurrentPlace : Encodable {
    let placeLikelihoods: [MPlaceLikelihood]?
}

struct MPlaceLikelihood : Encodable {
    let likelihood: Double?
    let  place: MPlaceDetail?
}
