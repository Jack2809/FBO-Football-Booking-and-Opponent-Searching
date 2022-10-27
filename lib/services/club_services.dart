



import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';

import '../Models/player_model.dart';

import 'package:http/http.dart' as http ;



List<Club> parseClubs(List responseBody){
  return responseBody.map<Club>((json) =>Club.fromJson(json)).toList();
}

Future<List<Club>> fetchClubs () async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseClubs(map['clubList']);

}

Future<String> createClub (String clubName) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs'),
    headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
    body : jsonEncode(<String,String>{
      'clubName' : clubName
    })
  );
  return response.body;
}

Future<String> deleteClub(int clubId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.delete(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs/'+clubId.toString()),
    headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
  );
  return response.body;
}