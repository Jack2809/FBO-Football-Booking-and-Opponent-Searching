


import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/Models/match_score.dart';
import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

List<MatchHistory> parseMatchHistory(List responseBody){
  // final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return responseBody.map<MatchHistory>((json) =>MatchHistory.fromJson(json)).toList();

}

Future<List<MatchHistory>> fetchMatchHistory(int teamId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()+'/match-history?pageNo=0&pageSize=10&sortBy=date&sortDir=desc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseMatchHistory(map['matchList']);
}


Future<String> submitScore (int matchId,int teamId,int homeScore,int awayScore) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/matches/'+matchId.toString()+'/score-update'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "awayScore": awayScore,
        "homeScore": homeScore,
        "teamId": teamId,
      })
  );
  log("submit score:"+response.statusCode.toString());
  return response.body;
}


Future<String> lockScore (int matchId,int teamId,bool rivalry) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/matches/'+matchId.toString()+'/lock-score'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "teamId": teamId,
        "rivalry": rivalry,
      })
  );
  log("lockScore:"+response.statusCode.toString());
  return response.body;
}


Future<MatchScores> getMatchScores (int matchId,int teamId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/matches/'+matchId.toString()+'/match-scores'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "teamId": teamId,
      })
  );
  log("getScores:"+response.statusCode.toString());
  return parseMatchScores(response.body);
}

MatchScores parseMatchScores(String response){
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.codeUnits));
  return MatchScores.fromJson(map);
}

