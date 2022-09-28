import Flutter
import UIKit
import GooglePlaces

public class SwiftPlacesAutocompletePlugin: NSObject, FlutterPlugin {
    private var placeClient: GMSPlacesClient?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Channel.NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftPlacesAutocompletePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.INITIALIZE: initialzePlaces(result: result);
        case Methods.IS_INITIALIZED: isInitialized(result: result);
        case Methods.GET_PREDICTIONS: getPredictions(call: call, result: result);
        case Methods.GET_PLACE_DETAILS: getPlaceDetails(call: call, result: result);
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
        let args = call.arguments as? Dictionary<String, Any?>
        
        if(args == nil) {
            let error = FlutterError.init(
                code: "getPredictions",
                message: "arguments can't be nil!!!",
                details: nil
            )
            result(error)
            
            return
        }
        
        let sessionToken = GMSAutocompleteSessionToken()
        placeClient?.findAutocompletePredictions(
            fromQuery: args!.predictionQuery(),
            filter: args!.predictionsFilter(),
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
                }
            }
        );
    }
    
    private func getPlaceDetails(call: FlutterMethodCall,
                                 result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any?>
        
        if(args == nil) {
            let error = FlutterError.init(
                code: "getPlaceDetails",
                message: "arguments can't be nil!!!",
                details: nil
            )
            result(error)
            
            return
        }
        
        let sessionToken = GMSAutocompleteSessionToken()
        placeClient?.fetchPlace(
            fromPlaceID: args!.placeId(),
            placeFields: args!.placeFields(),
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
                    result(PlaceDetailsUtils.placeDetails(place))
                }
            }
        )
    }
}
