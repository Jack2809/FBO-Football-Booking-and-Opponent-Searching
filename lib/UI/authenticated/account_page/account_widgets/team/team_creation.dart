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
  final formGlobalKey = GlobalKey<FormState>();

  XFile? image;

  //default image : https://storage.googleapis.com/football-appilication.appspot.com/f1294b59-50b6-4e8e-9899-8479bc47d6b6jpg

  String _imageLink = "https://storage.googleapis.com/football-appilication.appspot.com/f1294b59-50b6-4e8e-9899-8479bc47d6b6jpg";

  Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;
    final res = await uploadImage(image.path);
    setState(() {
      _imageLink = res ;
    });

  }

  final teamNameC = TextEditingController();

  final descriptionC = TextEditingController();

  @override
  void dispose() {
    teamNameC.dispose();
    descriptionC.dispose();
    super.dispose();
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
                    Center(
                      child: Container(
                        height: size.height * 0.16,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: NetworkImage(_imageLink),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom:0,
                              child: GestureDetector(
                                onTap: () =>pickImage(),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.camera_alt,color:Colors.white,),
                                  radius: 15.0,
                                ),
                              ),
                            ),
                          ],
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
                    SizedBox(height: 20.0,),

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
                          hintText: "Viết mô tả ở đây",
                        ),
                        controller: descriptionC,
                        minLines: 6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (description){
                          if(isValidDescription(description)){
                            return null;
                          }
                          return "Tên Đội Hình phải trên 10 ký tự !";
                        },
                      ),
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
                            String teamName = teamNameC.text;
                            String description = descriptionC.text;
                            BlocProvider.of<TeamBloc>(context).add(CreateTeam(teamName: teamName,description:description,imageUrl: _imageLink));
                            Navigator.pop(context,'Đội hình của bạn đã được tạo');

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

