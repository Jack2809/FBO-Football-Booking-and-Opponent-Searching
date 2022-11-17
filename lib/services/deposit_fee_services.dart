import 'dart:convert';
import 'dart:developer';

import 'package:football_booking_fbo_mobile/Models/deposit_fee_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;


DepositFeeModel parseDepositFee(String responseBody){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(responseBody.codeUnits));
  return DepositFeeModel.fromJson(parsed);
}

Future<DepositFeeModel> getDepositFee(int facilityId,double duration,int fieldTypeId,String startDateTime)async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  final response = await http.post(
    Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/'+facilityId.toString()+'/load-rental-fee'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer '+ accessKey,
    },
      body : jsonEncode(<String,dynamic>{
        "duration": duration,
        "fieldTypeId": fieldTypeId,
        "startDateTime": startDateTime
      })
  );
  log(response.body);
  return parseDepositFee(response.body);
}