
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerState extends Equatable{
  const PlayerState();

  @override
  List<Object> get props => [];
}

class LoadingPlayers extends PlayerState{

}

class LoadedPlayers extends PlayerState{
  final List<Player> playersList;

  LoadedPlayers({required this.playersList});

  @override
  List<Object> get props => [playersList];

}