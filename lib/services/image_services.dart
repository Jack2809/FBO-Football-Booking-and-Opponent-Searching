
import 'dart:developer';
import 'dart:io';

import 'access_key_shared_references.dart';
import 'package:http/http.dart' as http;

Future<String> uploadImage (filePath) async {
  String accessKey = UserAccessKey.getUserAccessKey() ?? '';

  var request = http.MultipartRequest('POST', Uri.parse('https://football-booking-app.herokuapp.com/api/v1/upload'));
  request.headers.addAll({
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer '+ accessKey,
  });
  request.files.add(
      http.MultipartFile.fromBytes(
          'file',
          File(filePath).readAsBytesSync(),
          filename: filePath.split("/").last
  ));

  var res = await request.send();
  var responseStr = await res.stream.bytesToString();
  log(responseStr);
  return responseStr;
}