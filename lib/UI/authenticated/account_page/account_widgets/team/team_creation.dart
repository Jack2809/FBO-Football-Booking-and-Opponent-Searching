import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Validator/team_validator.dart';
import 'package:football_booking_fbo_mobile/services/image_services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../constants.dart';


class CreateTeamPage extends StatefulWidget{

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> with InputTeamValidation{

  @override
  void dispose() {
    teamNameC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeamBloc>(context).listenerStream.listen((event) {
      if(event ==""){

      }else if(event == "Tạo đội thành công"){
        successfulDialog1Pop(context, event);
      }else if (event == "Tạo đội thất bại do tên đội đã được sử dụng"){
        failDialog(context, event);
      }else{
        errorDialog(context, event);
      }
    });
  }

  final formGlobalKey = GlobalKey<FormState>();

  final teamNameC = TextEditingController();

  final descriptionC = TextEditingController();

  String _imageLink = 'https://storage.googleapis.com/football-appilication.appspot.com/bb98c3bb-f1ce-4357-8663-eae0e37a6f15jpg';

  Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;
    final res = await uploadImage(image.path);
    setState(() {
      _imageLink = res ;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo đội hình',style: WhiteTitleText()),
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

                CircleAvatar(
                  backgroundImage: NetworkImage(_imageLink),
                  radius: size.height * 0.1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                              Icons.camera_alt, color: Colors.green),
                          onPressed: () {
                            pickImage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                    SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: teamNameC,
                        decoration: InputDecoration(
                          prefix: Icon(Icons.title) ,
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
                    SizedBox(height: size.height * 0.05,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: "Mô tả",
                          hintText: 'Nhập mô tả ở đây'
                        ),
                        controller: descriptionC,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        validator: (description){
                          if(isValidDescription(description)){
                            return null;
                          }
                          return "Mô tả đội hình phải trên 9 ký tự !";
                        },
                      ),

                    ),

                    SizedBox(height: size.height * 0.05,),

                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green,
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          if(formGlobalKey.currentState!.validate()) {
                            String teamName = teamNameC.text;
                            String description = descriptionC.text;
                            BlocProvider.of<TeamBloc>(context).add(CreateTeam(teamName: teamName,imageUrl: _imageLink,description:  description));
                            // Navigator.of(context).pop();
                          }
                        },
                        icon: Icon(Icons.add,color:Colors.white),
                        label: Text('Tạo đội hình',style: MyButtonText()),
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

