


import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;


List<Team> parseTeams(List responseBody){
  // final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return responseBody.map<Team>((json) =>Team.fromJson(json)).toList();

}

Future<List<Team>> fetchTeams(int clubId)async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs/'+clubId.toString()+'/teams?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseTeams(map['teamList']);
}

Future<String> createTeam (int clubId,String teamName) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.post(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs/'+clubId.toString()+'/teams'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,String>{
        'teamName' : teamName
      })
  );
  return response.body;
}

Future<String> deleteTeam(int teamId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.delete(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()),
    headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
  );
  return response.body;
}