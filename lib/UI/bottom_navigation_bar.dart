import 'dart:developer';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/field_page/field_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_page.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:football_booking_fbo_mobile/services/user_services.dart';

import '../Models/team_model.dart';

class MyPageControllerPage extends StatefulWidget{

  @override
  State<MyPageControllerPage> createState() => _MyPageControllerPageState();
}

class _MyPageControllerPageState extends State<MyPageControllerPage> {
  late PageController _pageController;

  int _selectedIndex = 0 ;

  late Future<UserModel> userAccessKey;

  String accessKey = UserAccessKey.getUserAccessKey() ?? '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    userAccessKey = fetchUserIdAndAccessToken();
    UserAccessKey.saveAccessKey(userAccessKey);

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration:Duration(milliseconds:500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newPage){
          setState(() {
            _selectedIndex = newPage;
          });
        },
         children: [
           FieldPage(),
           OpponentRequestPage(),
           AccountPage(),
         ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Colors.green,
        strokeColor: Colors.green,
        unSelectedColor: Colors.grey[600],
        backgroundColor: Colors.white,
        borderRadius: Radius.circular(20.0),
        items: [
          CustomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              Icons.person_search
            ),
          ),

          CustomNavigationBarItem(
            icon: Icon(
              Icons.person
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        isFloating: true,
        elevation: 10.0,
      ),
    );
  }
}