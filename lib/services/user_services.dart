import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:http/http.dart' as http;

UserModel parseUserModel (String response){
  // log(response.toString());
  var parsed = jsonDecode(response);
  return UserModel.fromJson(parsed);
}

Future<UserModel> fetchUserIdAndAccessToken () async {
  log("(2)");
  var token = await GoogleLoginProvider().getIDToken();
  log('--------------------------------------');
  log(token);
  log('--------------------------------------');

  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/auth/signin/firebase'),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,String>{
      'token' : token
    })
  );
  return parseUserModel(response.body);
}

UserInfoModel parseUserInfoModel (String response){
  var parsed = jsonDecode(response);
  Map<String,dynamic> parsed1 = jsonDecode(utf8.decode(response.codeUnits));
  return UserInfoModel.fromJson(parsed1);
}

Future<UserInfoModel> getCurrentUser() async {
  var userModel = await fetchUserIdAndAccessToken();
  log("(3)");
  var response = await http.get(Uri.parse('https://football-booking-app.herokuapp.com/api/v1/accounts/'+userModel.id.toString()),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  String finalResponse = jsonDecode(utf8.decode(response.bodyBytes)).toString();
  return parseUserInfoModel(response.body);

}

