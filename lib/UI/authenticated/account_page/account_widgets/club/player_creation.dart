
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Validator/player_validator.dart';

import '../../../../../constants.dart';

class CreatePlayerPage extends StatefulWidget{
  Club club;
  CreatePlayerPage({required this.club});

  @override
  State<CreatePlayerPage> createState() => _CreatePlayerPageState();
}

class _CreatePlayerPageState extends State<CreatePlayerPage> with InputPlayerValidation{

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameC.dispose();
    phoneC.dispose();
    emailC.dispose();
    jerseyNoC.dispose();
    ageC.dispose();
    super.dispose();
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jerseyNoC = TextEditingController();
  TextEditingController ageC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo Cầu Thủ',style: TextLine1(true)),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formGlobalKey,
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                padding: MyPaddingAll(),
                // height:size.height,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.02),
                  // borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: nameC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Tên cầu thủ",
                      ),
                      validator: (name){
                        if(isValidName(name)){
                          return null;
                        }
                        return "Tên Cầu Thủ không được để trống !";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: phoneC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Số Điện Thoại",
                      ),
                      validator: (phone){
                        if(isValidPhone(phone)){
                          return null;
                        }
                        return "Số Điện Thoại không được để trống và phải 10 số !";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: emailC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Email",
                      ),
                      validator: (email){
                        if(isValidEmail(email)){
                          return null;
                        }
                        return "Email không được để trống và phải đạt chuẩn!";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: jerseyNoC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Số Áo",
                      ),
                      validator: (jersey){
                        if(isValidJersey(jersey)){
                          return null;
                        }
                        return "Số Áo không được để trống hoặc số âm !";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: ageC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        labelText: "Tuổi",
                      ),
                      validator: (age){
                        if(isValidAge(age)){
                          return null;
                        }
                        return "Số Tuổi không được để trống và số âm !";
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: Container(
        color: Colors.green,
        child: TextButton.icon(
          onPressed: () {
            if(formGlobalKey.currentState!.validate()) {
              if(formGlobalKey.currentState!.validate()) {
                log('Processing!!!');
                var name = nameC.text;
                var phone = phoneC.text;
                var email = emailC.text;
                var jerseyNo = jerseyNoC.text;
                var age = ageC.text;
                var newPlayer = PlayerCreationModel(
                    name: name,
                    phone: phone,
                    jerseyNo: int.parse(jerseyNo),
                    email: email,
                    age: int.parse(age));
                BlocProvider.of<PlayerClubBloc>(context).add(CreatePlayer(clubId: widget.club.id, createdPlayer: newPlayer));
                nameC.text = "";
                phoneC.text = "";
                emailC.text = "";
                jerseyNoC.text = "";
                ageC.text = "";
                Navigator.of(context).pop();
              }

            }
          },
          icon: Icon(Icons.add,color:Colors.black),
          label: Text('Tạo đôi hình',style: TextLine2()),
        ),
      ),
    );
  }

}