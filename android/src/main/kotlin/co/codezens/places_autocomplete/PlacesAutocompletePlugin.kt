package co.codezens.places_autocomplete

import android.annotation.SuppressLint
import android.app.Activity
import android.content.pm.PackageManager
import co.codezens.places_autocomplete.extensions.*
import com.google.android.gms.tasks.OnFailureListener
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
    private lateinit var placesClient: PlacesClient
    private val gson = Gson()

    private val methodCallHandler = MethodCallHandler { call, result ->
        when (call.method) {
            Methods.INITIALIZE -> initializePlaces(result)
            Methods.IS_INITIALIZED -> result.success(Places.isInitialized())
            Methods.GET_PREDICTIONS -> getPredictions(call, result)
            Methods.GET_PLACE_DETAILS -> getPlaceDetails(call, result)
            Methods.GET_PLACE_PHOTO -> getPlacePhoto(call, result)
            Methods.GET_CURRENT_PLACE -> getCurrentPlace(call, result)
            else -> result.notImplemented()
        }
    }

    private fun initializePlaces(result: MethodChannel.Result) {
        safeCall {
            activity?.let { activity ->
                placesKey(activity)?.let { key ->
                    Places.initialize(activity.applicationContext, key)
                    placesClient = Places.createClient(activity.applicationContext)
                    result.success("Initialized")
                } ?: result.failure("apikey not found")
            } ?: result.failure("activity not found")
        }
    }

    private fun getPredictions(call: MethodCall, result: MethodChannel.Result) {
        safeCall {
            placesClient.findAutocompletePredictions(call.placesAutoCompleteRequest())
                .addOnSuccessListener {
                    result.success(gson.toJson(it.predictions()))
                }.addOnFailureListener(onFailureListener(result))
        }
    }

    private fun getPlaceDetails(call: MethodCall, result: MethodChannel.Result) {
        safeCall {
            placesClient.fetchPlace(call.placeDetailsRequest()).addOnSuccessListener {
                result.success(gson.toJson(it.placeDetails()))
            }.addOnFailureListener(onFailureListener(result))
        }
    }

    private fun getPlacePhoto(call: MethodCall, result: MethodChannel.Result) {
        safeCall {
            placesClient.fetchPhoto(call.createPhotoRequest()).addOnSuccessListener {
                result.success(gson.toJson(it.photoData()))
            }.addOnFailureListener(onFailureListener(result))
        }
    }

    @SuppressLint("MissingPermission")
    private fun getCurrentPlace(call: MethodCall, result: MethodChannel.Result) {
        safeCall {
            placesClient.findCurrentPlace(call.findCurrentPlaceRequest()).addOnSuccessListener {
                result.success(gson.toJson(it.currentPlaceData()))
            }.addOnFailureListener(onFailureListener(result))
        }
    }

    private fun placesKey(activity: Activity): String? {
        safeCall {
            val context = activity.applicationContext
            return context.packageManager.getApplicationInfo(
                context.packageName, PackageManager.GET_META_DATA
            ).run { metaData.getString("com.google.android.geo.API_KEY") }
        }

        return null
    }

    private fun onFailureListener(result: MethodChannel.Result) = OnFailureListener {
        result.failure("${it.message}")
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
