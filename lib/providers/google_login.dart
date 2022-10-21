import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:football_booking_fbo_mobile/services/user_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class GoogleLoginProvider extends ChangeNotifier{

  final googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<String> getIDToken() async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken(false);
    // log('------------------------------------------------------------------');
    // log(token);
    // log('------------------------------------------------------------------');
    return token;
  }

  // Future<UserInfoModel> getCurrentUser() async {
  //   var userModel = await fetchUserIdAndAccessToken();
  //   var response = await http.get(Uri.parse('https://football-booking-app.herokuapp.com/api/v1/accounts/'+userModel.id.toString()));
  //   log(response.body);
  //   var userInfo = parseUserInfoModel(response.body);
  //   log(userInfo.phoneNumber.toString());
  //   return parseUserInfoModel(response.body);
  //
  // }


  Future<void> loginWithGoogle() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null ){
      return;
    }

    _user = googleUser;

    final googleAuth = await _user!.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    log("(1)");


    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();

    notifyListeners();
  }



}