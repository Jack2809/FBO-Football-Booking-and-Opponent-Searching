

import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;

List<OpponentRequest> parseOpponentRequest(List responseBody){
  return responseBody.map<OpponentRequest>((json) =>OpponentRequest.fromJson(json)).toList();
}

Future<List<OpponentRequest>> fetchOpponentRequests () async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map map = jsonDecode(response.body);
  return parseOpponentRequest(map['postList']);

}

Future<String> createOpponentRequest (List<int> districtIdList,
    String bookingDate,
    int duration,
    String freetimeStart,
    String freetimeEnd,
    int fieldTypeId,
    int teamId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  DateTime now = DateTime.now();
  log(now.toString());
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        'status' : 1,
        'districtIds' : districtIdList,
        'bookingDate' : bookingDate,
        'duration' : duration,
        'endFreeTime' : freetimeEnd,
        'fieldTypeId' : fieldTypeId,
        'startFreeTime' : freetimeStart,
        'teamId' : teamId
      })
  );
  log("status:" +response.statusCode.toString());
  return response.body;
}

Future<String> deleteOpponentRequest(int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.delete(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts/'+requestId.toString()),
    headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
  );
  return response.body;
}