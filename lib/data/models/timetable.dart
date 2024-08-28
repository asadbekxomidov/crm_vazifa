import 'package:vazifa/data/models/week_days.dart';

class Timetable {
  Map<String, List<WeekDays>> week_days;

  Timetable({required this.week_days});

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      week_days: map.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => WeekDays.fromMap(e)).toList(),
        ),
      ),
    );
  }
}