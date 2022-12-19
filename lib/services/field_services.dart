
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:intl/intl.dart';


Future<List<Field>> fetchFields(int districtId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/district/' +
          districtId.toString() +
          '/facilities?pageNo=0&pageSize=10&sortBy=id&sortDir=asc'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + accessKey,
      }
  );
  Map map = jsonDecode(utf8.decode(response.bodyBytes));

  return parseFields(map['facilityList']);
}



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
  log(response.statusCode.toString());
  return parseFields(map['facilityList']);

}


Future<Field> getFieldById(int fieldId) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';
  var response = await http.get(
      Uri.parse('https://football-booking-app.herokuapp.com/api/v1/facilities/'+fieldId.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+ accessKey,
      }
  );

  return parseField(response.body);
}

Field parseField(String response){
  Map<String,dynamic> parsed = jsonDecode(utf8.decode(response.codeUnits));
  return Field.fromJson(parsed);
}