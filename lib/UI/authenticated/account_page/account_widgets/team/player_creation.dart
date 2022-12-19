import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/Validator/player_validator.dart';
import '../../../../../constants.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class CreateTeamPlayerPage extends StatefulWidget{
  Team team;
  CreateTeamPlayerPage({required this.team});

  @override
  State<CreateTeamPlayerPage> createState() => _CreateTeamPlayerPageState();
}

class _CreateTeamPlayerPageState extends State<CreateTeamPlayerPage> with InputPlayerValidation{

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
  void initState() {
    super.initState();
    BlocProvider.of<PlayerTeamBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      } else if(event == "Tạo cầu thủ thành công"){
          successfulDialog1Pop(context, event);
        }else if(event == "Tạo cầu thủ thất bại do số điện thoại đã được sử dụng,vui lòng sử dụng SDT khác"){
          failDialog(context, event);
        }else{
          errorDialog(context, event);
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo Cầu Thủ',style: WhiteTitleText()),
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
                        prefix: Icon(Icons.person,color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Tên cầu thủ",
                      ),
                      validator: (name){
                        if(isValidName(name)){
                          return null;
                        }
                        return "Tên Cầu Thủ không được để trống hoặc nhỏ hơn 3 ký tự !";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.phone,color: Colors.green),
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
                        prefix: Icon(Icons.mail,color: Colors.green),
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
                      keyboardType: TextInputType.number,
                      controller: jerseyNoC,
                      decoration: InputDecoration(
                        prefix: Icon(FontAwesome5.tshirt,color: Colors.green,size: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: "Số Áo",
                      ),
                      validator: (jersey){
                        if(isValidJersey(jersey)){
                          return null;
                        }
                        return "Số Áo không được để trống hoặc số âm hoặc bằng 0!";
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ageC,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.cake_outlined,color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        labelText: "Tuổi",
                      ),
                      validator: (age){
                        if(isValidAge(age)){
                          return null;
                        }
                        return "Số Tuổi không được để trống và số âm và nhỏ hơn 4 !";
                      },
                    ),
                    SizedBox(height: size.height * 0.1,),

                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green,
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          if(formGlobalKey.currentState!.validate()) {
                            if(formGlobalKey.currentState!.validate()) {
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
                              BlocProvider.of<PlayerTeamBloc>(context).add(AddTeamPlayer(teamId: widget.team.id, newPlayer: newPlayer));
                            }

                          }
                        },
                        icon: Icon(Icons.add,color:Colors.white),
                        label: Text('Tạo cầu thủ',style: MyButtonText()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
      ),

    );
  }

}