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

      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets?pageNo=0&pageSize=20&sortBy=bookingDate&sortDir=desc'),

      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseOpponentRequest(map['ticketList']);

}

OpponentRequestDetailModel parseOpponentRequestDetail(String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return OpponentRequestDetailModel.fromJson(parsed);
}

Future<OpponentRequestDetailModel> fetchOpponentRequestDetail (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/'+requestId.toString()),
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
    int teamId,
    int isRivalry
      ) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  DateTime now = DateTime.now();
  log(now.toString());
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets'),
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
        'teamId' : teamId,
        'isRivalry': isRivalry
      })
  );
  log(response.body);
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
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/'+requestId.toString()+'/recommended-tickets?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  log(utf8.decode(response.bodyBytes));
  return parseRecommendedRequest(map['ticketList']);

}

List<RecommendedRequest> parseRecommendedRequest(List responseBody){
  return responseBody.map<RecommendedRequest>((json) =>RecommendedRequest.fromJson(json)).toList();
}

Future<List<WaitingRequest>> getWaitingRequest (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets'
          '/'+requestId.toString()+'/challenges-you?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
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
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/{id}/join'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "joiningTicketId": myRequestId,
        "ticketId": opponentRequestId,
        "teamId": myTeamId
      })
  );
  return response.body;
}

Future<String> acceptChallenge (int myRequestId,int opponentRequestId,int opponentTeamId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/'+myRequestId.toString()+'/accept-match'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "joiningTicketId": opponentRequestId,
        "teamId": opponentTeamId
      })
  );
  return response.body;
}

Future<MatchedRequest> getMatchedRequest (int requestId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/tickets/'+requestId.toString()+'/load-match'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  return parseMatchedRequest(response.body);

}

MatchedRequest parseMatchedRequest(String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return MatchedRequest.fromJson(parsed);
}







