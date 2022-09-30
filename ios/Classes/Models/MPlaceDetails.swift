//
//  MPlaceDetails.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 28/09/22.
//

import Foundation

struct MPlaceDetails: Encodable {
    let details: MPlaceDetail?
}

struct MPlaceDetail: Encodable {
    let address: String?
    let attributions: [String]?
    let addressComponents: MAddressComponents?
    let businessStatus: String?
    let id: String?
    let iconUrl: String?
    let isOpen: Bool?
    let iconBackgroundColor: Int?
    let latLng: MLatLng?
    let name: String?
    let openingHours: MOpeningHours?
    let phoneNumber: String?
    let photoMetadatas: [MPhotoMetaData]?
    let plusCode: MPlusCode?
    let priceLevel: String?
    let rating: Float?
    let types: [String]?
    let userRatingsTotal: UInt?
    let utcOffsetMinutes: Int?
    let viewport: MLocationBias?
    let websiteUri: String?
}

struct MAddressComponents: Encodable {
    let asList: [MAddressComponent]?
}

struct MAddressComponent: Encodable {
    let name: String?
    let shortName: String?
    let types: [String]?
}

struct MOpeningHours: Encodable {
    let periods: [MPeriod]?
    let weeklyText: [String]?
}

struct MPeriod: Encodable {
    let open: MTimeOfWeek?
    let close: MTimeOfWeek?
}

struct MTimeOfWeek: Encodable {
    let day: String?
    let time: MTime?
}

struct MTime: Encodable {
    let hours: UInt?
    let minutes: UInt?
}

struct MPhotoMetaData: Codable {
    let attributions: String?
    let height: Int
    let width: Int
}

struct MPlusCode: Encodable {
    let compoundCode: String?
    let globalCode: String?
}

struct MLocationBias: Codable {
    let northeast: MLatLng
    let southwest: MLatLng
}

struct MLatLng: Codable {
    let latitude: Double
    let longitude: Double
}
