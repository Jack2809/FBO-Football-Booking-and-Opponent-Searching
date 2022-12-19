

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({required this.startTime,required this.endTime});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['timeStart'] as String,
      endTime: json['timeEnd'] as String,
    );
  }
}