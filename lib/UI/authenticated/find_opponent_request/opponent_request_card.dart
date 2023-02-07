import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_event.dart';
import 'package:football_booking_fbo_mobile/Models/booked_facility_post_model.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';
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
                    Row(
                      children: [
                        Icon(Icons.calendar_month,color: Colors.green,),
                        SizedBox(width: size.width * 0.02,),
                        Text('Ngày đá',style:HeadLine1(context)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.075,),
                        Text(dateFormat(myState.bookingDate),style:TextLine1(context,false),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer_sharp,color: Colors.green,),
                        SizedBox(width: size.width * 0.02,),
                        Text('Thời gian rảnh',style:HeadLine1(context)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.075,),
                        Text(timeFormat(myState.startFreeTime)+"-"+timeFormat(myState.endFreeTime),style:TextLine1(context,false)),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: size.width * 0.10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.hourglass_bottom,color: Colors.green,),
                        SizedBox(width: size.width * 0.02,),
                        Text('Thời lượng',style:HeadLine1(context)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.075,),
                        Text(myState.duration.toString()+" phút",style:TextLine1(context,false)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.type_specimen_outlined,color: Colors.green,),
                        SizedBox(width: size.width * 0.02,),
                        Text('Loại sân',style:HeadLine1(context)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.075,),
                        Text(myState.fieldTypeId == 1 ?"5 vs 5" : "7 vs 7",style:TextLine1(context,false)),
                      ],
                    ),

                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.place,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Khu vực: ',style: HeadLine1(context)),
                        TextSpan(text: myState.districtList.join(','),style:TextLine1(context,false)),
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
                Icon(Icons.group,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1(context)),
                          TextSpan(text: myState.teamName,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0,),
            myState.isRivalry?Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesome5.medal,color: Colors.green,),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: 'Điểm đội: ',style: HeadLine1(context)),
                              TextSpan(text: myState.teamScore.toStringAsFixed(1),style:TextLine1(context,false)),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.star,color: Colors.green,),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: 'Điểm đánh giá: ',style: HeadLine1(context)),
                              TextSpan(text: myState.reviewScore.toStringAsFixed(1)+" / "+ myState.reviewCount.toString(),style:TextLine1(context,false)),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesome5.font_awesome_flag,color: Colors.green,),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: 'Tổng trận: ',style: HeadLine1(context)),
                              TextSpan(text: myState.totalMatches.toString(),style:TextLine1(context,false)),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ):SizedBox(),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline,color: myState.status == 3 ? Colors.green : myState.expired ? Colors.red : Colors.green,),
                SizedBox(width: size.width * 0.02),
                Text('Trạng thái: ',style: HeadLine1(context),),
                myState.status == 3 ?Center(child: Text('Hoàn thành',style: StatusLine(context),))
                    : myState.status == 2 ? !myState.expired ?Center(child: Text('Đang đặt sân',style:  StatusLine(context),)):Center(child: Text('Hết hạn',style: ErrorText(context),))
                    :myState.status == 1 ? !myState.expired ?Center(child: Text('Tìm đối thủ',style:  StatusLine(context),)):Center(child: Text('Hết hạn',style: ErrorText(context),)):SizedBox(),
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
      height: requestItem.isRivalry?size.height * 0.30 : size.height * 0.24,
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
                Text('Loại sân',style: TextLine1(context,true)),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: Container(
                    child: requestItem.fieldTypeId == 1? Text("5vs5",style: MyButtonText()) : Text("7vs7",style: MyButtonText()),
                  ),
                ),
                SizedBox(height: size.height * 0.01,),
                Container(
                  padding: MyPaddingAll(),
                  child: requestItem.isRivalry ? Text('Tranh Tài',style:TextLine1(context, false),) : Text('Giao Hữu',style: TextLine1(context,false)),
                ),

                SizedBox(height: size.height * 0.01,),

                Center(
                  child: Container(
                    padding: MyPaddingAll(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: requestItem.expired? Colors.red:Colors.green,
                    ),
                    child: requestItem.status == 3? Text('Hoàn thành',style:MyButtonText(),)
                        : requestItem.status == 2 ? !requestItem.expired?Text('Đang đặt sân',style:MyButtonText(),) : Text('Hết hạn',style: MyButtonText())
                        : requestItem.status == 1 ? !requestItem.expired?Text('Tìm đối thủ',style:MyButtonText(),) : Text('Hết hạn',style: MyButtonText()):SizedBox(),
                  ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Icon(Icons.calendar_month,color: Colors.green,),
                  SizedBox(width: size.width * 0.01,),
                  Text('Ngày đá',style: HeadLine1(context)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: size.width * 0.07,),
                  Text(dateFormat(requestItem.bookingDate),style:TextLine1(context,false)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.hourglass_bottom,color: Colors.green,),
                  SizedBox(width: size.width * 0.01,),
                  Text('Thời lượng',style: HeadLine1(context)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: size.width * 0.07,),
                  Text(requestItem.duration.toString()+" phút",style:TextLine1(context,false)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_outlined,color: Colors.green,),
                  SizedBox(width: size.width * 0.01,),
                  Text('Thời gian rảnh',style: HeadLine1(context)),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: size.width * 0.07,),
                  Text(timeFormat(requestItem.startFreeTime) +"-"+timeFormat(requestItem.endFreeTime),style:TextLine1(context,false)),
                ],
              ),
              requestItem.isRivalry?Row(
                children: [
                  Icon(FontAwesome5.medal,color: Colors.green),
                  SizedBox(width: size.width *0.01),
                  Text('Điểm đội',style: HeadLine1(context)),
                ],
              ):SizedBox(),
              requestItem.isRivalry?Row(
                children: [
                  SizedBox(width: size.width * 0.07,),
                  Text(requestItem.teamScore.toStringAsFixed(1),style:TextLine1(context,false)),
                ],
              ):SizedBox(),
            ],
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
  void initState() {
    _isChallenge = widget.opponentRequestItem.status;
    super.initState();
  }

  int  _isChallenge = 0;


  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: widget.myRequest.isRivalry?size.height * 0.34 :size.height * 0.26,
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
                Icon(Icons.group,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1(context)),
                          TextSpan(text: widget.opponentRequestItem.teamName,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            widget.myRequest.isRivalry?Column(
                children: [
                  Row(
                    children: [
                      Icon(FontAwesome5.medal,color: Colors.green,),
                      SizedBox(width: size.width * 0.02,),
                      Text('Điểm đội: ',style: HeadLine1(context)),
                      Text(widget.opponentRequestItem.teamScore.toStringAsFixed(1),style:TextLine1(context,false)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.green,),
                      SizedBox(width: size.width * 0.02,),
                      Text('Điểm đánh giá: ',style: HeadLine1(context)),
                      Text(widget.opponentRequestItem.reviewScore.toStringAsFixed(1)+' / '+widget.opponentRequestItem.reviewCount.toString(),style:TextLine1(context,false)),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(FontAwesome5.flag,color: Colors.green,),
                      SizedBox(width: size.width * 0.02,),
                      Text('Tổng trận: ',style: HeadLine1(context)),
                      Text(widget.opponentRequestItem.totalMatches.toString(),style:TextLine1(context,false)),
                    ],
                  ),
            ]):SizedBox(),
            Row(
              children: [
                Icon(Icons.timer_sharp,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Thời gian rảnh: ',style: HeadLine1(context)),
                Text(timeFormat(widget.opponentRequestItem.startFreeTime)+"-"+timeFormat(widget.opponentRequestItem.endFreeTime),style:TextLine1(context,false)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.place,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Khu vực: ',style: HeadLine1(context)),
                          TextSpan(text: widget.opponentRequestItem.districtNames,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            _isChallenge == 0 ?Center(
              child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: widget.myRequest.expired?Colors.grey:Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton.icon(
                    onPressed:widget.myRequest.expired ? null : (){
                      setState(() {
                        // widget.opponentRequestItem.status = 1 ;
                        _isChallenge = 1 ;
                      });
                      BlocProvider.of<RecommendedRequestBloc>(context).add(SendChallengeRequest(myRequestId:widget.myRequest.id, opponentRequestId: widget.opponentRequestItem.id, myTeamId: widget.myRequest.teamId));
                    },
                    icon: Icon(RpgAwesome.crossed_swords,color: Colors.white),
                    label: Text('Thách đấu',style: MyButtonText(),))
              ),
            ) : Container(
                    height: size.height * 0.06,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton.icon(
                      onPressed: (){
                        _showCancelRequest();
                      },
                      icon: Icon(Icons.cancel_outlined,color: Colors.white),
                      label: Text('Hủy Bỏ',style: MyButtonText(),),
                    ),
                ),





          ],
        ),
      ),
    );
  }

  Future<dynamic> _showCancelRequest(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Hủy bỏ thách đấu',
      desc: 'Bạn thật sự muốn hủy bỏ thách đấu này ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        setState(() {
          _isChallenge = 0;
        });
        BlocProvider.of<RecommendedRequestBloc>(context)
            .add(CancelChallengeRequest(myRequestId: widget.myRequest.id, opponentRequestId: widget.opponentRequestItem.id));
      },
      btnCancelOnPress: (){
      },
    ).show();
  }


}

