import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_event.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/find_opponent_request/opponent_request_detail.dart';
import 'package:football_booking_fbo_mobile/constants.dart';


class RequestInformationCard extends StatelessWidget{
  OpponentRequestDetailModel myState;
  RequestInformationCard({required this.myState});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      padding: MyPaddingAll(),
      child: Container(
        padding: MyPaddingAll(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(
                  0.0,
                  2.0,
                ),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ngày đá',style:HeadLine1()),
                    Text(dateFormat(myState.bookingDate),style:TextLine1(true),),
                    Text('Thời gian rảnh',style:HeadLine1()),
                    Text(timeFormat(myState.startFreeTime)+"-"+timeFormat(myState.endFreeTime),style:TextLine1(true)),
                  ],
                ),
                SizedBox(width: size.width * 0.25,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Thời lượng',style:HeadLine1()),
                    Text(myState.duration.toString()+" phút",style:TextLine1(true)),
                    Text('Loại sân',style:HeadLine1()),
                    Text(myState.fieldTypeId == 1 ?"5 vs 5" : "7 vs 7",style:TextLine1(true)),

                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Khu vực: ',style: HeadLine1()),
                        TextSpan(text: myState.districtList.join(','),style:TextLine1(true)),
                      ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1()),
                          TextSpan(text: myState.teamName,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class OpponentRequestCard extends StatelessWidget {

  OpponentRequest requestItem;

  OpponentRequestCard({required this.requestItem});

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.21,
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]

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
                SizedBox(height: 10.0,),
                Container(
                  padding: MyPaddingAll(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green,
                  ),
                  child: requestItem.isRivalry ? Text('Tranh Tài',style:MyButtonText(),) : Text('Giao Hữu',style: MyButtonText()),
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
                Text('Ngày đá',style: TextLine1(true)),
                Text(dateFormat(requestItem.bookingDate),style:HeadLine1()),



              ],
            ),
          ),



        ],
      ),
    );
  }

}

class RecommendedRequestCard extends StatefulWidget {
  RecommendedRequest opponentRequestItem;
  OpponentRequestDetailModel myRequest;

  RecommendedRequestCard({required this.opponentRequestItem,required this.myRequest});

  @override
  State<RecommendedRequestCard> createState() => _RecommendedRequestCardState();
}

class _RecommendedRequestCardState extends State<RecommendedRequestCard> {




  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.26,
      width: size.width * 0.9,
      padding: MyPaddingAll10(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(
              0.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1()),
                          TextSpan(text: widget.opponentRequestItem.teamName,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Điểm trình độ: ',style: HeadLine1()),
                Text("...",style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Thời gian rảnh: ',style: HeadLine1()),
                Text(timeFormat(widget.opponentRequestItem.startFreeTime)+"-"+timeFormat(widget.opponentRequestItem.endFreeTime),style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Khu vực: ',style: HeadLine1()),
                          TextSpan(text: widget.opponentRequestItem.districtNames,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            widget.opponentRequestItem.status == 0 ?Center(
              child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton.icon(
                    onPressed: (){
                      setState(() {
                        widget.opponentRequestItem.status = 1 ;
                      });
                      BlocProvider.of<RecommendedRequestBloc>(context).add(SendChallengeRequest(myRequestId:widget.myRequest.id, opponentRequestId: widget.opponentRequestItem.id, myTeamId: widget.myRequest.teamId));
                    },
                    icon: Icon(RpgAwesome.crossed_swords,color: Colors.white),
                    label: Text('Thách đấu',style: MyButtonText(),))
              ),
            ) : Center(
              child: Container(
                height: size.height * 0.06,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(child: Text('Đang chờ',style: MyButtonText(),))
              ),
            )



          ],
        ),
      ),
    );
  }
}

class WaitingRequestCard extends StatefulWidget {
  WaitingRequest requestItem;
  OpponentRequestDetailModel myRequest;

  WaitingRequestCard({required this.requestItem,required this.myRequest});

  @override
  State<WaitingRequestCard> createState() => _WaitingRequestCardState();
}

class _WaitingRequestCardState extends State<WaitingRequestCard> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.26,
      width: size.width * 0.9,
      padding: MyPaddingAll10(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
          color: Colors.grey,
          offset: const Offset(
            0.0,
            2.0,
          ),
          blurRadius: 5.0,
          spreadRadius: 1.0,
        ),
        ]
      ),
      child: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1()),
                          TextSpan(text: widget.requestItem.teamName,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Điểm trình độ: ',style: HeadLine1()),
                Text("...",style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Thời gian rảnh: ',style: HeadLine1()),
                Text(timeFormat(widget.requestItem.startFreeTime)+"-"+timeFormat(widget.requestItem.endFreeTime),style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Khu vực: ',style: HeadLine1()),
                          TextSpan(text: widget.requestItem.districts,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton.icon(
                    onPressed: (){
                      log("my request id:"+widget.myRequest.id.toString());
                      log("opponent request id:"+widget.requestItem.id.toString());
                      log("opponent team id :"+widget.requestItem.teamId.toString());
                      BlocProvider.of<WaitingRequestBloc>(context).add(AcceptWaitingRequestChallenge(myRequestId: widget.myRequest.id, opponentRequestId: widget.requestItem.id, opponentTeamId: widget.requestItem.teamId));
                    },
                    icon: Icon(RpgAwesome.crossed_swords,color: Colors.white),
                    label: Text('Chấp nhận',style: MyButtonText(),)),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

class MatchedPostCard extends StatelessWidget {
  MatchedRequest matchedRequest;

  MatchedPostCard({required this.matchedRequest});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.20,
      width: size.width * 0.9,
      padding: MyPaddingAll10(),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                0.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ]
      ),
      child: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1()),
                          TextSpan(text: matchedRequest.teamName,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Điểm trình độ: ',style: HeadLine1()),
                Text("...",style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Text('Thời gian rảnh: ',style: HeadLine1()),
                Text(timeFormat(matchedRequest.startFreeTime)+"-"+timeFormat(matchedRequest.endFreeTime),style:TextLine1(true)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Khu vực: ',style: HeadLine1()),
                          TextSpan(text: matchedRequest.districts,style:TextLine1(true)),
                        ]
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

}