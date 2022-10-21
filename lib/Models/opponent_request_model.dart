

class OpponentRequest {
  final int id;
  final int teamId;
  final String teamName;
  final int fieldTypeId;
  final String bookingDate;
  final String startFreeTime;
  final String endFreeTime;
  final int duration;
  final int status;
  final String createdDate;

  OpponentRequest({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.fieldTypeId,
    required this.bookingDate,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.duration,
    required this.status,
    required this.createdDate
});

  factory OpponentRequest.fromJson(Map<String, dynamic> json) {
    return OpponentRequest(
      id: json['id'] as int,
      teamId: json['team']['id'] as int,
      teamName: json['team']['name'] as String,
      fieldTypeId: json['fieldType']['id'] as int,
      bookingDate: json['bookingDate'] as String,
      startFreeTime: json['startFreeTime'] as String,
      endFreeTime: json['endFreeTime'] as String,
      duration: json['duration'] as int,
      status: json['status'] as int,
      createdDate: json['createAt'] as String,
    );
  }


}