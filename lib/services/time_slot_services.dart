

import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/time_slot_model.dart';
import 'package:http/http.dart' as http;

import 'access_key_shared_references.dart';

List<TimeSlot> parseTimeSlot(List responseBody){
  return responseBody.map<TimeSlot>((json) =>TimeSlot.fromJson(json)).toList();

}



Future<List<TimeSlot>>  fetchTimeSlots (int facilityId,String bookingDate,int fieldTypeId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/'+facilityId.toString()+'/timeslots'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "fieldTypeId": fieldTypeId,
        "startDateTime": bookingDate
      })
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseTimeSlot(map['availabilities']);
}