import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_event.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/Models/player_review.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/match_history/update_player_review_page.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/match_history/view_player_review_page.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'create_player_review_page.dart';

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
      height: size.height * 0.15,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Text(widget.matchHistory.homeTeamName,style: TextLine2(context),),
              CircleAvatar(
                radius: size.height * 0.05,
                backgroundImage: NetworkImage(widget.matchHistory.homeTeamImage)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("VS",style: ErrorText(context),),
              Text(dateFormat(widget.matchHistory.bookingDate)),
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
              Text(widget.matchHistory.awayTeamName,style: TextLine2(context),),
              CircleAvatar(
                radius: size.height * 0.05,
                backgroundImage: NetworkImage(widget.matchHistory.awayTeamImage)),
            ],
          ),

        ],
      ),
    );
  }
}

class HistoryPlayerCard extends StatefulWidget {
  final int matchId;
  final int teamId;
  PlayerReview playerReview;
  HistoryPlayerCard({required this.playerReview,required this.matchId,required this.teamId});
  @override
  State<HistoryPlayerCard> createState() => _HistoryPlayerCardState();
}

class _HistoryPlayerCardState extends State<HistoryPlayerCard> {
  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Container(
      height: size.height * 0.2,
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
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundImage: AssetImage('assets/player_icon.png'),
                  backgroundColor: Colors.green,radius: size.width * 0.06),
              SizedBox(width: size.width * 0.02,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Icon(Icons.person,color: Colors.green),
                      SizedBox(width: size.width * 0.02,),
                      Text(widget.playerReview.playerName),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01,),
                  Row(
                    children: [
                      Icon(widget.playerReview.star == 0 ?Fontelico.emo_happy:widget.playerReview.star.isNegative?Fontelico.emo_unhappy:Fontelico.emo_thumbsup,color: Colors.green),
                      SizedBox(width: size.width * 0.04,),
                      Text(widget.playerReview.star == 0 ? "Chưa đánh giá":widget.playerReview.star.isNegative?"Xấu":"Tốt"),
                    ],
                  ),

                ],
              ),

            ],
          ),
          SizedBox(height: size.height * 0.02),
          !widget.playerReview.isReviewed? Container(
            width: size.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              child: Text('Đánh giá',style: WhiteTitleText(),),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> CreatePlayerReviewPage(
                  playerReview: widget.playerReview,
                  matchId: widget.matchId,
                  myTeamId: widget.teamId,
                )));
              },
            ),
          ):Row(
            children: [
              Container(
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text('Cập nhật',style: WhiteTitleText(),),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> UpdatePlayerReviewPage(
                      playerReview: widget.playerReview,
                      matchId: widget.matchId,
                      myTeamId: widget.teamId,
                    )));
                  },
                ),
              ),
              SizedBox(width: size.width * 0.03,),
              Container(
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text('Xem',style: WhiteTitleText(),),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ViewPlayerReviewPage(playerReview: widget.playerReview)));
                  },
                ),
              ),
              SizedBox(width: size.width * 0.03,),
              widget.playerReview.star.isNegative?Container(
                height: size.height * 0.06,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  color: widget.playerReview.blackListed?Colors.grey:Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: widget.playerReview.blackListed?Center(child: Text('Đã Chặn',style: MyButtonText(),)):TextButton.icon(
                  icon: Icon(FontAwesome5.user_lock,color: Colors.white,),
                  label: Text('Chặn',style: MyButtonText()),
                  onPressed: (){
                    _showLockingPlayer();
                  },
                ),
              ) : SizedBox(),

            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showLockingPlayer(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Chặn cầu thủ',
      desc: 'Bạn có thật sự muốn chặn cầu thủ này không?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<PlayerReviewsBloc>(context).add(LockPlayer(playerId: widget.playerReview.playerId, teamId: widget.teamId, matchId: widget.matchId));
      },
      btnCancelOnPress: (){
      },
    ).show();
  }

}
