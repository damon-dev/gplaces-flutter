//
//  Extensions.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 27/09/22.
//

import Foundation
import GooglePlaces

extension Dictionary<String, Any?> {
    
    func predictionsFilter() -> GMSAutocompleteFilter {
        let countries =  self[Arguments.COUNTRIES] as? [String]
        let type = self[Arguments.TYPE_FILTER] as? String
        
        let southWestLat = self[Arguments.SOUTH_WEST_LAT]  as? Double
        let southWestLng = self[Arguments.SOUTH_WEST_LNG]  as? Double
        let northEastLat = self[Arguments.NORTH_EAST_LAT]  as? Double
        let northEastLng = self[Arguments.NORTH_EAST_LNG]  as? Double
        let bounds =
        southWestLat == nil || southWestLng == nil || northEastLat == nil || northEastLng == nil
        ? nil
        : GMSPlaceRectangularLocationOption(
            CLLocationCoordinate2D(
                latitude: northEastLat!,
                longitude: northEastLng!
            ),
            CLLocationCoordinate2D(
                latitude: southWestLat!,
                longitude: southWestLng!
            )
        )
        
        let originLat = self[Arguments.ORIGIN_LAT] as? Double
        let originLng = self[Arguments.ORIGIN_LNG]  as? Double
        let origin = originLat == nil || originLng == nil
        ? nil
        : CLLocation(
            latitude: originLat!,
            longitude: originLng!
        )
        
        let filter = GMSAutocompleteFilter()
        if(countries != nil) {
            filter.countries = countries
        }
        if(bounds != nil) {
            filter.locationBias = bounds
        }
        if(type != nil) {
            filter.types = type!.typeFiler()
        }
        if(origin  != nil) {
            filter.origin = origin
        }
        
        return filter
    }
    
    func predictionQuery() -> String {
        return self[Arguments.QUERY] as! String
    }
    
    func placeId() -> String {
        return self[Arguments.PLACE_ID] as! String
    }
    
    func placeFields() -> GMSPlaceField {
        let fields = self[Arguments.FIELDS] as? [String]
        
        return fields == nil
        ? GMSPlaceField(arrayLiteral: GMSPlaceField.all)
        : GMSPlaceField(fields!.fields())
    }
}

extension [GMSAutocompletePrediction] {
    func predictions() -> String {
        var mPredictions = [MPrediction]()
        for result in self {
            let mPrediction = MPrediction(
                placeId: result.placeID,
                distanceMeters: result.distanceMeters?.intValue,
                description: result.attributedFullText.string,
                primaryText: result.attributedPrimaryText.string,
                secondaryText: result.attributedSecondaryText?.string,
                types: result.types
            )
            
            mPredictions.append(mPrediction)
        }
        
        let encodedValue = JSONUtils.encode(object: MPredictions(predictions: mPredictions))
        
        return encodedValue == nil ? "[]" : encodedValue!
    }
}

extension [String] {
    func fields() -> [GMSPlaceField] {
        return self.map { value in
            value.gmsField()
        }
    }
}

extension GMSPlacesBusinessStatus {
    var name: String? {
        switch self {
        case GMSPlacesBusinessStatus.operational: return "OPERATIONAL"
        case GMSPlacesBusinessStatus.closedPermanently: return "CLOSED_PERMANENTLY"
        case GMSPlacesBusinessStatus.closedTemporarily: return "CLOSED_TEMPORARILY"
        default: return nil
        }
    }
}

extension GMSPlacesPriceLevel {
    var name: String? {
        switch self {
        case GMSPlacesPriceLevel.cheap: return "CHEAP"
        case GMSPlacesPriceLevel.expensive: return "EXPENSIVE"
        case GMSPlacesPriceLevel.free: return "FREE"
        case GMSPlacesPriceLevel.medium: return "MEDIUM"
        case GMSPlacesPriceLevel.high: return "HIGH"
        default: return nil
        }
    }
}

extension GMSPlaceOpenStatus {
    var status: Bool? {
        switch self {
        case GMSPlaceOpenStatus.open: return true
        case GMSPlaceOpenStatus.closed: return false
        default: return nil
        }
    }
}

extension GMSDayOfWeek {
    var name: String? {
        switch self {
        case GMSDayOfWeek.sunday : return "SUNDAY"
        case GMSDayOfWeek.monday : return "MONDAY"
        case GMSDayOfWeek.tuesday : return "TUESDAY"
        case GMSDayOfWeek.wednesday: return "WEDNESDAY"
        case GMSDayOfWeek.thursday: return "THURSDAY"
        case GMSDayOfWeek.friday: return"FRIDAY"
        case GMSDayOfWeek.saturday: return"SATURDAY"
        default: return nil
        }
    }
}

extension String {
    func typeFiler() -> [String]? {
        switch self {
        case "ADDRESS": return ["address"]
        case "CITIES": return ["locality", "administrative_area_level_3"]
        case "ESTABLISHMENT": return ["establishment"]
        case "GEOCODE": return ["geocode"]
        case "REGIONS": return [
            "locality",
            "sublocality",
            "postal_code",
            "country",
            "administrative_area_level_1",
            "administrative_area_level_2"
        ]
        default : return nil
        }
    }
    
    func gmsField() -> GMSPlaceField {
        switch self {
        case "ADDRESS": return GMSPlaceField.formattedAddress
        case "ADDRESS_COMPONENTS": return GMSPlaceField.addressComponents
        case "BUSINESS_STATUS": return GMSPlaceField.businessStatus
        case "ID": return GMSPlaceField.placeID
        case "LAT_LNG": return GMSPlaceField.coordinate
        case "NAME": return GMSPlaceField.name
        case "OPENING_HOURS": return GMSPlaceField.openingHours
        case "PHONE_NUMBER": return GMSPlaceField.phoneNumber
        case "PHOTO_METADATAS": return GMSPlaceField.photos
        case "PLUS_CODE": return GMSPlaceField.plusCode
        case "PRICE_LEVEL": return GMSPlaceField.priceLevel
        case "RATING": return GMSPlaceField.rating
        case "TYPES": return GMSPlaceField.types
        case "USER_RATINGS_TOTAL": return GMSPlaceField.userRatingsTotal
        case "UTC_OFFSET": return GMSPlaceField.utcOffsetMinutes
        case "VIEWPORT": return GMSPlaceField.viewport
        case "WEBSITE_URI": return GMSPlaceField.website
        default: return GMSPlaceField.name
        }
    }
}

extension NSAttributedString {
    var htmlString : String? {
        let documentAttributes = [
            NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html
        ]
        
        do {
            let htmlData = try self.data(
                from: NSMakeRange(0, self.length),
                documentAttributes:  documentAttributes
            )
            
            if let htmlString = String(data: htmlData, encoding: .utf8) {
                return htmlString
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
