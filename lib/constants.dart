import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


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


TextStyle HeadLine (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 40.0,
  );
}

String convertDateTimeToTimeOfDay(BuildContext context,String dateTime){
  DateTime _dateTime = DateTime.parse(dateTime);
  return TimeOfDay.fromDateTime(_dateTime).format(context);
}

TextStyle HeadLine1 (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 20.0,
  );
}

TextStyle HeadLine2 (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 20.0,
  );
}

TextStyle TextLine (){
  return TextStyle(
    color: Colors.black,
    fontSize: 25.0,
  );
}

TextStyle TextLine1 (bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
    fontSize: 20.0,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle Black12TextLine (bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black26,
    fontSize: 20.0,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle TextLine3 (bool isBold){
  return TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    color: Colors.black,
    fontSize: 20.0,

  );
}

TextStyle TextLine2 (){
  return TextStyle(
    // fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 14.0,
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

TextStyle ErrorText (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: 20.0,
  );
}

Color primaryColor = Colors.white;


