package co.codezens.places_autocomplete

import android.app.Activity
import android.content.pm.PackageManager
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.api.net.PlacesClient
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** PlacesAutocompletePlugin */
class PlacesAutocompletePlugin : FlutterPlugin, ActivityAware {
    private var methodChannel: MethodChannel? = null
    private var activity: Activity? = null
    private var placesClient: PlacesClient? = null
    private val gson = Gson()

    private val methodCallHandler = MethodCallHandler { call, result ->
        when (call.method) {
            Methods.INITIALIZE -> initializePlaces(result)
            Methods.IS_INITIALIZED -> result.success(Places.isInitialized())
            Methods.GET_PREDICTIONS -> getPredictions(call, result)
            Methods.GET_PLACE_DETAILS -> getPlaceDetails(call, result)
            else -> result.notImplemented()
        }
    }

    private fun initializePlaces(result: MethodChannel.Result) {
        safeCall {
            activity?.let { activity ->
                placesKey(activity)?.let { key ->
                    Places.initialize(activity.applicationContext, key)
                    placesClient = Places.createClient(activity.applicationContext)
                } ?: result.failure("apikey not found")
            } ?: result.failure("activity not found")
        }
    }

    private fun getPredictions(call: MethodCall, result: MethodChannel.Result) {
        val request = call.placesAutoCompleteRequest()
        placesClient?.findAutocompletePredictions(request)?.addOnSuccessListener {
            result.success(gson.toJson(it.predictions()))
        }?.addOnFailureListener {
            result.failure(it.message ?: "Predictions error!!!")
        }
    }

    private fun getPlaceDetails(call: MethodCall, result: MethodChannel.Result) {
        val request = call.placeDetailsRequest(result) ?: return
        placesClient?.fetchPlace(request)?.addOnSuccessListener {
            result.success(gson.toJson(it.placeDetails()))
        }?.addOnFailureListener {
            result.failure(it.message ?: "Place Details error!!!")
        }
    }

    private fun placesKey(activity: Activity): String? {
        safeCall {
            val context = activity.applicationContext
            return context.packageManager.getApplicationInfo(
                context.packageName,
                PackageManager.GET_META_DATA
            ).run { metaData.getString("com.google.android.geo.API_KEY") }
        }

        return null
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        cleanUp()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        cleanUp()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        cleanUp()
    }

    private fun onAttachedToEngine(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, Channel.NAME)
        methodChannel?.setMethodCallHandler(methodCallHandler)
    }

    private fun cleanUp() {
        activity = null
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
    }
}
