import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/UI/unauthenticated/login_page/player_match_history.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _primaryColor = Color.fromRGBO(25, 165, 74, 1);

  TextEditingController phoneC = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formGlobalKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: size.height * 0.2,
                    width:  size.width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/app_icon.png'),
                        fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text('Đăng Nhập',style: HeadLine(context),),
                  SizedBox(height: size.height * 0.2,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.phone) ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Số Điện Thoại",
                        hintText: "Nhập số điện thoại để xem lịch sử",
                      ),
                      validator: (phone){
                        if(phone!.isNotEmpty && phone.length == 10){
                          return null;
                        }
                        return "Số điện thoại không được để trống và phải 10 số";
                      },
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if(states.contains(MaterialState.pressed)){
                            return Colors.blue;
                          }
                          return Colors.green;
                        }
                        ),
                      ),
                      child: Text('Xem trận đấu'),
                      onPressed: (){
                        if(formGlobalKey.currentState!.validate()){
                          String phone = phoneC.text;
                          log(phone);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayerMatchHistoryPage(phoneNumber: phone,)));
                        }
                      }),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Divider(thickness: 1,color:Colors.black,height:100)),
                        Text('Hoặc'),
                        Expanded(child: Divider(thickness: 1,color:Colors.black,height:100)),
                      ],
                    ),
                  ),

                  Text('Đăng nhập với',style: TextStyle(color: _primaryColor)),

                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if(states.contains(MaterialState.pressed)){
                          return Colors.blue;
                        }
                        return Colors.green;
                      }
                      ),
                    ),
                    onPressed: () async {
                      final provider = Provider.of<GoogleLoginProvider>(context,listen: false);
                      provider.loginWithGoogle();
                    },
                    icon: Image.asset('assets/google.png',width: 30,height: 30 ),
                    label: Text('Google'), // <-- Text
                  ),



                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}