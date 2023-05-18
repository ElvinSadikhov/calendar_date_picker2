// ignore_for_file: avoid_function_literals_in_foreach_calls

import '../utils/date_time_parser.dart';

abstract class Scheduled {

  Map<String, dynamic> toJson(); 

}
 
class ScheduledDateTime extends Scheduled {
  DateTime dt;
  ScheduledDateTime({required this.dt}); 

  @override
  String toString() { 
    return dt.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ScheduledDateTime
        && other.dt == dt;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "dt": dt.toJson()
    };
  }

  static ScheduledDateTime fromJson(Map<String, dynamic> json) {
    return ScheduledDateTime(dt: DateTimeParser.fromJson(json["dt"]));
  }

}

class ScheduledWeekDayTime extends Scheduled {
  List<int> weekdays;
  int hour;
  int minute; 
  ScheduledWeekDayTime({required this.weekdays, required this.hour, required this.minute});

  @override
  String toString() { 
    return "$weekdays $hour:$minute";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ScheduledWeekDayTime
        && other.weekdays == weekdays
        && other.hour == hour
        && other.minute == minute;
  }

  List<DateTime> get weeklyDateTime {
    DateTime now = DateTime.now();
    DateTime dt = DateTime(now.year, now.month, now.day, hour, minute);
    final List<DateTime> res = [];
    weekdays.forEach((wd) { 
      int dayDiff = dt.weekday - wd;
      res.add(dayDiff > 0 ? dt.add(Duration(days: dayDiff)) : dt.subtract(Duration(days: dayDiff)));
    });
    return res;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "weekday": weekdays,
      "hour": hour,
      "minute": minute,
    };
  }
 
  static ScheduledWeekDayTime fromJson(Map<String, dynamic> json) {
    return ScheduledWeekDayTime(weekdays: (json['weekdays'] as List<int>).map((dynamic e) => e as int).toList(), hour: json["hour"] as int, minute: json["minute"] as int);
  }

}