import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_event.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/Validator/user_update_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:football_booking_fbo_mobile/services/image_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:intl/intl.dart';

class EditAccountPage extends StatefulWidget{
  UserInfoModel user ;

  EditAccountPage({required this.user});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> with InputUserUpdateValidation{


  @override
  void dispose() {
    nameC.dispose();
    dateOfBirthC.dispose();
    addressC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameC.text = widget.user.name;
    dateOfBirthC.text = widget.user.dateOfBirth;
    addressC.text = widget.user.address;
    phoneC.text = widget.user.phoneNumber;
    _birthday = DateFormat("yyyy-MM-dd").parse(widget.user.dateOfBirth);
    _imageLink = widget.user.image;
    super.initState();
    BlocProvider.of<UserBloc>(context).listenerStream.listen((event) {
      if(event ==""){

      }else if(event == "Cập nhật thành công"){
        successfulDialog1Pop(context, event);
      }else if (event == "Cập nhật thất bại"){
        failDialog(context, event);
      }else{
        errorDialog(context, event);
      }
    });
  }

  final formGlobalKey = GlobalKey<FormState>();

  var _birthday ;
  TextEditingController nameC = TextEditingController();
  TextEditingController dateOfBirthC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC  = TextEditingController();

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
        child: Form(
          key: formGlobalKey,
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
                  controller: nameC,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.person) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Họ và Tên",
                  ),
                  validator: (name){
                    if(isValidName(name)){
                      return null;
                    }
                    return "Tên không thể bỏ trống!";
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 5.0,
                      )
                    ]
                ),
                child: SizedBox(
                  height: size.height * 0.15,
                  child: ScrollDatePicker(
                    minimumDate: DateTime.now().subtract(Duration(days: 365 * 100)),
                    maximumDate: DateTime.now(),
                    selectedDate: _birthday,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _birthday = value;
                      });
                    },
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
                  validator: (phone){
                    if(isValidPhone(phone)){
                      return null;
                    }
                    return "không được bỏ trống và phải đúng 10 ký tự";
                  },
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
                  validator: (address){
                    if(isValidAdrress(address)){
                      return null;
                    }
                    return "Địa chỉ không được để trống và phải hơn 10 ký tự";
                  },
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
                      if(formGlobalKey.currentState!.validate()){
                        String birthday = DateFormat('yyyy-MM-dd').format(_birthday);
                        BlocProvider.of<UserBloc>(context).add(UpdateUser(userId: widget.user.id,email: widget.user.email,image: _imageLink, name: nameC.text, birthday: birthday, address: addressC.text, phone: phoneC.text));
                      }
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

      ),
    );
  }
}