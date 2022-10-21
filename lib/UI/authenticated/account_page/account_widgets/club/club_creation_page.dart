
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_state.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Validator/club_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class ClubCreationPage extends StatefulWidget {


  @override
  State<ClubCreationPage> createState() => _ClubCreationPageState();
}

class _ClubCreationPageState extends State<ClubCreationPage> with InputClubValidation{

  // TextEditingController imageC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  // TextEditingController descriptionC = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo CLB'),
      ),
      body: BlocListener<ClubBloc,ClubState>(
        listener: (context, state) {
          if(state is LoadedClubs){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Tạo thành công CLB', style:TextStyle(color:Colors.black),)));
          }
        },
        child: Form(
          key: formGlobalKey,
          child: Column(
            children: <Widget>[
              Text('Hình CLB',style: TextLine(),),

              TextFormField(
                controller: nameC,
                decoration: InputDecoration(
                  prefix: Icon(Icons.phone) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "Tên CLB",
                ),
                validator: (value){
                  if(isValidName(value)){
                    return null;
                  }
                  return "Phải trên 5 ký tự!";
                },
              ),

              // TextFormField(
              //   // controller: imageC,
              //   decoration: InputDecoration(
              //     prefix: Icon(Icons.person) ,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     labelText: "Hình",
              //   ),
              // ),

              // TextFormField(
              //   // controller: descriptionC,
              //   decoration: InputDecoration(
              //     prefix: Icon(Icons.mail) ,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     labelText: "Description",
              //   ),
              // ),

              Container(
                color: Colors.green,
                child: TextButton.icon(
                  onPressed: () {
                    if(formGlobalKey.currentState!.validate()){
                      formGlobalKey.currentState!.save();
                      String name = nameC.text;
                      BlocProvider.of<ClubBloc>(context).add(CreateClub(clubName:name));
                      Navigator.pop(context);
                    }

                  },
                  icon: Icon(Icons.person_add_rounded),
                  label: Text('Tạo CLB'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}