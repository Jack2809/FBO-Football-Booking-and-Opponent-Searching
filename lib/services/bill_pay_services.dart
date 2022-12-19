

import 'dart:convert';

import 'package:football_booking_fbo_mobile/Models/bill_pay.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:http/http.dart' as http;

List<BillPay> parseBillPay(List responseBody){
  return responseBody.map<BillPay>((json) =>BillPay.fromJson(json)).toList();
}

Future<List<BillPay>> fetchBillPay () async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  var response = await http.get(

      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/transaction-history?pageNo=0&pageSize=50&sortBy=id&sortDir=asc'),

      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );
  Map<String,dynamic> map = jsonDecode(utf8.decode(response.bodyBytes));
  return parseBillPay(map['billPayList']);

}