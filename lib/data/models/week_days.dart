class WeekDays {
  String room;
  String start_time;
  String end_time;

  WeekDays({
    required this.room,
    required this.start_time,
    required this.end_time,
  });

  factory WeekDays.fromMap(Map<String, dynamic> map) {
    return WeekDays(
      room: map['room'],
      start_time: map['start_time'],
      end_time: map['end_time'],
    );
  }
}