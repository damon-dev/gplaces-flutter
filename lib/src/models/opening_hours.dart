class OpeningHours {
  List<Period>? periods;
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
  TimeOfWeek? open;
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
  String? day;
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
  int? hours;
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
