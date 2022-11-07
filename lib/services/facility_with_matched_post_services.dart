
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:football_booking_fbo_mobile/Models/facility_with_matched_post.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';

Future<FacilityWithMatchedPost> fetchFacilityWithMatchedPost (int myRequestId,int opponentRequestId,double duration,int fieldTypeId,String startDate) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/placing'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "awayTicketId": opponentRequestId,
        "duration": duration,
        "fieldTypeId": fieldTypeId,
        "homeTicketId": myRequestId,
        "startDate": startDate
      })
  );

  return parseFacilityWithMatchedPost(response.body);
}

FacilityWithMatchedPost parseFacilityWithMatchedPost(String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return FacilityWithMatchedPost.fromJson(parsed);
}