

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerTeamState extends Equatable{
  const PlayerTeamState();

  @override
  List<Object> get props => [];
}

class LoadingTeamPlayers extends PlayerTeamState{

}

class LoadedTeamPlayers extends PlayerTeamState{
  final List<Player> teamPlayersList;

  LoadedTeamPlayers({required this.teamPlayersList});

  @override
  List<Object> get props => [teamPlayersList];

}