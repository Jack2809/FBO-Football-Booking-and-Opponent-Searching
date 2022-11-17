import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

import 'match_history_card.dart';

class MatchHistoryDetail extends StatefulWidget{
  MatchHistory matchHistory;
  MatchHistoryDetail({required this.matchHistory});
  @override
  State<MatchHistoryDetail> createState() => _MatchHistoryDetailState();
}

class _MatchHistoryDetailState extends State<MatchHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết lịch sử trận đấu', style: WhiteTitleText()),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [

        ],
      ),
      body: Container(
        padding: MyPaddingAll10(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: size.height * 0.06,
                      ),
                      Text(widget.matchHistory.homeTeamName,style: TextLine1(true),),
                    ],
                  ),
                  Text('0-0',style: HeadLine(),),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: size.height * 0.06,
                        backgroundColor: Colors.green,
                      ),
                      Text(widget.matchHistory.awayTeamName,style: TextLine1(true),),
                    ],
                  ),
                ]
            ),

            SizedBox(height: 20.0,),

            Text('Thông tin trận',style: HeadLine1(),),
            SizedBox(height: 10.0,),
            Row(
                children: [
                  Icon(Icons.stadium,color: Colors.green),
                  SizedBox(width: 10.0,),
                  Text('Tên sân:'+widget.matchHistory.facilityName,style: TextLine1(true),),
                ]
            ),
            SizedBox(height: 10.0,),
            Row(
                children: [
                  Icon(Icons.place,color: Colors.green),
                  SizedBox(width: 10.0,),
                  Text('Địa chỉ:'+widget.matchHistory.address+" "+widget.matchHistory.district,style: TextLine1(true),),
                ]
            ),
            SizedBox(height: 10.0,),
            Row(
                children: [
                  Icon(Icons.calendar_month,color: Colors.green),
                  SizedBox(width: 10.0,),
                  Text('Ngày đá:...........',style: TextLine1(true),),
                ]
            ),
            SizedBox(height: 10.0,),
            Row(
                children: [
                  Icon(Icons.timer,color: Colors.green),
                  SizedBox(width: 10.0,),
                  Text('Giờ đá:'+timeFormat(widget.matchHistory.startTime)+"-"+timeFormat(widget.matchHistory.endTime),style: TextLine1(true),),
                ]
            ),
            SizedBox(height: 20.0,),
            Text('Cầu thủ đối phương',style: HeadLine1(),),
            SizedBox(height: 10.0),
            HistoryPlayerCard(),




          ],
        ),
      ),

    );
  }
}