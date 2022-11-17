

import 'dart:convert';

<<<<<<< HEAD
import 'package:football_booking_fbo_mobile/Models/booked_facility_post_model.dart';

import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<String> bookFacilityByPost(int postId, double depositMoney,int facilityId,double duration, int fieldTypeId,String startDateTime) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/reservation-success'),
=======
import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<String> bookFacilityByPost(int postId,int facilityId,double duration, int fieldTypeId,String startDateTime) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/'+facilityId.toString()+'/reservation'),
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
<<<<<<< HEAD
        "amount": depositMoney,
        "duration": duration,
        "facilityId": facilityId,
=======
        "duration": duration,
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
        "fieldTypeId": fieldTypeId,
        "startDateTime": startDateTime,
        "ticketId": postId
      })
  );

  return response.body;
<<<<<<< HEAD


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
=======
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
}