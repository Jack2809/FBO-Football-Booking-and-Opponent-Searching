import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:intl/intl.dart';

class OpponentRequestCard extends StatelessWidget {
  OpponentRequest requestItem;

  OpponentRequestCard({required this.requestItem});

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.18,
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Loại sân',style: TextLine1(true)),
                CircleAvatar(
                  radius: 30,
                  child: requestItem.fieldTypeId == 1? Text("5 vs 5",style: MyButtonText()) : Text("7 vs 7",style: MyButtonText()),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Thời lượng',style: TextLine1(true)),
                Text(requestItem.duration.toString()+" phút",style:HeadLine1()),
                Text('Thời gian rảnh',style: TextLine1(true)),
                Text(timeFormat(requestItem.startFreeTime) +"-"+timeFormat(requestItem.endFreeTime),style:HeadLine1()),



              ],
            ),
          ),



        ],
      ),
    );
  }

}