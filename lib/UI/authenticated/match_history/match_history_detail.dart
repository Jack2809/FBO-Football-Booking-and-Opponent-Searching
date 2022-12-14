import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/review_player_in_match_bloc/review_player_state.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

import 'match_history_card.dart';

class MatchHistoryDetail extends StatefulWidget{
  MatchHistory matchHistory;
  int myTeamId ;
  MatchHistoryDetail({required this.matchHistory,required this.myTeamId});
  @override
  State<MatchHistoryDetail> createState() => _MatchHistoryDetailState();
}

class _MatchHistoryDetailState extends State<MatchHistoryDetail> {

  @override
  void initState() {
    reloadPage();
    super.initState();
  }

  void reloadPage(){
    if(widget.matchHistory.rivalry) {
      BlocProvider.of<PlayerReviewsBloc>(context).add(FetchReviews(
        matchId: widget.matchHistory.matchId, myTeamId: widget.myTeamId,));
      BlocProvider.of<MatchHistoryScoreBloc>(context).add(
          FetchMatchHistoryScore(
              matchId: widget.matchHistory.matchId, teamId: widget.myTeamId));
    } else {
      BlocProvider.of<PlayerReviewsBloc>(context).add(FetchReviews(
        matchId: widget.matchHistory.matchId, myTeamId: widget.myTeamId,));
    }
  }

  @override
  void dispose() {
    homeTeamScoreC.dispose();
    awayTeamScoreC.dispose();
    super.dispose();
  }

