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


TextStyle HeadLine (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 40.0,
  );
}

TextStyle HeadLine1 (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 25.0,
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
  return EdgeInsets.all(10.0);
}

EdgeInsetsGeometry MyPaddingLeftRight(){
  return EdgeInsets.only(
    left: 10.0,
    right: 10.0,
  );
}

TextStyle MyButtonText (){
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 20.0,
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


