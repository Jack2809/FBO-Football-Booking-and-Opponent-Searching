class MatchHistory {
  final int matchId;
  final String startTime;
  final String endTime;
  final int homeTeamId;
  final String homeTeamName;
  final int awayTeamId;
  final String awayTeamName;
  final int facilityId;
  final String facilityName;
  final String address;
  final String district;
  final String bookingDate;
  final String homeTeamImage;
  final String awayTeamImage;
  final bool rivalry;

  MatchHistory(
      {required this.matchId,
      required this.facilityId,
      required this.facilityName,
      required this.startTime,
      required this.endTime,
      required this.address,
      required this.district,
      required this.homeTeamId,
      required this.homeTeamName,
      required this.awayTeamId,
      required this.awayTeamName,
        required this .bookingDate,
        required this.homeTeamImage,
        required this.awayTeamImage,
        required this.rivalry
      });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
        matchId: json["matchId"] as int,
        startTime: json["startTime"] as String,
        endTime: json["endTime"] as String,
        homeTeamId: json["homeTeamId"] as int,
        homeTeamName: json["homeTeamName"] as String,
        awayTeamId: json["awayTeamId"] as int,
        awayTeamName: json["awayTeamName"] as String,
        facilityId: json["facilityId"] as int,
        facilityName: json["facilityName"] as String,
        address: json["address"] as String,
        district: json["district"] as String,
      bookingDate: json['date'] as String,
      homeTeamImage: json['homeTeamImage'] as String,
      awayTeamImage: json['awayTeamImage'] as String,
      rivalry: json['rivalry'] as bool
    );
  }
}
