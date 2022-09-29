package co.codezens.places_autocomplete.models.requests

import co.codezens.places_autocomplete.models.MPhotoMetaData
import com.google.android.libraries.places.api.model.PhotoMetadata
import com.google.android.libraries.places.api.net.FetchPhotoRequest

data class PhotoRequest(
    val photoMetaData: MPhotoMetaData,
    val maxWidth: Int?,
    val maxHeight: Int?
) {
    fun createRequest(): FetchPhotoRequest {
        val metaData = PhotoMetadata.builder(photoMetaData.photoReference)
            .apply {
                width = photoMetaData.width ?: 0
                height = photoMetaData.height ?: 0
                attributions = photoMetaData.attributions
            }.build()

        return FetchPhotoRequest.builder(metaData)
            .setMaxHeight(maxHeight)
            .setMaxWidth(maxWidth)
            .build()
    }
}