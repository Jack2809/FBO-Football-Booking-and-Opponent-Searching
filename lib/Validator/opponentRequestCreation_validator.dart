

import 'dart:developer';

import 'package:flutter/material.dart';

mixin InputOpponentRequestValidation {

  double minutesConvert(String minutes){
    if(minutes == "30"){
      return 0.5;
    }
    return 0;
  }

  String? isValidFreeTimeValid (TimeOfDay freeTimeStart,TimeOfDay freeTimeEnd,int duration){
    var now = DateTime.now();
    DateTime start = DateTime(now.year,now.month,now.day,freeTimeStart.hour,freeTimeStart.minute);
    DateTime end = DateTime(now.year,now.month,now.day,freeTimeEnd.hour,freeTimeEnd.minute);
    if (freeTimeStart == TimeOfDay(hour: 0,minute: 0) && freeTimeEnd == TimeOfDay(hour: 0,minute: 0)) {
      return "vui lòng chọn đầy đủ thời gian rảnh";
    }
    if(freeTimeStart == TimeOfDay(hour: 0,minute: 0)) return "Chọn bắt đầu giờ rảnh";
    if (freeTimeEnd == TimeOfDay(hour: 0,minute: 0)) return "Chọn kết thúc giờ rảnh";
    if(end.isBefore(start)){
      return 'Thời gian rảnh không hợp lệ';
    }
    var freeTimeDurationStr = end.difference(start).toString().split(":");
    double freeTimeDurationHour = double.parse(freeTimeDurationStr[0]);
    double freeTimeDurationMinutes = minutesConvert(freeTimeDurationStr[1]);
    double TotalFreeTimeDuration = freeTimeDurationHour+freeTimeDurationMinutes;
    log(TotalFreeTimeDuration.toString());
    double durationInhours = duration/60;
    if(TotalFreeTimeDuration < durationInhours){
      return "Thời lượng của thời gian rảnh nhỏ hơn thời lượng trận đấu";
    }

    return "";
}

String? isSelectedClub(int? clubId){
    if(clubId == null){
      return 'Vui lòng chọn CLB !!';
    }
    return "";
}

  String? isSelectedTeam(int? teamId){
    if(teamId == null){
      return 'Vui lòng chọn đội hình !!';
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