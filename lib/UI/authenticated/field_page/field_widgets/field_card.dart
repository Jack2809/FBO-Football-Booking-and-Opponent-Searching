import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import '../../../../Models/field_model.dart';


Widget FieldCard (BuildContext context, Field field,Size size){
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(5.0,0.0),
        ),
      ]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: size.height * 0.15,
          width: size.width * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(field.image),
                fit: BoxFit.fill,
            ),
          ),
        ),
           SizedBox(height:15.0,),

           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text('Tên sân bóng',style: HeadLine1(context),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Icon(FontAwesome.soccer_ball,size: 16,color: Colors.green,),
                     SizedBox(width:10.0,),
                     Container(
                       width: size.width * 0.34,
                       child: Text(
                         softWrap: true,
                         maxLines: 2,
                         field.name,
                         style:TextLine2(context),
                       ),
                     ),
                   ],
                 ),
               SizedBox(height:5.0,),
               Text('Giờ hoạt động',style: HeadLine1(context),),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Icon(FontAwesome.clock,size: 18,color: Colors.green,),
                   SizedBox(width:10.0,),
                   Container(
                     width: size.width * 0.34,
                     child: Text(
                       softWrap: true,
                       maxLines: 2,
                       timeFormat(field.openTime)+ "-" +timeFormat(field.closeTime) ,
                       style:TextLine2(context),
                     ),
                   ),
                 ],
               ),
               SizedBox(height:5.0,),
               Text('Khu vực',style: HeadLine1(context),),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Icon(Icons.place_outlined,size: 19,color: Colors.green,),
                   SizedBox(width:10.0,),
                   Container(
                     width: size.width * 0.33,
                     child: Text(
                       softWrap: true,
                       maxLines: 2,
                       field.districtName,
                       style:TextLine2(context),
                     ),
                   ),
                 ],
               ),

             ],
           ),

      ],
    ),
  );
}