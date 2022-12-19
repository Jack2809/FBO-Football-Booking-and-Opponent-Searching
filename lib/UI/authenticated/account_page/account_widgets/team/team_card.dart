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
      height: size.height * 0.21,
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
              backgroundImage: NetworkImage(team.imageUrl),
              radius: size.height * 0.07,
            ),
          ),

          SizedBox(width: 10.0,),
          Container(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    Text('Tên: ',style: HeadLine1(context),),
                    SizedBox(width: size.width * 0.02,),
                    Text(team.name,style: TextLine1(context,false),)
                  ],),
                  SizedBox(width: size.height * 0.02,),
                  Row(children: [
                    Text('Điểm đội: ',style: HeadLine1(context),),
                    SizedBox(width: size.width * 0.02,),
                    Text(team.teamScore.toStringAsFixed(1),style: TextLine1(context,false),)
                  ],),
                  SizedBox(width: size.height * 0.02,),
                  Column(crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                    Text('Mô tả: ',style: HeadLine1(context),),
                    SizedBox(width: size.width * 0.02,),
                    Text(team.description,style: DescriptionText(context,false),maxLines: 3,)
                  ],),



                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}