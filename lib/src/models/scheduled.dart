abstract class Scheduled { }

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
}

class ScheduledWeekDayTime extends Scheduled {
  int weekday;
  int hour;
  int minute; 
  ScheduledWeekDayTime({required this.weekday, required this.hour, required this.minute});

  @override
  String toString() { 
    return "$weekday $hour:$minute";
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
        && other.weekday == weekday
        && other.hour == hour
        && other.minute == minute;
  }

  DateTime get weeklyDateTime {
    DateTime now = DateTime.now();
    DateTime dt = DateTime(now.year, now.month, now.day, hour, minute);
    int dayDiff = dt.weekday - weekday;
    return dayDiff > 0 ? dt.add(Duration(days: dayDiff)) : dt.subtract(Duration(days: dayDiff));
  }

}