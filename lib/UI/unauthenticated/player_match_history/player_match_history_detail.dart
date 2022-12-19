import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class PlayerMatchHistoryDetail extends StatefulWidget{
  MatchHistory matchHistory;
  PlayerMatchHistoryDetail({required this.matchHistory});
  @override
  State<PlayerMatchHistoryDetail> createState() => _PlayerMatchHistoryDetailState();
}

class _PlayerMatchHistoryDetailState extends State<PlayerMatchHistoryDetail> {

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.matchHistory.homeTeamImage),
                          radius: size.height * 0.06,
                        ),
                        Text(widget.matchHistory.homeTeamName,style: TextLine1(context,true),),
                      ],
                    ),
                    Column(
                      children: [
                        Text('V/S',style: HeadLine(context),),
                        Container(
                            width: size.width * 0.2,
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green
                            ),
                            child: widget.matchHistory.rivalry ? Center(child: Text('Tranh Tài',style:MyButtonText(),)) : Center(child: Text('Giao Hữu',style:MyButtonText(),))
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: size.height * 0.06,
                          backgroundImage: NetworkImage(widget.matchHistory.awayTeamImage),
                        ),
                        Text(widget.matchHistory.awayTeamName,style: TextLine1(context,true),),
                      ],
                    ),
                  ]
              ),

              SizedBox(height: 20.0,),

              SizedBox(height:20.0,),

              Text('Thông tin trận',style: HeadLine1(context),),
              SizedBox(height: 10.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.stadium,color: Colors.green),
                  SizedBox(width: 10.0,),
                  Expanded(child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text:'Tên sân: ',style: HeadLine1(context)),
                      TextSpan(text: widget.matchHistory.facilityName,style: TextLine1(context,true))
                    ],
                  )),
                  )],
              ),
              SizedBox(height: 10.0,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.place,color: Colors.green),
                    SizedBox(width: 10.0,),
                    Expanded(child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text:'Địa chỉ: ',style: HeadLine1(context)),
                        TextSpan(text: widget.matchHistory.address +" - "+widget.matchHistory.district,style: TextLine1(context,true))
                      ],
                    )),
                    )
                  ]
              ),
              SizedBox(height: 10.0,),
              Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.green),
                    SizedBox(width: 10.0,),
                    Expanded(child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text:'Ngày đá: ',style: HeadLine1(context)),
                        TextSpan(text: dateFormat(widget.matchHistory.bookingDate),style: TextLine1(context,true))
                      ],
                    )),
                    )]
              ),
              SizedBox(height: 10.0,),
              Row(
                  children: [
                    Icon(Icons.timer,color: Colors.green),
                    SizedBox(width: 10.0,),
                    Expanded(child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text:'Giờ đá: ',style: HeadLine1(context)),
                        TextSpan(text: timeFormat(widget.matchHistory.startTime)+" - " +timeFormat(widget.matchHistory.endTime),style: TextLine1(context,true))
                      ],
                    )),
                    )
                  ]
              ),
              SizedBox(height: 20.0,),
              Text('Cầu thủ đối phương',style: HeadLine1(context),),
              SizedBox(height: 10.0),


            ],
          ),
        ),
      ),

    );
  }

}