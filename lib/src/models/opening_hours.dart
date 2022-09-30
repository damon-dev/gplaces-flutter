class OpeningHours {
  ///a list of Period objects that provide more detailed information
  ///that is equivalent to the data provided by [weeklyText]
  List<Period>? periods;

  ///Returns a list of strings that represent opening and closing
  ///hours in human readable form. For example:
  ///"Monday: 8:30 AM – 5:30 PM"
  ///"Saturday: Closed"
  List<String>? weeklyText;

  OpeningHours({
    this.periods,
    this.weeklyText,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      periods: (json['periods'] as List<dynamic>?)
          ?.map((e) => Period.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklyText: (json['weeklyText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'periods': periods,
        'weeklyText': weeklyText,
      };
}

class Period {
  ///Returns the time marker for when the Place opens.
  TimeOfWeek? open;

  ///Returns the time marker for when the Place closes or null
  ///if it's always open.
  TimeOfWeek? close;

  Period({
    this.open,
    this.close,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      open: json['open'] == null
          ? null
          : TimeOfWeek.fromJson(json['open'] as Map<String, dynamic>),
      close: json['close'] == null
          ? null
          : TimeOfWeek.fromJson(json['close'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'open': open,
        'close': close,
      };
}

class TimeOfWeek {
  ///Returns the day of the week.
  String? day;

  ///Returns the time in 24 hour format, for example "1730", or "0000"
  LocalTime? time;

  TimeOfWeek({
    this.day,
    this.time,
  });

  factory TimeOfWeek.fromJson(Map<String, dynamic> json) {
    return TimeOfWeek(
      day: json['day'] as String?,
      time: json['time'] == null
          ? null
          : LocalTime.fromJson(json['time'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'day': day,
        'time': time,
      };
}

class LocalTime {
  ///Returns the hours in 24 hour format (0 <= return value < 24).
  int? hours;

  ///Returns the minutes (0 <= return value < 60).
  int? minutes;

  LocalTime({
    this.hours,
    this.minutes,
  });

  factory LocalTime.fromJson(Map<String, dynamic> json) {
    return LocalTime(
      hours: json['hours'] as int?,
      minutes: json['minutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hours': hours,
        'minutes': minutes,
      };
}
