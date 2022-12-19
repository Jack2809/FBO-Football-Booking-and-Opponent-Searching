


import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;


List<Team> parseTeams(List responseBody){
  return responseBody.map<Team>((json) =>Team.fromJson(json)).toList();

}

Future<List<Team>> fetchTeams()async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseTeams(map['teamList']);
}


Future<String> createTeam (String teamName,String description,String imageUrl) async {

  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.post(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,String>{
        "description": description,
        "imageUrl": imageUrl,
        "teamName": teamName,
      })
  );
  if(response.statusCode == 200){
    log(response.body);
    return 'Tạo đội thành công';
  }else if(response.statusCode == 400){
    return 'Tạo đội thất bại do tên đội đã được sử dụng';
  }else{
    return 'Server lỗi';
  }
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
  if(response.statusCode == 200){
    return 'Bạn đã xóa đội';
  }else if (response.statusCode == 404){
    return 'Xóa đội thất bại';
  }else{
    return 'Server Lỗi';
  }
}


TeamDetail parseTeamDetail(String responseBody){
  Map<String,dynamic> map = jsonDecode(utf8.decode(responseBody.codeUnits));
  return TeamDetail.fromJson(map);
}

Future<TeamDetail> fetchTeamDetail(int teamId)async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  return parseTeamDetail(response.body);
}

Future<String> updateTeam (int teamId,String teamName,String description,String imageUrl) async {

  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.put(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,String>{
        "description": description,
        "imageUrl": imageUrl,
        "teamName": teamName,
      })
  );
  log("update team status :"+response.statusCode.toString());
  if(response.statusCode == 200){
    return 'Cập nhật thành công';
  }else if(response.statusCode == 400){
    return 'Cập nhật thất bại';
  }else{
    return 'Server lỗi';
  }
}

Future<String> joinAsPlayer (int teamId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  log("AccessKey: "+accessKey);
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/teams/'+teamId.toString()+'/join-as-player'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
  );

  return response.body;
}