import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';
import 'package:football_booking_fbo_mobile/constants.dart';

class PlayerCard extends StatelessWidget {
  Team team;
  Player player;
  PlayerCard({required this.team,required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ]
      ),
      child: Row(
        children: <Widget>[
          Text(player.name,style: TextLine2(),),
          Spacer(),
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<PlayerTeamBloc>(context).add(DeleteTeamPlayer(teamId:team.id,playerId: player.id));
            },
            icon: Icon(Icons.delete,color: Colors.redAccent),
            label: Text('Xóa',style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

}

