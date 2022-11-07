import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_team_bloc/player_team_state.dart';
import 'package:football_booking_fbo_mobile/services/club_player_services.dart';
import 'package:football_booking_fbo_mobile/services/team_player_services.dart';



class PlayerTeamBloc extends Bloc<PlayerTeamEvent,PlayerTeamState>{

  PlayerTeamBloc() : super (LoadingTeamPlayers()){
    on<FetchTeamPlayers> ((event,emit) async{
      emit(LoadingTeamPlayers());
      var fetchedTeamPlayers = await fetchTeamPlayers(event.teamId);
      emit(LoadedTeamPlayers(teamPlayersList:fetchedTeamPlayers ));
    });

    on<AddTeamPlayer> ((event,emit) async{
      emit(LoadingTeamPlayers());
      var addedTeamPlayers = await addPlayerInTeam(event.teamId,event.newPlayer);
      log("add message:"+addedTeamPlayers);
      var fetchedTeamPlayersAfterAddition = await fetchTeamPlayers(event.teamId);
      emit(LoadedTeamPlayers(teamPlayersList:fetchedTeamPlayersAfterAddition));
    });

    on<DeleteTeamPlayer> ((event,emit) async{
      emit(LoadingTeamPlayers());
      var deletedPlayerTeam = await deletePlayerInTeam(event.teamId,event.playerId);
      log("delete message: " + deletedPlayerTeam);
      var fetchedTeamPlayers = await fetchTeamPlayers(event.teamId);
      emit(LoadedTeamPlayers(teamPlayersList:fetchedTeamPlayers ));
    });


  }

}