

import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/match_history.dart';

import 'package:http/http.dart' as http;

List<MatchHistory> parsePlayerMatchHistory(List responseBody){
  return responseBody.map<MatchHistory>((json) =>MatchHistory.fromJson(json)).toList();

}

Future<List<MatchHistory>> fetchPlayerMatchHistory(String phoneNumber) async {
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/match-history?pageNo=0&pageSize=50&playerPhone='+phoneNumber+'&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );

  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parsePlayerMatchHistory(map['matchList']);
}