  TextEditingController homeTeamScoreC = TextEditingController();
  TextEditingController awayTeamScoreC = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi ti???t l???ch s??? tr???n ?????u', style: WhiteTitleText()),
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
        child: RefreshIndicator(
          onRefresh: () async {
            reloadPage();
          },
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
                              child: widget.matchHistory.rivalry ? Center(child: Text('Tranh T??i',style:MyButtonText(),)) : Center(child: Text('Giao H???u',style:MyButtonText(),))
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
                widget.matchHistory.rivalry?BlocBuilder<MatchHistoryScoreBloc,MatchHistoryScoreState>(
                    builder:(context,state){
                      if(state is LoadingMatchHistoryScore){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(state is LoadedMatchHistoryScore){
                       return Column(
                         children: [
                           Container(
                             padding: MyPaddingAll(),
                             width: size.width * 0.9,
                             height: size.height * 0.1,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               border: Border.all(color: Colors.black12),
                             ),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [

                                 if(state.matchScores.homeTeam.homeScore.isNegative)...[
                                   CircleAvatar(
                                     radius: size.height * 0.06,
                                     backgroundImage: NetworkImage(widget.matchHistory.homeTeamImage),
                                   ),
                                   Text('?????i nh?? ch??a nh???p ??i???m!')
                                 ]else...[
                                   CircleAvatar(
                                     radius: size.height * 0.06,
                                     backgroundImage: NetworkImage(widget.matchHistory.homeTeamImage),
                                   ),
                                   Text(state.matchScores.homeTeam.homeScore.toString()),
                                   Text(':'),
                                   Text(state.matchScores.homeTeam.awayScore.toString()),
                                 ],

                               ],
                             ),
                           ),
                           SizedBox(height: size.height * 0.02,),
                           Container(
                             padding: MyPaddingAll(),
                             width: size.width * 0.9,
                             height:size.height * 0.1,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               border: Border.all(color: Colors.black12),
                             ),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 if(state.matchScores.awayTeam.homeScore.isNegative)...[
                                   Text('?????i kh??ch ch??a nh???p ??i???m!'),
                                   CircleAvatar(
                                     radius: size.height * 0.06,
                                     backgroundImage: NetworkImage(widget.matchHistory.awayTeamImage),
                                   ),
                                 ]else...[
                                   Text(state.matchScores.awayTeam.homeScore.toString()),
                                   Text(':'),
                                   Text(state.matchScores.awayTeam.awayScore.toString()),
                                   CircleAvatar(
                                     radius: size.height * 0.06,
                                     backgroundImage: NetworkImage(widget.matchHistory.awayTeamImage),
                                   ),
                                 ]

                               ],
                             ),
                           ),
                           if(widget.myTeamId == state.matchScores.homeTeam.teamId)...[
                             if(state.matchScores.homeTeam.homeScore.isNegative)...[
                               SizedBox(
                                 width: size.width * 0.9,
                                 child: TextButton(
                                   style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.resolveWith((states) {
                                       if(states.contains(MaterialState.pressed)){
                                         return Colors.redAccent;
                                       }
                                       return Colors.green;
                                     }
                                     ),
                                   ),
                                   child: Text("Nh???p T??? S???",style: MyButtonText()),
                                   onPressed: (){
                                     _showInputScore();
                                   },
                                 ),
                               ),
                             ]
                           ]else...[
                             if(state.matchScores.awayTeam.homeScore.isNegative)...[
                               SizedBox(
                                 width: size.width * 0.9,
                                 child: TextButton(
                                   style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.resolveWith((states) {
                                       if(states.contains(MaterialState.pressed)){
                                         return Colors.redAccent;
                                       }
                                       return Colors.green;
                                     }
                                     ),
                                   ),
                                   child: Text("Nh???p T??? S???",style: MyButtonText()),
                                   onPressed: (){
                                     _showInputScore();
                                   },
                                 ),
                               ),
                             ]
                           ]


                         ],
                       );
                      }
                      else {
                        return Center(child: Text('Something wrong!!'),);
                      }
                    }
                ):SizedBox(),


                SizedBox(height:20.0,),

                Text('Th??ng tin tr???n',style: HeadLine1(context),),
                SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.stadium,color: Colors.green),
                      SizedBox(width: 10.0,),
                      Expanded(child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text:'T??n s??n: ',style: HeadLine1(context)),
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
                          TextSpan(text:'?????a ch???: ',style: HeadLine1(context)),
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
                          TextSpan(text:'Ng??y ????: ',style: HeadLine1(context)),
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
                          TextSpan(text:'Gi??? ????: ',style: HeadLine1(context)),
                          TextSpan(text: timeFormat(widget.matchHistory.startTime)+" - " +timeFormat(widget.matchHistory.endTime),style: TextLine1(context,true))
                        ],
                      )),
                      )
                    ]
                ),
                SizedBox(height: 20.0,),
                Text('C???u th??? ?????i ph????ng',style: HeadLine1(context),),
                SizedBox(height: 10.0),
                BlocBuilder<PlayerReviewsBloc, PlayerReviewsState>(
                    builder: (context, state) {
                      if (state is LoadingPlayerReviews) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoadedPlayerReviews) {
                        if (state.reviewList.isEmpty) {
                          return Center(
                            child: Text('kh??ng c?? c???u th??? n??o !'),
                          );
                        } else {
                          return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              const SizedBox(height: 10.0),
                              padding: MyPaddingAll10(),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.reviewList.length,
                              itemBuilder: ((context, index) {
                                return HistoryPlayerCard(playerReview: state.reviewList[index],matchId:widget.matchHistory.matchId,teamId: widget.myTeamId,);
                              }));
                        }
                      } else {
                        return Center(
                          child: Text('Something wrong!!'),
                        );
                      }
                    }),




              ],
            ),
          ),
        ),
      ),

    );
  }

  Future<void > _showInputScore() async {
    bool _isHomeTeam = false;
    bool _isAwayTeam = false;
    if(widget.myTeamId == widget.matchHistory.homeTeamId){
      setState(() {
        _isHomeTeam = true;
      });
    }else{
      setState(() {
        _isAwayTeam = true;
      });
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Nh???p T??? S???'),
          content: Form(
            key: formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: homeTeamScoreC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.sports_soccer) ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: _isHomeTeam?"T??? s??? c???a ?????i b???n":"T??? s??? c???a ?????i ?????i th???",
                      ),
                      validator: (myScore){
                        if(myScore!.isEmpty){
                          return 'Vui l??ng nh???p t??? s???';
                        }
                        if(int.parse(myScore).isNegative){
                          return 'T??? s??? kh??ng ???????c ??m';
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: awayTeamScoreC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefix: Icon(Icons.sports_soccer) ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: _isAwayTeam?"T??? s??? c???a ?????i b???n":"T??? s??? c???a ?????i ?????i th???",
                      ),
                      validator: (enemyScore){
                        if(enemyScore!.isEmpty){
                          return 'Vui l??ng nh???p t??? s???';
                        }
                        if(int.parse(enemyScore).isNegative){
                          return 'T??? s??? kh??ng ???????c ??m';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('H???y b???'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                if(formGlobalKey.currentState!.validate()) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    headerAnimationLoop: false,
                    animType: AnimType.bottomSlide,
                    title: 'X??c nh???n',
                    desc: 'B???n ???? ch???c ch???n t??? s??? ???????c nh???p ????ng nh?? th???c t??? ch??? ?',
                    buttonsTextStyle: const TextStyle(color: Colors.black),
                    showCloseIcon: true,
                    btnOkOnPress: () {
                      BlocProvider.of<MatchHistoryScoreBloc>(context).add(SubmitScore(
                          matchId: widget.matchHistory.matchId,
                          teamId: widget.myTeamId,
                          homeScore: int.parse(homeTeamScoreC.text),
                          awayScore: int.parse(awayTeamScoreC.text),
                          rivalry:  widget.matchHistory.rivalry
                      ));
                      // Future.delayed(Duration(seconds:3),(){BlocProvider.of<MatchHistoryScoreBloc>(context).add(FetchMatchHistoryScore(matchId: widget.matchHistory.matchId, teamId: widget.myTeamId));});
                      Navigator.pop(context);
                    },
                    btnCancelOnPress: (){},
                  ).show();
                }
              },
            ),
          ],
        );
      },
    );
  }

}