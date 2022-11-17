import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_bloc/match_history_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_bloc/match_history_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_bloc/match_history_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';

import 'match_history_card.dart';
import 'match_history_detail.dart';

class MatchHistoryPage extends StatefulWidget {
  @override
  State<MatchHistoryPage> createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  int _teamId = 0;
  String _teamName = "";

  bool _isFirstLoad = true ;

  @override
  void initState() {
    BlocProvider.of<TeamBloc>(context).add(FetchTeams());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.green,
        title: Text('Lịch sử trận đấu', style: WhiteTitleText()),
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          padding: MyPaddingAll10(),
          child: BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
            if (state is LoadingTeams) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedTeams) {
              if (state.teamList.isEmpty) {
                return Center(
                  child: Text('Không có đội hình nào'),
                );
              } else {
                if(_isFirstLoad){
                  _teamId = state.teamList.first.id;
                  _teamName = state.teamList.first.name;
                }

                BlocProvider.of<MatchHistoryBloc>(context)
                    .add(FetchMatchHistory(teamId: _teamId));
                return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          int teamIdTemp = _teamId;
                          String teamNameTemp = _teamName;
                          _showChoosingATeam(state.teamList,teamIdTemp,teamNameTemp);
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.green),
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
                          child: Center(child: Text(_teamName,style: TextLine1(true),)),
                        ),
                      ),

                      BlocBuilder<MatchHistoryBloc, MatchHistoryState>(
                          builder: (context, state) {
                            if (state is LoadingMatchHistory) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is LoadedMatchHistory) {
                              if (state.matchHistoryList.isEmpty) {
                                return Center(
                                  child: Text('Không có lịch sử trận đấu nào'),
                                );
                              } else {
                                return ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                    const SizedBox(height: 10.0),
                                    padding: MyPaddingAll10(),
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.matchHistoryList.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MatchHistoryDetail(matchHistory: state.matchHistoryList[index])));
                                        },
                                        child: MatchHistoryCard(
                                            matchHistory:
                                            state.matchHistoryList[index]),
                                      );
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
                );
              }
            } else {
              return Center(
                child: Text('Something wrong!!'),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<void> _showChoosingATeam(List<Team> teamList,int previousTeamId,String previousTeamName) async {
    int tempId = previousTeamId;
    String tempName = previousTeamName;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Chọn đội xem lịch sử'),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GroupButton<Team>(
                    maxSelected: 1,
                    buttonBuilder: (selected, team, context) {
                      return Container(
                        width: size.width * 0.7,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: selected ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            '${team.name}',
                          ),
                        ),
                      );
                    },
                    options: GroupButtonOptions(
                      buttonWidth: size.width * 0.7,
                      borderRadius: BorderRadius.circular(10.0),
                      selectedColor: Colors.green,
                    ),
                    onSelected: (team, index, isSelected) {
                      if (isSelected) {
                        tempId = team.id;
                        tempName = team.name;

                      } else {
                         tempId = previousTeamId;
                         tempName = previousTeamName;
                      }
                    },
                    isRadio: false,
                    buttons: teamList,
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {

                if (tempId == previousTeamId || tempName == previousTeamName) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _isFirstLoad = false ;
                    _teamId = tempId;
                    _teamName = tempName;
                  });
                  BlocProvider.of<MatchHistoryBloc>(context)
                      .add(FetchMatchHistory(teamId: _teamId));

                  Navigator.pop(context);
                }
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
