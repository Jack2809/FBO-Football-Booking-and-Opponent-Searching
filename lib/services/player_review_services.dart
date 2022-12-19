

import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/player_review.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<List<PlayerReview>> fetchPlayerReviews (int matchId,int teamId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/matches/'+matchId.toString()+'/players-to-review'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "teamId": teamId
      })
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  log("review:"+response.statusCode.toString());
  return parsePlayerReviews(map['playerReviewsDTO']);
}

List<PlayerReview> parsePlayerReviews(List responseBody){
  return responseBody.map<PlayerReview>((json) =>PlayerReview.fromJson(json)).toList();

}


Future<String> createPlayerReview (int matchId,int playerId,String comment,int star) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/players/'+playerId.toString()+'/review'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "comment": comment,
        "matchId": matchId,
        "star": star
      })
  );
  log('create player review : '+response.statusCode.toString());
  log('create player message'+response.body);
  return response.body;
}




Future<String> updatePlayerReview (int matchId,int reviewId,String comment,int star) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.put(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/my-reviews/'+reviewId.toString()),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "comment": comment,
        "matchId": matchId,
        "star": star
      })
  );
  log("update player review: "+response.statusCode.toString());
  log('update player message: '+response.body);
  return response.body;
}

Future<String> lockPlayer (int playerId) async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/players/'+playerId.toString()+'/blacklist'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
  );
  log('Lock player status : '+response.statusCode.toString());
  log('Lock player message'+response.body);
  return response.body;
}