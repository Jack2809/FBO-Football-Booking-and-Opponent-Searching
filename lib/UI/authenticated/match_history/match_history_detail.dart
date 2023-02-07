
import 'dart:developer';

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
import 'package:football_booking_fbo_mobile/services/match_history_services.dart';

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
    log(widget.matchHistory.matchId.toString());
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
                                   Text('Đội nhà chưa nhập điểm!')
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
                                   Text('Đội khách chưa nhập điểm!'),
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
                                   child: Text("Nhập Tỷ Số",style: MyButtonText()),
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
                                   child: Text("Nhập Tỷ Số",style: MyButtonText()),
                                   onPressed: (){
                                     _showInputScore();
                                   },
                                 ),
                               ),
                             ]
                           ],
                           SizedBox(height: size.height * 0.05,),
                           if(state.matchScores.homeTeam.homeScore.isNegative || state.matchScores.awayTeam.homeScore.isNegative)...[
                             SizedBox(),
                           ]
                           else if(state.matchScores.homeTeam.homeScore == state.matchScores.awayTeam.homeScore
                           && state.matchScores.homeTeam.awayScore == state.matchScores.awayTeam.awayScore)...[
                             Text('Ghi chú : 2 đội đã nhập kết quả phù hợp, hệ thống đã tính điểm cho 2 đội'),
                           ]else ...[
                             Text('Ghi chú : 2 đội đã nhập kết quả không trùng khớp, hệ thống sẽ không tính điểm cho 2 đội')
                           ]

                         ]
                       );
                      }
                      else {
                        return Center(child: Text('Something wrong!!'),);
                      }
                    }
                ):SizedBox(),


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
                          TextSpan(text: widget.matchHistory.facilityName,style: TextLine1(context,false))
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
                          TextSpan(text: widget.matchHistory.address +" - "+widget.matchHistory.district,style: TextLine1(context,false))
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
                          TextSpan(text: dateFormat(widget.matchHistory.bookingDate),style: TextLine1(context,false))
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
                          TextSpan(text: timeFormat(widget.matchHistory.startTime)+" - " +timeFormat(widget.matchHistory.endTime),style: TextLine1(context,false))
                        ],
                      )),
                      )
                    ]
                ),
                SizedBox(height: 20.0,),
                Text('Cầu thủ đối phương',style: HeadLine1(context),),
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
                            child: Text('không có cầu thủ nào !'),
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
          title: const Text('Nhập Tỷ Số'),
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
                        labelText: _isHomeTeam?"Tỷ số của đội bạn":"Tỷ số của đội đối thủ",
                      ),
                      validator: (myScore){
                        if(myScore!.isEmpty){
                          return 'Vui lòng nhập tỷ số';
                        }
                        if(int.parse(myScore).isNegative){
                          return 'Tỷ số không được âm';
                        }
                        if(int.parse(myScore) > 150){
                          return 'Tỷ số không thể vượt quá 150 bàn';
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
                        labelText: _isAwayTeam?"Tỷ số của đội bạn":"Tỷ số của đội đối thủ",
                      ),
                      validator: (enemyScore){
                        if(enemyScore!.isEmpty){
                          return 'Vui lòng nhập tỷ số';
                        }
                        if(int.parse(enemyScore).isNegative){
                          return 'Tỷ số không được âm';
                        }
                        if(int.parse(enemyScore) > 150){
                          return 'Tỷ số không thể vượt quá 150 bàn';
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
              child: const Text('Hủy bỏ'),
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
                    title: 'Xác nhận',
                    desc: 'Bạn đã chắc chắn tỷ số được nhập đúng như thực tế chứ ?',
                    buttonsTextStyle: const TextStyle(color: Colors.black),
                    showCloseIcon: true,
                    btnOkOnPress: () async {
                      BlocProvider.of<MatchHistoryScoreBloc>(context).add(AddScore(
                          matchId: widget.matchHistory.matchId,
                          teamId: widget.myTeamId,
                          homeScore: int.parse(homeTeamScoreC.text),
                          awayScore: int.parse(awayTeamScoreC.text),
                          rivalry:  widget.matchHistory.rivalry
                      ));

                       // await isScoreConflict(widget.matchHistory.matchId);
                      if(await isScoreConflict(widget.matchHistory.matchId,widget.myTeamId)){
                        warningScoreConflictDialog(context);
                      }else{
                        BlocProvider.of<MatchHistoryScoreBloc>(context).add(SubmitScore(
                            matchId: widget.matchHistory.matchId,
                            teamId: widget.myTeamId,
                            rivalry:  widget.matchHistory.rivalry
                        ));
                        Navigator.of(context).pop();
                      }

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

  Future<void> warningScoreConflictDialog(BuildContext context){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Cảnh Báo',
      desc: 'Tỷ số bạn đang nhập không trừng khớp với đội đối thủ , bạn có chắc chắn chứ ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<MatchHistoryScoreBloc>(context).add(SubmitScore(
            matchId: widget.matchHistory.matchId,
            teamId: widget.myTeamId,
            rivalry:  widget.matchHistory.rivalry
        ));
        Navigator.of(context).pop();
      },
      btnCancelOnPress: (){}
    ).show();
  }

}