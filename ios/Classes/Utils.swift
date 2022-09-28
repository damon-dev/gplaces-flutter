//
//  Utils.swift
//  places_autocomplete
//
//  Created by Diwakar Singh on 28/09/22.
//

import Foundation
import GooglePlaces

struct JSONUtils {
    static func encode<T: Encodable>(object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(object) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}

struct PlaceDetailsUtils {
    static func placeDetails(_ toSet: GMSPlace) -> String? {
        let details = MPlaceDetail(
            address: toSet.formattedAddress,
            attributions: mAttributions(toSet),
            addressComponents: mAddressComponents(toSet),
            businessStatus: toSet.businessStatus.name,
            id: toSet.placeID,
            iconUrl: nil,
            isOpen: toSet.isOpen().status,
            iconBackgroundColor: nil,
            latLng: mLatLng(toSet),
            name: toSet.name,
            openingHours: mOpeningHours(toSet),
            phoneNumber: toSet.phoneNumber,
            photoMetadatas: photoMetaData(toSet),
            plusCode: plusCode(toSet),
            priceLevel: toSet.priceLevel.name,
            rating: toSet.rating == 0 ? nil : toSet.rating,
            types: toSet.types,
            userRatingsTotal: toSet.userRatingsTotal == 0 ? nil : toSet.userRatingsTotal,
            utcOffsetMinutes: toSet.utcOffsetMinutes?.intValue,
            viewport: viewPort(toSet),
            websiteUri: toSet.website?.absoluteString
        )
        
        return JSONUtils.encode(object: MPlaceDetails(details: details))
    }
    
    static private func viewPort(_ toSet: GMSPlace) -> MViewport? {
        let data = toSet.viewportInfo
        
        return data == nil
        ? nil
        : MViewport(
            northeast: MLatLng(
                latitude: data!.northEast.latitude,
                longitude: data!.northEast.longitude
            ),
            southwest: MLatLng(
                latitude: data!.southWest.latitude,
                longitude: data!.southWest.longitude
            )
        )
    }
    
    static private func plusCode(_ toSet: GMSPlace) -> MPlusCode? {
        let data = toSet.plusCode
        
        return data == nil
        ? nil
        : MPlusCode(
            compoundCode: data!.compoundCode,
            globalCode: data!.globalCode
        )
    }
    
    static private func photoMetaData(_ toSet: GMSPlace) -> [MPhotoMetaData]? {
        return toSet.photos?.map({ data in
            return MPhotoMetaData(
                attributions: data.attributions?.htmlString,
                height: Int(data.maxSize.height),
                width: Int(data.maxSize.width)
            )
        })
    }
    
    static private func mOpeningHours(_ toSet: GMSPlace) -> MOpeningHours? {
        let data: GMSOpeningHours? = toSet.openingHours
        if let data {
            let periods: [GMSPeriod]? = data.periods
            
            return MOpeningHours(
                periods: mPeriods(periods),
                weeklyText: data.weekdayText
            )
        } else {
            return nil
        }
    }
    
    static private func mPeriods(_ toSet: [GMSPeriod]?) -> [MPeriod]? {
        if let toSet {
           return toSet.map({ period in
                MPeriod(
                    open: MTimeOfWeek(
                        day: period.openEvent.day.name,
                        time: MTime(
                            hours: period.openEvent.time.hour,
                            minutes: period.openEvent.time.minute
                        )
                    ),
                    close: MTimeOfWeek(
                        day: period.closeEvent?.day.name,
                        time: MTime(
                            hours: period.closeEvent?.time.hour,
                            minutes: period.closeEvent?.time.minute
                        )
                    )
                )
            })
        } else {
            return nil
        }
    }
    
    static private func mLatLng(_ toSet: GMSPlace) -> MLatLng? {
        let lat = toSet.coordinate.latitude
        let lng = toSet.coordinate.longitude
        
        return lat == -180 && lng == -180
        ? nil
        : MLatLng(
            latitude: toSet.coordinate.latitude,
            longitude: toSet.coordinate.longitude
        )
    }
    
    static private func mAttributions(_ toSet: GMSPlace) -> [String]? {
        let attributions = toSet.attributions
        if let attributions {
            return [attributions.string]
        } else {
            return nil
        }
    }
    
    static private func mAddressComponents(_ toSet: GMSPlace) -> MAddressComponents? {
        let addressComponents = toSet.addressComponents
        if let addressComponents {
            return MAddressComponents(asList : addressComponents.map { component in
                MAddressComponent(
                    name : component.name,
                    shortName: component.shortName,
                    types : component.types
                )
            })
        } else {
            return nil
        }
    }
}
