


import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

List<MatchHistory> parseMatchHistory(List responseBody){
  // final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return responseBody.map<MatchHistory>((json) =>MatchHistory.fromJson(json)).toList();

}

Future<List<MatchHistory>> fetchMatchHistory(int teamId)async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()+'/match-history?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseMatchHistory(map['matchList']);
}