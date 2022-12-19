

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

mixin InputOpponentRequestValidation {

  double minutesConvert(String minutes){
    if(minutes == "30"){
      return 0.5;
    }
    return 0;
  }

  String? isValidFreeTimeValid (TimeOfDay freeTimeStart,TimeOfDay freeTimeEnd,int duration){
    if (freeTimeStart == TimeOfDay(hour: 0,minute: 0) && freeTimeEnd == TimeOfDay(hour: 0,minute: 0)) {
      return "vui lòng chọn đầy đủ thời gian rảnh";
    }else{
      var now = DateTime.now();
      DateTime start;
      DateTime end;
      if(freeTimeStart == TimeOfDay(hour: 0,minute: 0)){
         start = DateTime(now.year,now.month,now.day,0,0);
      }else{
        start = DateTime(now.year,now.month,now.day,freeTimeStart.hour,freeTimeStart.minute);
      }
      if(freeTimeEnd == TimeOfDay(hour: 0,minute: 0)){
        end = DateTime(now.year,now.month,now.day,24,0);
      }else{
        end = DateTime(now.year,now.month,now.day,freeTimeEnd.hour,freeTimeEnd.minute);
      }
      if(end.isBefore(start)){
        return 'Thời gian rảnh không hợp lệ';
      }
      var freeTimeDurationStr = end.difference(start).toString().split(":");
      double freeTimeDurationHour = double.parse(freeTimeDurationStr[0]);
      double freeTimeDurationMinutes = minutesConvert(freeTimeDurationStr[1]);
      double totalFreeTimeDuration = freeTimeDurationHour+freeTimeDurationMinutes;
      log(totalFreeTimeDuration.toString());
      double durationInHours = duration / 60;
      if(totalFreeTimeDuration < durationInHours){
        return "Thời lượng của thời gian rảnh nhỏ hơn thời lượng trận đấu";
      }
    }

    return "";
}

String? isSelectedClub(int? clubId){
    if(clubId == null){
      return 'Vui lòng chọn CLB !!';
    }
    return "";
}

  String? isSelectedTeam(Team? team , bool _is5vs5){
    if(team == null){
      return 'Vui lòng chọn đội hình !!';
    }
    if(_is5vs5){
      if(team.numberOfPlayers < 5 || team.numberOfPlayers > 7)
        return "số lượng thành viên phải là 5 - 6 cầu thủ";
    }else{
      if(team.numberOfPlayers < 7 || team.numberOfPlayers > 9)
        return "số lượng thành viên phải từ 7 - 9 cầu thủ ";
    }
    return "";
  }

  String? isSelectedDistrict(List<int> districtList){
    if(districtList.isEmpty){
      return 'Vui lòng chọn khu vực !!';
    }
    return "";
  }

}