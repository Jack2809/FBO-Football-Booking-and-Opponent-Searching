import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class TeamCard extends StatelessWidget {
  Team team ;
  TeamCard({required this.team});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.2,
      padding: MyPaddingAll10(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 2.0
          ),
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: CircleAvatar(

              backgroundColor: Colors.white,
              child: Image.network(team.imageUrl,fit: BoxFit.fill),
              radius: size.height * 0.07,
            ),
          ),

          SizedBox(width: 10.0,),
          Container(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(width: size.width * 0.8,child: Text('Tên CLB: '+ team.name,)),

                  Container(width: size.width * 0.8 ,child: Text('Số thành viên: ' ,)),

                  Container(width: size.width * 0.8,child: Text('Mô tả: '+ team.description,)),

                  Container(width: size.width * 0.8,child: Text('Điểm đội: '+ team.teamScore.toString(),)),



                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}