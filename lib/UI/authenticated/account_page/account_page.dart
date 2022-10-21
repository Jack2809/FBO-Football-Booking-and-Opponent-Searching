import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_state.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:provider/provider.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import '../../../Models/team_model.dart';
import 'account_widgets/club/clubs_page.dart';
import 'account_widgets/edit_account/edit_account_page.dart';

class AccountPage extends StatefulWidget {
  
  AccountPage();

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {


  String accessKey = UserAccessKey.getUserAccessKey() ?? '';

  @override
  void initState() {

    super.initState();
    BlocProvider.of<UserBloc>(context).add(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    log("-------------------------------------------------------------------------");
    log("Access Key: " + accessKey);
    log("-------------------------------------------------------------------------");
    Size size = getSize(context);
    return Scaffold(
      body: Material(
        type: MaterialType.transparency,
        child: BlocBuilder<UserBloc,UserState>(
            builder:(context,state){
              if(state is LoadingUser){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(state is LoadedUser){
                return Container(
                  color: Colors.grey.withOpacity(0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SafeArea(
                        child: Center(
                          child: Stack(
                            children: [
                              Hero(
                                tag: 'account_image',
                                child: GestureDetector(
                                  onTap: () {
                                    _gotoImageDetailPage(context,state.user.image);
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        state.user.image),
                                    radius: size.height * 0.1,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.camera_alt),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),

                      Text(state.user.name,style: TextLine1(true),),
                      Text(state.user.email,style: TextLine1(false),),
                      SizedBox(height:20.0,),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditAccountPage(user: state.user)),
                            );
                          },
                          child: AccountCard(context, Icons.info_outline_rounded, "Chỉnh sửa thông tin")
                      ),
                      SizedBox(height:10.0,),

                      GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ClubPage()),
                            );
                          },
                          child: AccountCard(context, Icons.sports_soccer, "Câu lạc bộ của tôi")
                      ),
                      SizedBox(height:10.0,),
                      GestureDetector(
                        onTap: (){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Đăng xuất'),
                                content: Text('Bạn thật sự muốn đăng xuất ?'),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Đăng xuất'),
                                    onPressed: () {
                                      final provider = Provider.of<GoogleLoginProvider>(context,listen: false);
                                      provider.logout();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Hủy bỏ'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: AccountCard(context, Icons.exit_to_app_outlined, "Đăng xuất"),
                      ),
                    ],
                  ),
                );
              }
              else {
                return Center(child: Text('Something wrong!!'),);
              }
            }
        ),
      ),
    );
  }

  void _gotoImageDetailPage(BuildContext context,String image){
    Size size = getSize(context);
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
           height: size.height * 0.5,
          width:  size.width ,
          child: Center(
            child: Hero(
              tag: 'account_image',
              child: Container(
                height: size.height ,
                width: size.width,
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill
                  ),
                ) ,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget AccountCard(BuildContext context,IconData icon,String title){
    Size size = getSize(context);
    return Container(
      padding: MyPaddingLeftRight(),
      height: size.height * 0.1,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color:Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon,size: 30.0,color: Colors.green),
          SizedBox(width:5.0,),
          Text(title,style:TextLine1(false),),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),

    );
  }
}