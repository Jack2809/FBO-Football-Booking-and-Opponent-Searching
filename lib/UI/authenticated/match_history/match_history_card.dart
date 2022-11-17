import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class MatchHistoryCard extends StatefulWidget {
  MatchHistory matchHistory;

  MatchHistoryCard({required this.matchHistory});
  @override
  State<MatchHistoryCard> createState() => _MatchHistoryCardState();
}

class _MatchHistoryCardState extends State<MatchHistoryCard> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.12,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.matchHistory.homeTeamName,style: TextLine2(),),
              CircleAvatar(radius: size.height * 0.04,backgroundColor: Colors.green,),
              Text("VS",style: ErrorText(),),
              CircleAvatar(radius: size.height * 0.04,backgroundColor: Colors.green,),
              Text(widget.matchHistory.awayTeamName,style: TextLine2(),),
            ],
          ),
        ],
      ),
    );
  }
}

class HistoryPlayerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.07,
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
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person,color: Colors.green,),
          SizedBox(width: 10.0,),
          Text('Cầu thủ A',style: TextLine1(false),),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              child: Text('Đánh giá',style: WhiteTitleText(),),
              onPressed: (){

              },
            ),
          ),
        ],
      ),
    );
  }
}
