

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
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseOpponentRequest(map['postList']);

}

OpponentRequestDetailModel parseOpponentRequestDetail(String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return OpponentRequestDetailModel.fromJson(parsed);
}

Future<OpponentRequestDetailModel> fetchOpponentRequestDetail (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts/'+requestId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  return parseOpponentRequestDetail(response.body);

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

Future<List<RecommendedRequest>> getRecommendedRequest (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts/'+requestId.toString()+'/recommended-posts?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  log(utf8.decode(response.bodyBytes));
  return parseRecommendedRequest(map['postList']);

}

List<RecommendedRequest> parseRecommendedRequest(List responseBody){
  return responseBody.map<RecommendedRequest>((json) =>RecommendedRequest.fromJson(json)).toList();
}

Future<List<WaitingRequest>> getWaitingRequest (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts/'+requestId.toString()+'/challenges-you?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseWaitingRequest(map['challengesList']);

}

List<WaitingRequest> parseWaitingRequest(List responseBody){
  return responseBody.map<WaitingRequest>((json) =>WaitingRequest.fromJson(json)).toList();
}

Future<String> sendChallenge (int myRequestId,int opponentRequestId,int myTeamId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/posts/{id}/join'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "joiningPostId": myRequestId,
        "postId": opponentRequestId,
        "teamId": myTeamId
      })
  );
  return response.body;
}





