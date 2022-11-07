
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
  final bool isRivalry ;

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
    required this.isRivalry
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
      isRivalry: json['rivalry'] as bool,
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
  final int status;
  final String createdDate;
  List<District> districtList;

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
});

  factory OpponentRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return OpponentRequestDetailModel(
      id: json['ticket']['id'] as int,
      teamId: json['ticket']['team']['id'] as int,
      teamName: json['ticket']['team']['name'] as String,
      fieldTypeId: json['ticket']['fieldType']['id'] as int,
      fieldTypeName: json['ticket']['fieldType']['fieldTypeName'] as String,
      bookingDate: json['ticket']['bookingDate'] as String,
      startFreeTime: json['ticket']['startFreeTime'] as String,
      endFreeTime: json['ticket']['endFreeTime'] as String,
      duration: json['ticket']['duration'] as int,
      status: json['ticket']['status'] as int,
      createdDate: json['ticket']['createAt'] as String,
      districtList: json['Districts']['districtList'].map<District>((json) => District.fromJson(json)).toList(),
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

  RecommendedRequest({
    required this.id,
    required this.userName,
    required this.accountName,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districtNames,
    required this.status
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
      status: json['isWaiting'] as int
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

  WaitingRequest({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districts
});

  factory WaitingRequest.fromJson(Map<String,dynamic> json){
    return WaitingRequest(
        id: json['ticketId'] as int,
        teamId: json['teamId'] as int,
        teamName: json['teamName'] as String,
        startFreeTime: json['startFreeTime'] as String,
        endFreeTime: json['endFreeTime'] as String,
        districts: json['districts'] as String
    );
  }

}

class MatchedRequest {
  final int id;
  final String teamName;
  final String startFreeTime;
  final String endFreeTime;
  final String districts;

  MatchedRequest({
    required this.id,
    required this.teamName,
    required this.startFreeTime,
    required this.endFreeTime,
    required this.districts
  });

  factory MatchedRequest.fromJson(Map<String,dynamic> json){
    return MatchedRequest(
        id: json['ticketId'] as int,
        teamName: json['teamName'] as String,
        startFreeTime: json['startFreeTime'] as String,
        endFreeTime: json['endFreeTime'] as String,
        districts: json['districtNames'] as String
    );
  }

}