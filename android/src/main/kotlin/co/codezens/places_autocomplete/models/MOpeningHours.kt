package co.codezens.places_autocomplete.models

data class MOpeningHours(
    val periods: List<MPeriod>?,
    val weeklyText: List<String>?
)

data class MPeriod(
    val open: MTimeOfWeek?,
    val close: MTimeOfWeek?
)

data class MTimeOfWeek(
    val day: String?,
    val time: MTime?
)

data class MTime(
    val hours: Int?,
    val minutes: Int?
)
