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
  Club club;
  Player player;
  PlayerCard({required this.club,required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Text(player.name,style: TextLine2(),),
          // Spacer(),
          // Text(player.email,style: TextLine2(),),
          // Spacer(),
          // Text(player.phone,style: TextLine2(),),
          Spacer(),
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<PlayerClubBloc>(context).add(DeletePlayer(clubId:club.id,playerId: player.id));
            },
            icon: Icon(Icons.delete,color: Colors.redAccent),
            label: Text('Xóa',style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

}

class PlayerTeamCard extends StatelessWidget {
  Team team;
  Player player;
  PlayerTeamCard({required this.team,required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyPaddingAll(),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
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