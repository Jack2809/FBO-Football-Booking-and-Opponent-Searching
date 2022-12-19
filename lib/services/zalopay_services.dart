import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/zalopay_response_model.dart';

import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;


ZaloPayResponseModel parseZaloPayResponse (String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return ZaloPayResponseModel.fromJson(parsed);
}

Future<ZaloPayResponseModel> createOrder (int totalAmount) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/zalo-pay/create-order'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        "amount": totalAmount
      })
  );
  return parseZaloPayResponse(response.body);
}