class WaitingRequestCard extends StatefulWidget {
  WaitingRequest requestItem;
  OpponentRequestDetailModel myRequest;
  final VoidCallback callBack;

  WaitingRequestCard({required this.requestItem,required this.myRequest,required this.callBack});

  @override
  State<WaitingRequestCard> createState() => _WaitingRequestCardState();
}

class _WaitingRequestCardState extends State<WaitingRequestCard> {

  bool _isClicked = false;

  @override
  State<WaitingRequestCard> createState() => _WaitingRequestCardState();


  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.27 ,
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
                Icon(Icons.group,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1(context)),
                          TextSpan(text: widget.requestItem.teamName,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            widget.myRequest.isRivalry?Row(
              children: [
                Icon(FontAwesome5.medal,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Điểm đội: ',style: HeadLine1(context)),
                Text(widget.requestItem.teamScore.toStringAsFixed(1),style:TextLine1(context,false)),
              ],
            ):SizedBox(),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.timer_outlined,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Thời gian rảnh: ',style: HeadLine1(context)),
                Text(timeFormat(widget.requestItem.startFreeTime)+"-"+timeFormat(widget.requestItem.endFreeTime),style:TextLine1(context,false)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.place,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Khu vực: ',style: HeadLine1(context)),
                          TextSpan(text: widget.requestItem.districts,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.40,
                  decoration: BoxDecoration(
                    color: widget.myRequest.expired?Colors.grey:Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
    child: !_isClicked?TextButton.icon(
                      onPressed: widget.myRequest.expired ? null : (){
    BlocProvider.of<WaitingRequestBloc>(context).add(AcceptWaitingRequestChallenge(myRequestId: widget.myRequest.id, opponentRequestId: widget.requestItem.id, opponentTeamId: widget.requestItem.teamId));
    setState(() {
    _isClicked = true;
    });
    showDialog(
      barrierDismissible: false,
        context: context,
        builder:(context){
          return Center(child: CircularProgressIndicator(color: Colors.green,semanticsLabel: 'Vui lòng chờ'),);
        } );
    Future.delayed(Duration(seconds:5),() {
      Navigator.of(context).pop();
      widget.callBack();
    });
    // Navigator.of(context).pop();
    },
                      icon: Icon(Icons.check,color: Colors.white),
                      label: Text('Chấp nhận',style: MyButtonText(),)):Center(child: Text('Vui lòng đợi',style: MyButtonText(),),),
                ),
                SizedBox(width: size.width * 0.05,),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.40,
                  decoration: BoxDecoration(
                    color: widget.myRequest.expired?Colors.grey:Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton.icon(
                      onPressed: widget.myRequest.expired ? null : (){
                        _showDeclineRequest();
                      },
                      icon: Icon(Icons.cancel_outlined,color: Colors.white),
                      label: Text('Từ chối ',style: MyButtonText(),)),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }

  Future<dynamic> _showDeclineRequest(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Từ chối yêu cầu',
      desc: 'Bạn thật sự muốn từ chối yêu cầu này ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<WaitingRequestBloc>(context)
            .add(DeclineWaitingRequestChallenge(myRequestId: widget.myRequest.id, opponentRequestId: widget.requestItem.id));
        Future.delayed(Duration(seconds:2),() => widget.callBack());
      },
      btnCancelOnPress: (){
      },
    ).show();
  }
}

class MatchedPostCard extends StatelessWidget {
  MatchedRequest matchedRequest;
  bool rivalry;

  MatchedPostCard({required this.matchedRequest,required this.rivalry});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.21,
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
                Icon(Icons.group,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Đội hình: ',style: HeadLine1(context)),
                          TextSpan(text: matchedRequest.teamName,style:TextLine1(context,false)),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            rivalry?Row(
              children: [
                Icon(FontAwesome5.medal,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Điểm đội: ',style: HeadLine1(context)),
                Text(matchedRequest.teamScore.toStringAsFixed(1),style:TextLine1(context,false)),
              ],
            ):SizedBox(),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.timer_outlined,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Thời gian rảnh: ',style: HeadLine1(context)),
                Text(timeFormat(matchedRequest.startFreeTime)+"-"+timeFormat(matchedRequest.endFreeTime),style:TextLine1(context,false)),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.place,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        children: [

                          TextSpan(text: 'Khu vực: ',style: HeadLine1(context)),
                          TextSpan(text: matchedRequest.districts,style:TextLine1(context,false)),
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

class BookedFacilityByPostCard extends StatelessWidget {
  BookedFacilityByPost bookedFacilityByPost;

  BookedFacilityByPostCard({required this.bookedFacilityByPost});
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.23,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.stadium,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Tên Sân',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                SizedBox(width: size.width * 0.1,),
                Text(bookedFacilityByPost.facilityName,style: TextLine1(context,false),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_month,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Ngày thi đấu',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                SizedBox(width: size.width * 0.1,),
                Text(dateFormat(bookedFacilityByPost.dateReserved),style: TextLine1(context,false),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later_outlined,color: Colors.green,),
                SizedBox(width: size.width * 0.02,),
                Text('Giờ Thi Đấu',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                SizedBox(width: size.width * 0.1,),
                Text(timeFormat(bookedFacilityByPost.startTime),style: TextLine1(context,false),),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class ConfirmFacility extends StatefulWidget {
   Facility facility;
   String startTime;
   OpponentRequestDetailModel myRequest;

  ConfirmFacility({required this.facility,required this.myRequest,required this.startTime});

  @override
  State<ConfirmFacility> createState() => _ConfirmFacilityState();
}

class _ConfirmFacilityState extends State<ConfirmFacility> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      // height: size.height * 0.23,
      // width: size.width * 0.9,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.stadium,color: Colors.green,),
                Text('Tên Sân',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                // SizedBox(width: size.width * 0.1,),
                Text(widget.facility.name,style: TextLine1(context,true),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_month,color: Colors.green,),
                // SizedBox(width: size.width * 0.02,),
                Text('Giờ đã đặt',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                // SizedBox(width: size.width * 0.1,),
                Text(widget.startTime,style: TextLine1(context,true),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later_outlined,color: Colors.green,),
                // SizedBox(width: size.width * 0.02,),
                Text('Thời lượng',style: HeadLine1(context),)
              ],
            ),
            Row(
              children: [
                // SizedBox(width: size.width * 0.1,),
                Text(timeFormat(widget.myRequest.duration.toString() + " phút"),style: TextLine1(context,true),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}