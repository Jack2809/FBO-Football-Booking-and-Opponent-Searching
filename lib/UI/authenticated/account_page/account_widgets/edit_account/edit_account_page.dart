import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class EditAccountPage extends StatefulWidget{
  UserInfoModel user ;

  EditAccountPage({required this.user});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {


  @override
  Widget build(BuildContext context) {

    TextEditingController nameC = TextEditingController(text: widget.user.name);
    TextEditingController dateOfBirthC = TextEditingController(text: widget.user.dateOfBirth);
    TextEditingController addressC = TextEditingController(text: widget.user.address);
    TextEditingController phoneC  = TextEditingController(text: widget.user.phoneNumber);


    Size size = getSize(context);
    return  Scaffold(
        appBar: AppBar(
          title: Text('Chỉnh sửa thông tin',style: WhiteTitleText()),
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
          shadowColor: Colors.grey.withOpacity(0.02),
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.white),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
        child: Container(
            padding: MyPaddingAll(),
        height:size.height,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.02),
          // borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.image),
              radius: size.height * 0.1,
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: nameC,
                decoration: InputDecoration(
                  prefix: Icon(Icons.person) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Họ và Tên",
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: dateOfBirthC,
                decoration: InputDecoration(
                  prefix: Icon(Icons.cake) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Ngày tháng năm sinh",
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: phoneC,
                decoration: InputDecoration(
                  prefix: Icon(Icons.phone) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Số Điện Thoại",
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                controller: addressC,
                decoration: InputDecoration(
                  prefix: Icon(Icons.home) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Địa chỉ",
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Center(
              child: SizedBox(
                width: size.width * 0.9,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return Colors.redAccent;
                      }
                      return Colors.green;
                    }
                    ),
                  ),
                  child: Text("Chỉnh sửa",style: MyButtonText()),
                  onPressed: (){

                    log(nameC.text);
                    // log(dateOfBirthC.text);
                    // log(phoneC.text);
                    // log(addressC.text);


                    // nameC.dispose();
                    // dateOfBirthC.dispose();
                    // phoneC.dispose();
                    // addressC.dispose();
                  },
                ),
              ),
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