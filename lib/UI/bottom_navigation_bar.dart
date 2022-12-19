import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_state.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/bill_pay/bill_pay_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/field_page/field_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/match_history/match_history_page.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:provider/provider.dart';

class MyPageControllerPage extends StatefulWidget{

  @override
  State<MyPageControllerPage> createState() => _MyPageControllerPageState();
}

class _MyPageControllerPageState extends State<MyPageControllerPage> {
  late PageController _pageController;

  int _selectedIndex = 0 ;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    BlocProvider.of<UserAccessBloc>(context).add(FetchUserAccess());

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration:Duration(milliseconds:500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return BlocBuilder<UserAccessBloc,UserAccessState>(
          builder:(context,state){
            if(state is LoadingUserAccess){
              return Center(child: CircularProgressIndicator(),);
            }else if(state is BannedAccount){
              return Scaffold(
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error,color: Colors.red, size: size.height * 0.1,),
                      SizedBox(height: size.height * 0.05),
                      Text('Tài khoản của bạn hiện tại đã bị hạn chế, vui lòng liên hệ admin FBO để biết thêm chi tiết',style: TextLine(context),textAlign: TextAlign.center),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black12),
                          color: Colors.green,
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text('OK',style:MyButtonText(),),
                          onPressed: () {
                            final provider = Provider.of<GoogleLoginProvider>(context,listen: false);
                            provider.logout();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );

            }
            else if(state is LoadedUserAccess){
              return Scaffold(
                body: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (newPage){
                    setState(() {
                      _selectedIndex = newPage;
                    });
                  },
                  children: [
                    FieldPage(),
                    OpponentRequestPage(),
                    MatchHistoryPage(),
                    BillPayPage(),
                    AccountPage(userId: state.user.id),
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
                        Icons.stadium,
                      ),
                      title: Text('Sân Bóng'),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(
                          Icons.person_search
                      ),
                      title: Text('Đối Thủ'),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(
                        RpgAwesome.soccer_ball,
                      ),
                      title: Text('Trận đấu'),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(
                        Icons.receipt_long,
                      ),
                      title: Text('Thanh toán'),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(
                          Icons.person
                      ),
                      title: Text('cá nhân'),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  isFloating: false,
                  elevation: 10.0,
                ),
              );
            }
            else {
              return Center(child: Text('Something wrong!!'),);
            }
          }
      );
  }
}




