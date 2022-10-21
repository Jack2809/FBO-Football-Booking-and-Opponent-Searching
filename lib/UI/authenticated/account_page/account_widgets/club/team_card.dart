import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class TeamCard extends StatelessWidget{
  Team team;

  TeamCard({required this.team});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      width: size.width * 0.4,
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: Colors.black12,style: BorderStyle.solid)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(team.name),
        ],
      ),
    );
  }

}