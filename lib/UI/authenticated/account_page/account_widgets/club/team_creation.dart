import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/Validator/club_validator.dart';
import 'package:football_booking_fbo_mobile/Validator/team_validator.dart';

import '../../../../../constants.dart';

class CreateTeamPage extends StatefulWidget{
  Club club;
  CreateTeamPage({required this.club});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> with InputTeamValidation{

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    teamNameC.dispose();
    super.dispose();
  }

  final teamNameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đội hình',style: TextLine1(true)),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: teamNameC,
                        decoration: InputDecoration(
                          prefix: Icon(Icons.person) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: "Tên đội hình",
                        ),
                        validator: (teamName){
                          if(isValidName(teamName)){
                            return null;
                          }
                          return "Tên Đội Hình phải trên 5 ký tự !";

                        },
                      ),
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green,
        ),
        child: TextButton.icon(
          onPressed: () {
            if(formGlobalKey.currentState!.validate()) {
              String teamName = teamNameC.text;
              BlocProvider.of<TeamBloc>(context).add(
                  CreateTeam(clubId: widget.club.id, teamName: teamName));
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.add,color:Colors.white),
          label: Text('Tạo đội hình',style: MyButtonText()),
        ),
      ),
    );
  }

}

