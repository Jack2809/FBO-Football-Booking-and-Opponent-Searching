import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccessKey {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future<void> saveAccessKey(Future<UserModel> user) async{
    UserModel userTemp = await user;
    await _prefs.setString('userAccessKey', userTemp.accessToken);

}

 static String? getUserAccessKey(){
    return _prefs.getString('userAccessKey');
 }

}