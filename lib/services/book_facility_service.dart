

import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/booked_facility_post_model.dart';

import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<String> bookFacilityByPost(int postId, double depositMoney,int facilityId,double duration, int fieldTypeId,String startDateTime) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/reservation-success'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "amount": depositMoney,
        "duration": duration,
        "facilityId": facilityId,
        "fieldTypeId": fieldTypeId,
        "startDateTime": startDateTime,
        "ticketId": postId
      })
  );

  return response.body;


}

BookedFacilityByPost parseBookedFacilityPost(String responseBody){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(responseBody.codeUnits));
  return BookedFacilityByPost.fromJson(parsed);
}

Future<BookedFacilityByPost> getBookedFacilityByPost(int postId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/'+postId.toString()+'/load-reservation-info'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  return parseBookedFacilityPost(response.body);
}