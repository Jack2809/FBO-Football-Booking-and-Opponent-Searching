import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;

List<Player> parsePlayers(List responseBody){
  return responseBody.map<Player>((json) =>Player.fromJson(json)).toList();
}

Future<List<Player>> fetchPlayers() async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/players?pageNo=0&pageSize=100&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parsePlayers(map['playerList']);
}

Future<String> createPlayerInClub(PlayerCreationModel player,int clubId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/clubs/'+clubId.toString()+'/players'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        'age' : player.age,
        'email': player.email,
        'jerseyNo': player.jerseyNo,
        'phone': player.phone,
        'playerName' : player.name
      })
  );

  return response.body;
}

Future<String> deletePlayer(int playerId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.delete(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/players/'+playerId.toString()),
    headers:<String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
  );
  if(response.statusCode == 200){
    return 'Đã xóa cầu thủ';
  }else {
    return "Cầu thủ này còn thanh gia trong đội hình";
  }
}