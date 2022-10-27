import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/UI/authenticated/account_page/account_widgets/club/player_card.dart';
import 'package:football_booking_fbo_mobile/constants.dart';
import 'package:group_button/group_button.dart';

class TeamDetail extends StatefulWidget{
  Team team;
  Club club;
  List<Player> clubPlayerList ;

  TeamDetail({required this.team,required this.club,required this.clubPlayerList});

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {

  late  List<Player> unavailablePlayersInTeam = [];

  @override
  void initState() {
    BlocProvider.of<PlayerTeamBloc>(context).add(FetchTeamPlayers(teamId: widget.team.id));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết Team', style: TextLine1(true)),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        shadowColor: Colors.grey.withOpacity(0.02),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: (){
                _showDeleteingTeam();
              },
              icon: Icon(Icons.delete,color: Colors.redAccent,)),
        ],
      ),
      body: Container(
        padding: MyPaddingAll(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Tên đội hình: ' + widget.team.name , style: TextLine1(true),),

              BlocBuilder<PlayerTeamBloc, PlayerTeamState>(
                  builder: (context, state) {
                    if (state is LoadingTeamPlayers) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedTeamPlayers) {
                      log("team:"+state.teamPlayersList.length.toString());
                      unavailablePlayersInTeam.clear();
                      for(var player in widget.clubPlayerList){
                        if(state.teamPlayersList.contains(player) == false){
                          log(state.teamPlayersList.contains(player).toString());
                          unavailablePlayersInTeam.add(player);
                        }
                      }
                      log('length: '+unavailablePlayersInTeam.length.toString());
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
                              return PlayerTeamCard(team: widget.team,player:state.teamPlayersList[index],);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        color: Colors.green,
        child: TextButton.icon(
          onPressed: () {
            _showAddingPlayerInTeam();
          },
          icon: Icon(Icons.person_add_rounded,color: Colors.white),
          label: Text('Thêm cầu thủ vào đội hình',style: MyButtonText()),
        ),
      ),
    );
  }

  Future<void > _showDeleteingTeam() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xóa Đội Hình'),
          content: Text('Bạn thật sự muốn xóa đội hình này chứ ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xóa'),
              onPressed: () {
                BlocProvider.of<TeamBloc>(context).add(DeleteTeam(teamId: widget.team.id, clubId: widget.club.id));
                Navigator.pop(context);
                Navigator.pop(context);
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


  Future<void > _showAddingPlayerInTeam() async {
    List<int> playerIdList = [];
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = getSize(context);
        return AlertDialog(
          title: const Text('Thêm cầu thủ vào đội hình'),
          content: Container(
            child: Column(
              children: [
                GroupButton<Player>(
                buttonBuilder: (selected, player, context) {
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
                      '${player.id}-${player.name}',
                      ),
                  ),
                );
              },
                  options: GroupButtonOptions(
                    buttonWidth: size.width * 0.7,
                    borderRadius: BorderRadius.circular(10.0),
                    selectedColor: Colors.green,
                  ),
                  onSelected: (player, index, isSelected) {
                    if(isSelected){
                      playerIdList.add(player.id);
                      log(playerIdList.toString());
                    }else{
                      playerIdList.remove(player.id);
                      log(playerIdList.toString());
                    }
                  },
                  isRadio: false,
                  buttons: unavailablePlayersInTeam,
                )

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Thêm'),
              onPressed: () {
                BlocProvider.of<PlayerTeamBloc>(context).add(AddTeamPlayers(teamId: widget.team.id, playerIdList: playerIdList));
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy bỏ'),
              onPressed: () {
                playerIdList.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}