package co.codezens.places_autocomplete.extensions

import io.flutter.plugin.common.MethodChannel

fun MethodChannel.Result.failure(msg: String) {
    error("error", msg, null)
}

inline fun <R> safeCall(call: () -> R): Result<R> {
    return try {
        Result.success(call())
    } catch (e: Exception) {
        Result.failure(e)
    }
}

