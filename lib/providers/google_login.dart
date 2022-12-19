import 'dart:developer';
import 'package:flutter/cupertino.dart';
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
    return token;
  }



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