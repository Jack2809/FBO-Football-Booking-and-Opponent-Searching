
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:intl/intl.dart';

List<Field> parseFields(List responseBody){
  return responseBody.map<Field>((json) =>Field.fromJson(json)).toList();
}

Future<List<Field>> searchFields(double duration,int fieldTypeId,String searchNameOrDistrict,String chosenDay)async{
  String accessKey = UserAccessKey.getUserAccessKey() ?? "";
  final now = DateFormat('yyyy-MM-dd HH:MM:ss');
  String nowStr = "";
  var chosenDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(chosenDay));
  var nowDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  if(chosenDate == nowDate){
    nowStr = now.format(DateTime.now().add(Duration(hours: 1)));
  }else{
    var finalChosenDay = DateTime.parse(chosenDay);
    nowStr = now.format(finalChosenDay);
  }
  // log(nowStr);
  // log(duration.toString());
  // log(fieldTypeId.toString());
  // log(searchNameOrDistrict);
  var response = await http.post(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/search?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers:<String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      },
      body : jsonEncode(<String,dynamic>{
        'duration' : duration,
        'fieldTypeId' : fieldTypeId,
        'searchString' : searchNameOrDistrict,
        'startDateTime' : nowStr
      })
  );
  Map map = jsonDecode(utf8.decode(response.bodyBytes));
  // log('status:'+response.statusCode.toString());
  // log(response.body);
  return parseFields(map['facilityList']);

}