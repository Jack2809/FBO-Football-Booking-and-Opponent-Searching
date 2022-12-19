


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_event.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/Validator/team_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/services/image_services.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTeamPage extends StatefulWidget{
  Team team;

  UpdateTeamPage({required this.team});

  @override
  State<UpdateTeamPage> createState() => _UpdateTeamPageState();
}

class _UpdateTeamPageState extends State<UpdateTeamPage> with InputTeamValidation{

  @override
  void dispose() {
    descriptionC.dispose();
    super.dispose();
  }

  @override
  void initState() {
      super.initState();
      descriptionC.text = widget.team.description;
      _imageLink = widget.team.imageUrl;

      BlocProvider.of<TeamDetailBloc>(context).listenerStream.listen((event) {
        if(event ==""){

        }else if(event == "Cập nhật thành công"){
          successfulDialog1Pop(context, event);
        }else if (event == "Cập nhật thất bại"){
          failDialog(context, event);
        }else{
          errorDialog(context, event);
        }
        super.initState();
      });
  }

  final formGlobalKey = GlobalKey<FormState>();

  final descriptionC = TextEditingController();

  String _imageLink = '';

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
        title: Text('Đội hình '+widget.team.name,style: WhiteTitleText()),
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
                              icon: Icon(Icons.camera_alt,color: Colors.green),
                              onPressed: (){
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
                        )
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
                            String description = descriptionC.text;
                            BlocProvider.of<TeamDetailBloc>(context).add(UpdateTeam(teamId: widget.team.id,teamName: widget.team.name,imageUrl: _imageLink,description:  description));
                            BlocProvider.of<TeamBloc>(context).add(FetchTeams());
                          }
                        },
                        icon: Icon(Icons.edit,color:Colors.white),
                        label: Text('Cập nhật đội hình',style: MyButtonText()),
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