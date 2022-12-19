

import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/district_model.dart';
import 'package:http/http.dart' as http;

import 'access_key_shared_references.dart';

List<District> parseDistricts(List responseBody){
  return responseBody.map<District>((json) =>District.fromJson(json)).toList();
}

Future<List<District>> fetchAllDistricts () async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/districts?pageSize=22'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseDistricts(map['districtList']);
}