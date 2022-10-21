import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerClubEvent extends Equatable{
  const PlayerClubEvent();

  @override
  List<Object> get props => [];
}

class FetchClubPlayers extends PlayerClubEvent{
  final int clubId;

  FetchClubPlayers({required this.clubId});

  @override
  List<Object> get props => [clubId];
}

class DeletePlayer extends PlayerClubEvent{
  final int clubId;
  final int playerId;
  DeletePlayer({required this.clubId,required this.playerId});

  @override
  List<Object> get props => [clubId,playerId];
}

class CreatePlayer extends PlayerClubEvent{
  final int clubId;
  final PlayerCreationModel createdPlayer;
  CreatePlayer({required this.createdPlayer,required this.clubId});

  @override
  List<Object> get props => [createdPlayer,clubId];
}
