

import 'dart:convert';

import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<String> bookFacilityByPost(int postId,int facilityId,double duration, int fieldTypeId,String startDateTime) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/'+facilityId.toString()+'/reservation'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "duration": duration,
        "fieldTypeId": fieldTypeId,
        "startDateTime": startDateTime,
        "ticketId": postId
      })
  );

  return response.body;
}