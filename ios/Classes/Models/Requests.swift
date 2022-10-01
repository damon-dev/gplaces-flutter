//
//  Requests.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 30/09/22.
//

import Foundation
import GooglePlaces

//Find autocomplete predictions
struct PredictionsRequest: Decodable {
    let query: String
    let countries: [String]
    let bounds: MLocationBias?
    let origin: MLatLng?
    let typeFilter: String?
    
    var filter : GMSAutocompleteFilter {
        var mBounds: GMSPlaceLocationBias?
        if let rBounds = bounds {
            mBounds = GMSPlaceRectangularLocationOption(
                CLLocationCoordinate2D(
                    latitude: rBounds.northeast.latitude,
                    longitude: rBounds.northeast.longitude
                ),
                CLLocationCoordinate2D(
                    latitude: rBounds.southwest.latitude,
                    longitude: rBounds.southwest.longitude
                )
            )
        }
        
        var mOrigin: CLLocation?
        if let rOrigin = origin {
            mOrigin = CLLocation(
                latitude: rOrigin.latitude,
                longitude: rOrigin.longitude
            )
        }
        
        let filter = GMSAutocompleteFilter()
        filter.countries = countries
        filter.types = typeFilter?.typeFiler()
        filter.locationBias = mBounds
        filter.origin = mOrigin
        
        return filter
    }
}

//fetch place
struct PlaceRequest: Decodable {
    let placeId: String
    let fields: [String]?
    
    var gmsPlaceField : GMSPlaceField {
        return fields == nil
        ? GMSPlaceField(arrayLiteral: GMSPlaceField.all)
        : GMSPlaceField(fields!.fields())
    }
}

//fetch place photo
struct PhotoRequest: Decodable {
    let photoMetaData: MPhotoMetaData
    let maxWidth: Int?
    let maxHeight: Int?
    
    func metadata(_ data: [GMSPlacePhotoMetadata]?) -> GMSPlacePhotoMetadata? {
        if(data == nil || data!.isEmpty) {
            return nil
        }
        
        return data!.first { value in
           return value.attributions?.htmlString == photoMetaData.attributions
        }
    }
    
    var constraints : CGSize {
        return CGSize(
            width: maxWidth ?? photoMetaData.width,
            height: maxHeight ?? photoMetaData.height
        )
    }
}

//current place
struct CurrentPlaceRequest: Decodable {
    let fields: [String]
    
    var gmsPlaceField : GMSPlaceField {
        return GMSPlaceField(fields.fields())
    }
}
