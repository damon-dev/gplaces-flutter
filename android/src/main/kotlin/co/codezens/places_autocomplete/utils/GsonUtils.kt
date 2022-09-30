package co.codezens.places_autocomplete.utils

import com.google.gson.Gson

class GsonUtils {
    companion object {
        fun <T> convertFromJson(toConvert: Any?, classType: Class<T>): T {
            val gson = Gson()
            return gson.fromJson(
                gson.toJson(toConvert),
                classType
            )
        }
    }
}