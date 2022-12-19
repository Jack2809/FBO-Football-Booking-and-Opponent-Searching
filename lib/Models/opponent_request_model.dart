
import 'package:football_booking_fbo_mobile/Models/district_model.dart';

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
  final double teamScore;
  final bool isRivalry ;
  final bool expired;

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
    required this.createdDate,
    required this.teamScore,
    required this.isRivalry,
    required this.expired
});

  factory OpponentRequest.fromJson(Map<String, dynamic> json) {
    return OpponentRequest(
      id: json['id'] as int,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      fieldTypeId: json['fieldTypeId'] as int,
      bookingDate: json['bookingDate'] as String,
      startFreeTime: json['startFreeTime'] as String,
      endFreeTime: json['endFreeTime'] as String,
      duration: json['duration'] as int,
      status: json['status'] as int,
      createdDate: json['createAt'] as String,
      isRivalry: json['rivalry'] as bool,
      teamScore: json['teamScore'] as double,
      expired: json['expired'] as bool
    );
  }


}

class OpponentRequestDetailModel{
  final int id;
  final int teamId;
  final String teamName;
  final int fieldTypeId;
  final String fieldTypeName;
  final String bookingDate;
  final String startFreeTime;
  final String endFreeTime;
  final int duration;
  int status;
  final String createdDate;
  List<District> districtList;
  final double teamScore;
  final double reviewScore;
  final int reviewCount;
  final int totalMatches;
  final bool isRivalry;
  final bool expired;


  OpponentRequestDetailModel({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.fieldTypeId,
    required this.fieldTypeName,
    required this.bookingDate,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.duration,
    required this.status,
    required this.createdDate,
    required this.districtList,
    required this.teamScore,
    required this.isRivalry,
    required this.expired,
    required this.reviewScore,
    required this.reviewCount,
    required this.totalMatches
});

  factory OpponentRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return OpponentRequestDetailModel(
      id: json['ticket']['id'] as int,
      teamId: json['ticket']['teamId'] as int,
      teamName: json['ticket']['teamName'] as String,
      fieldTypeId: json['ticket']['fieldTypeId'] as int,
      fieldTypeName: json['ticket']['fieldTypeName'] as String,
      bookingDate: json['ticket']['bookingDate'] as String,
      startFreeTime: json['ticket']['startFreeTime'] as String,
      endFreeTime: json['ticket']['endFreeTime'] as String,
      duration: json['ticket']['duration'] as int,
      status: json['ticket']['status'] as int,
      createdDate: json['ticket']['createAt'] as String,
      districtList: json['Districts']['districtList'].map<District>((json) => District.fromJson(json)).toList(),
      teamScore: json['ticket']['teamScore'] as double,
      isRivalry: json['ticket']['rivalry'] as bool,
      expired: json['ticket']['expired'] as bool,
      reviewScore: json['ticket']['teamStar'] as double,
      reviewCount: json['ticket']['teamReviewCount'] as int,
      totalMatches: json['ticket']['teamMatches'] as int
    );
  }


}

class RecommendedRequest {
  final int id;
  final String userName;
  final String accountName;
  final String teamName;
  final String startFreeTime;
  final String endFreeTime;
  final String districtNames;
   int status;
   final double teamScore;
   final int totalMatches;
   final int reviewCount;
   final double reviewScore;

  RecommendedRequest({
    required this.id,
    required this.userName,
    required this.accountName,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districtNames,
    required this.status,
    required this.teamScore,
    required this.totalMatches,
    required this.reviewScore,
    required this.reviewCount

});

  factory RecommendedRequest.fromJson(Map<String, dynamic> json) {
    return RecommendedRequest(
      id: json['ticketId'] as int,
      userName: json['username'] as String,
      accountName: json['accountName'] as String,
      teamName: json['teamName'] as String,
      startFreeTime: json['startFreeTime'] as String,
      endFreeTime: json['endFreeTime'] as String,
      districtNames: json['districtNames'] as String,
      status: json['isWaiting'] as int,
      teamScore: json['teamScore'] as double,
      totalMatches: json['teamMatches'] as int,
      reviewScore: json['teamStar'] as double,
      reviewCount: json['teamReviewCount'] as int
    );
  }

}

class WaitingRequest {
  final int id;
  final int teamId;
  final String teamName;
  final String startFreeTime;
  final String endFreeTime;
  final String districts;
  final double teamScore;

  WaitingRequest({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districts,
    required this.teamScore
});

  factory WaitingRequest.fromJson(Map<String,dynamic> json){
    return WaitingRequest(
        id: json['ticketId'] as int,
        teamId: json['teamId'] as int,
        teamName: json['teamName'] as String,
        startFreeTime: json['startFreeTime'] as String,
        endFreeTime: json['endFreeTime'] as String,
        districts: json['districts'] as String,
        teamScore: json['teamScore'] as double
    );
  }

}

class MatchedRequest {
  final int id;
  final String teamName;
  final String startFreeTime;
  final String endFreeTime;
  final String districts;
  final bool isBooker;
  final double teamScore;


  MatchedRequest({
    required this.id,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districts,
    required this.isBooker,
    required this.teamScore

  });

  factory MatchedRequest.fromJson(Map<String,dynamic> json){
    return MatchedRequest(
        id: json['ticketId'] as int,
        teamName: json['teamName'] as String,
        startFreeTime: json['startFreeTime'] as String,
        endFreeTime: json['endFreeTime'] as String,
        districts: json['districtNames'] as String,
        isBooker: json['booker'] as bool,
        teamScore:json['teamScore'] as double
    );
  }

}