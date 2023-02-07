import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Size getSize(BuildContext context){
  return MediaQuery.of(context).size;
}

String timeFormat (String time){
  var split = time.split(':');
  String finalTime = split[0]+":"+split[1];
  return finalTime;
}

String dateFormat(String date){
  var split = date.split('-');
  String finalDate = split[2]+"-"+split[1]+"-"+split[0];
  return finalDate;
}

String convertDate(String date){
  DateTime temp = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd').format(temp);
}

String convertTime(TimeOfDay time){
  DateTime tempDate = DateTime.now();
  DateTime date = DateTime(tempDate.year,tempDate.month,tempDate.day,time.hour,time.minute);
  return DateFormat('HH:mm:ss').format(date);
}

String convertTimeAndHour(String time){
  DateTime tempDate = DateTime.parse(time);
  return DateFormat('dd-MM-yyyy HH:mm').format(tempDate);
}


TextStyle HeadLine (BuildContext context){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: getSize(context).width * 0.1,
  );
}

TextStyle StatusLine (BuildContext context){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: getSize(context).width * 0.05,
  );
}

String convertDateTimeToTimeOfDay(BuildContext context,String dateTime){
  TimeOfDay temp = TimeOfDay(hour: int.parse(dateTime.split(":")[0]), minute: int.parse(dateTime.split(":")[1]));
  return temp.format(context);
}

// 40 px = size.width * 0.1

TextStyle HeadLine1 (BuildContext context){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: getSize(context).width * 0.05,
  );
}



TextStyle TextLine (BuildContext context){
  return TextStyle(
    color: Colors.black,
    fontSize: getSize(context).width * 0.0625,
  );
}

TextStyle TextLine1 (BuildContext context,bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
    fontSize: getSize(context).width * 0.05,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle DescriptionText (BuildContext context,bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
    fontSize: getSize(context).width * 0.0375,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle Black26TextLine (BuildContext context,bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black26,
    fontSize: getSize(context).width * 0.05,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle TextLine3 (BuildContext context,bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
    fontSize: getSize(context).width * 0.05,

  );
}

TextStyle TextLine2 (BuildContext context){
  return TextStyle(
    // fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: getSize(context).width * 0.035,
    overflow: TextOverflow.ellipsis,

  );
}

EdgeInsetsGeometry MyPaddingAll(){
  return EdgeInsets.all(5.0);
}

EdgeInsetsGeometry MyPaddingAll10(){
  return EdgeInsets.all(10.0);
}


EdgeInsetsGeometry MyPaddingLeftRight(){
  return EdgeInsets.only(
    left: 10.0,
    right: 10.0,
  );
}

TextStyle WhiteTitleText (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 20.0,
  );
}



TextStyle MyButtonText (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 15.0,
  );
}

TextStyle MyButtonText1 (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 15.0,
  );
}

TextStyle ErrorText (BuildContext context){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: getSize(context).width * 0.05,
  );
}

Color primaryColor = Colors.white;

Future<dynamic> errorDialog(BuildContext context,String content){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Lỗi',
    desc: content,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnOkOnPress: () {

    },
  ).show();
}

Future<dynamic> successfulDialog(BuildContext context,String content){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Thành Công',
    desc: content,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnOkOnPress: () {
    },
  ).show();
}

Future<dynamic> successfulDialog1Pop(BuildContext context,String content){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Thành Công',
    desc: content,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnOkOnPress: () {
      Navigator.of(context).pop();
    },
  ).show();
}

Future<dynamic> failDialog(BuildContext context,String content){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Thất Bại',
    desc: content,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnOkOnPress: () {

    },
  ).show();
}

Future<dynamic> announceInformation(BuildContext context,String content){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'Thông báo',
    desc: content,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnOkOnPress: () {

    },
  ).show();
}

String toVND (double amount){
  int money = amount.toInt() * 1000 ;
  var vietnameseCurrency = NumberFormat.currency(locale:'vi-VN',symbol: 'Đồng');
  return vietnameseCurrency.format(money);
}



