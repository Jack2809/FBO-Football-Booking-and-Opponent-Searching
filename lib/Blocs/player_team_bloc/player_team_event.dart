import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerTeamEvent extends Equatable{
  const PlayerTeamEvent();

  @override
  List<Object> get props => [];
}

class FetchTeamPlayers extends PlayerTeamEvent{
  final int teamId;

  FetchTeamPlayers({required this.teamId});

  @override
  List<Object> get props => [teamId];
}

class DeleteTeamPlayer extends PlayerTeamEvent{
  final int teamId;
  final int playerId;
  DeleteTeamPlayer({required this.teamId,required this.playerId});

  @override
  List<Object> get props => [teamId,playerId];
}

class AddTeamPlayers extends PlayerTeamEvent{
  final int teamId;
  List<int> playerIdList;
  AddTeamPlayers({required this.teamId,required this.playerIdList});

  @override
  List<Object> get props => [teamId,playerIdList];
}