

import 'package:flutter/cupertino.dart';
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
      id: json['post']['id'] as int,
      teamId: json['post']['team']['id'] as int,
      teamName: json['post']['team']['name'] as String,
      fieldTypeId: json['post']['fieldType']['id'] as int,
      fieldTypeName: json['post']['fieldType']['fieldTypeName'] as String,
      bookingDate: json['post']['bookingDate'] as String,
      startFreeTime: json['post']['startFreeTime'] as String,
      endFreeTime: json['post']['endFreeTime'] as String,
      duration: json['post']['duration'] as int,
      status: json['post']['status'] as int,
      createdDate: json['post']['createAt'] as String,
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
      id: json['postId'] as int,
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
        id: json['postId'] as int,
        teamId: json['teamId'] as int,
        teamName: json['teamName'] as String,
        startFreeTime: json['startFreeTime'] as String,
        endFreeTime: json['endFreeTime'] as String,
        districts: json['districts'] as String
    );
  }

}