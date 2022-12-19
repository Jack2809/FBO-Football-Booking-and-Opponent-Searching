import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
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

Future<UserInfoModel> getCurrentUser(int userId) async {
  log("(3)");
  var response = await http.get(Uri.parse('https://football-booking-app.herokuapp.com/api/v1/accounts/'+userId.toString()),
    headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  String finalResponse = jsonDecode(utf8.decode(response.bodyBytes)).toString();
  return parseUserInfoModel(response.body);

}


Future<String> updateUser (int userId,String email,String name,String image,String birthday,String phone,String address) async {

  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.put(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/accounts/'+userId.toString()),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,String>{
        "email": email,
      "address": address,
      "dateOfBirth": birthday,
      "image": image,
      "name": name,
      "phoneNumber": phone
      })
  );
  log('Update User Status:'+response.statusCode.toString());
  if(response.statusCode == 200){
    return "Cập nhật thành công";
  }else if (response.statusCode == 400){
    return "Cập nhật thất bại";
  }else{
    return "Server lỗi";
  }
}



