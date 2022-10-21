
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerClubState extends Equatable{
  const PlayerClubState();

  @override
  List<Object> get props => [];
}

class LoadingClubPlayers extends PlayerClubState{

}

class LoadedClubPlayers extends PlayerClubState{
  final List<Player> clubPlayersList;

  LoadedClubPlayers({required this.clubPlayersList});

  @override
  List<Object> get props => [clubPlayersList];

}