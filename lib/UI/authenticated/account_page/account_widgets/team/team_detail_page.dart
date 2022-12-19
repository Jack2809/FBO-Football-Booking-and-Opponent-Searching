import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_detail_bloc/team_detail_state.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/team_player_card.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/team/player_creation.dart';
import 'package:football_booking_fbo_mobile/Validator/player_validator.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

import 'team_update_page.dart';

class TeamDetail extends StatefulWidget {
  Team team;


  TeamDetail({required this.team});

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> with InputPlayerValidation{

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<TeamDetailBloc>(context).add(FetchTeamDetail(teamId: widget.team.id));

    BlocProvider.of<PlayerTeamBloc>(context).add(FetchTeamPlayers(teamId: widget.team.id));

    super.initState();
    BlocProvider.of<TeamBloc>(context).listenerStream.listen((event) {
      if(event == ""){

      }else if(event == "Bạn đã xóa đội"){
        successfulDialog1Pop(context, event);
      }else if(event == 'Xóa đội thất bại'){
        failDialog(context, event);
      }else{
        errorDialog(context, event);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết Đội Hình', style: WhiteTitleText()),
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
          IconButton(
            icon: Icon(Icons.edit,color: Colors.white),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTeamPage(team: widget.team,)));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white),
            onPressed: (){
              _showDeletingTeam();
            },
          ),
        ],

      ),
      body: Container(
        color: Colors.grey.withOpacity(0.02),
        padding: MyPaddingAll10(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<TeamDetailBloc, TeamDetailState>(
                  builder: (context, state) {
                    if (state is LoadingTeamDetail) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedTeamDetail) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: primaryColor,
                                backgroundImage: NetworkImage(state.team.imageUrl),
                                radius: size.height * 0.1,
                              ),
                            ),
                            Center(child: Text(state.team.name, style: TextLine1(context,true))),
                            SizedBox(height: size.height * 0.03,),
                            Text(
                              'Thông tin đội',
                              style: HeadLine1(context),
                            ),
                            Divider(
                              color:Colors.grey,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Điểm tích lũy: ',style: TextLine1(context,true)),
                                Spacer(),
                                Text(state.team.accumulatedScore.toStringAsFixed(1),style: TextLine1(context, false)),
                              ],
                            ),
                            Divider(
                              color:Colors.grey,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Điểm đội: ',style: TextLine1(context,true)),
                                Spacer(),
                                Text(state.team.teamScore.toStringAsFixed(1),style: TextLine1(context, false)),
                              ],
                            ),
                            Divider(
                              color:Colors.grey,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Tổng trận: ',style: TextLine1(context,true)),
                                Spacer(),
                                Text(state.team.totalMatches.toString(),style: TextLine1(context, false)),
                              ],
                            ),
                            Divider(
                              color:Colors.grey,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            SizedBox(height: size.height * 0.02,),
                            Text(
                              'Mô tả',
                              style: HeadLine1(context),
                            ),
                            SizedBox(height: size.height * 0.02,),
                            Text(state.team.description, style: TextLine1(context,false),maxLines:5),
                          ],
                        );
                    } else {
                      return Center(
                        child: Text('Something wrong!!'),
                      );
                    }
                  }),
              SizedBox(height: size.height * 0.03,),
              Text('Danh sách cầu thủ trong đội hình',style: HeadLine1(context)),
              SizedBox(height: size.height * 0.02,),
              BlocBuilder<PlayerTeamBloc, PlayerTeamState>(
                  builder: (context, state) {
                if (state is LoadingTeamPlayers) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedTeamPlayers) {

                  if (state.teamPlayersList.isEmpty) {
                    return Center(
                      child: Text('Không có Player nào !'),
                    );
                  } else {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5.0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.teamPlayersList.length,
                        itemBuilder: ((context, index) {
                          return index == 0 ? HeadTeamPlayerCard(team: widget.team, player: state.teamPlayersList[index]) : TeamPlayerCard(team:widget.team,player: state.teamPlayersList[index],);
                        }));
                  }
                } else {
                  return Center(
                    child: Text('Something wrong!!'),
                  );
                }
              }),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green,
        ),
        child: TextButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateTeamPlayerPage(team: widget.team)));
          },
          icon: Icon(Icons.person_add_rounded,color:Colors.white),
          label: Text('Thêm cầu thủ',style: MyButtonText()),
        ),
      ),
    );
  }


  Future<dynamic> _showDeletingTeam(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Xóa Đội',
      desc: 'Bạn có thật sự muốn xóa đội chứ ?',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        BlocProvider.of<TeamBloc>(context).add(DeleteTeam(teamId: widget.team.id));
      },
      btnCancelOnPress: (){
      },
    ).show();
  }

}
