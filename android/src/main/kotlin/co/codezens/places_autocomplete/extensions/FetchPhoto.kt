package co.codezens.places_autocomplete.extensions

import android.graphics.Bitmap
import co.codezens.places_autocomplete.Arguments
import co.codezens.places_autocomplete.models.MPlacePhoto
import co.codezens.places_autocomplete.models.requests.PhotoRequest
import co.codezens.places_autocomplete.utils.GsonUtils
import com.google.android.libraries.places.api.net.FetchPhotoRequest
import com.google.android.libraries.places.api.net.FetchPhotoResponse
import io.flutter.plugin.common.MethodCall
import java.io.ByteArrayOutputStream

fun MethodCall.createPhotoRequest(): FetchPhotoRequest {
    val mPhotoRequest = GsonUtils.convertFromJson(
        argument<Map<String, Any?>>(Arguments.PHOTO_REQUEST),
        PhotoRequest::class.java
    )

    return mPhotoRequest.createRequest()
}

fun FetchPhotoResponse.photoData(): MPlacePhoto {
    return bitmap.let {
        val stream = ByteArrayOutputStream()
        it.compress(Bitmap.CompressFormat.PNG, 100, stream)
        val bytes = stream.toByteArray()
        bitmap.recycle()
        MPlacePhoto(imageBytes = bytes)
    }
}