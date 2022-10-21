import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class ClubCard extends StatelessWidget {
  Club club ;
  ClubCard({required this.club});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.2,
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: CircleAvatar(

              backgroundColor: Colors.white,
              child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/FPT_logo_2010.svg/640px-FPT_logo_2010.svg.png',fit: BoxFit.fill),
              radius: size.height * 0.07,
            ),
          ),

          SizedBox(width: 10.0,),
          Container(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(width: size.width * 0.8,child: Text('Tên CLB: '+ club.name,)),

                  Container(width: size.width * 0.8 ,child: Text('Số thành viên: ' ,)),

                  Container(width: size.width * 0.8,child: Text('Mô tả: '+ club.name,)),




                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}