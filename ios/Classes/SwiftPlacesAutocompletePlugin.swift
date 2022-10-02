import Flutter
import UIKit
import GooglePlaces

public class SwiftPlacesAutocompletePlugin: NSObject, FlutterPlugin {
    private var placeClient: GMSPlacesClient?
    private var lastPhotoMetadatas: [GMSPlacePhotoMetadata]?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Channel.NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftPlacesAutocompletePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.INITIALIZE: initialzePlaces(result: result)
        case Methods.IS_INITIALIZED: isInitialized(result: result)
        case Methods.GET_PREDICTIONS: getPredictions(call: call, result: result)
        case Methods.GET_PLACE_DETAILS: getPlaceDetails(call: call, result: result)
        case Methods.GET_PHOTO_DETAILS: getPlacePhoto(call: call, result: result)
        case Methods.GET_CURRENT_PLACE: getCurrentPlace(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    private func initialzePlaces(result: @escaping FlutterResult) {
        let apiKey = getPlaceApiKey()
        if(apiKey == nil) {
            let error = FlutterError.init(
                code: "initialzePlaces",
                message: "places api key is missing!!!",
                details: nil
            )
            result(error)
            
            return
        }
        
        do {
            try provideKeyAndInitClient(apiKey: apiKey as! String)
            result("Initialized")
        } catch {
            let error = FlutterError.init(
                code: "initialzePlaces",
                message: error.localizedDescription,
                details: nil
            )
            result(error)
        }
    }
    
    private func provideKeyAndInitClient(apiKey: String) throws {
        GMSPlacesClient.provideAPIKey(apiKey)
        placeClient = GMSPlacesClient.shared()
    }
    
    private func getPlaceApiKey() -> Any? {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GooglePlaceKey")
        else { return nil }
        
        return key
    }
    
    private func isInitialized(result: @escaping FlutterResult) {
        result(placeClient != nil)
    }
    
    private func getPredictions(call: FlutterMethodCall,
                                result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any?>
        let predictionRequest = args.predictionRequest
        
        if let request = predictionRequest {
            let sessionToken = GMSAutocompleteSessionToken()
            placeClient?.findAutocompletePredictions(
                fromQuery: request.query,
                filter: request.filter,
                sessionToken: sessionToken,
                callback: { (results, error) in
                    if let error = error {
                        let error = FlutterError.init(
                            code: "getPredictions",
                            message: error.localizedDescription,
                            details: nil
                        )
                        result(error)
                        
                        return
                    }
                    
                    if let results = results {
                        result(results.predictions())
                    } else {
                        result(nil)
                    }
                }
            );
        } else {
            result(nil)
        }
    }
    
    private func getPlaceDetails(call: FlutterMethodCall,
                                 result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any?>
        let placeRequest = args.placeRequest
        
        if let request = placeRequest {
            let sessionToken = GMSAutocompleteSessionToken()
            placeClient?.fetchPlace(
                fromPlaceID: request.placeId,
                placeFields: request.gmsPlaceField,
                sessionToken: sessionToken,
                callback: { place, error in
                    if let error = error {
                        let error = FlutterError.init(
                            code: "getPlaceDetails",
                            message: error.localizedDescription,
                            details: nil
                        )
                        result(error)
                        
                        return
                    }
                    
                    if let place = place {
                        self.lastPhotoMetadatas = place.photos
                        result(PlaceDetailsUtils.placeDetailData(place))
                    } else {
                        result(nil)
                    }
                }
            )
        } else {
            result(nil)
        }
    }
    
    private func getPlacePhoto(call: FlutterMethodCall,
                               result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any?>
        let photoRequest = args.photoRequest
        
        if let request = photoRequest {
            let metadata = request.metadata(self.lastPhotoMetadatas)
            
            if let metadata = metadata {
                placeClient?.loadPlacePhoto(
                    metadata,
                    constrainedTo: request.constraints,
                    scale: CGFloat(1.0),
                    callback: { (image, error) in
                        if let error = error {
                            let error = FlutterError.init(
                                code: "getPlacePhoto",
                                message: error.localizedDescription,
                                details: nil
                            )
                            
                            result(error)
                        }
                        
                        if let image = image {
                            result(image.photoData())
                        } else {
                            result(nil)
                        }
                    })
            } else {
                result(nil)
            }
        }
    }
    
    private func getCurrentPlace(call: FlutterMethodCall,
                                 result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any?>
        let currentPlaceRequest = args.currentPlaceRequest
        
        if let request = currentPlaceRequest {
            placeClient?.findPlaceLikelihoodsFromCurrentLocation(
                withPlaceFields: request.gmsPlaceField,
                callback: { results, error in
                    if let error = error {
                        let error = FlutterError.init(
                            code: "getCurrentPlace",
                            message: error.localizedDescription,
                            details: nil
                        )
                        
                        result(error)
                    }
                    
                    if let results = results {
                        result(results.currentPlaceData())
                    } else {
                        result(nil)
                    }
                })
        } else {
            result(nil)
        }
    }
}
