import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_model.dart';

abstract class PlayerEvent extends Equatable{
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class FetchPlayers extends PlayerEvent{

  @override
  List<Object> get props => [];
}

class DeletePlayer extends PlayerEvent{
  final int playerId;
  DeletePlayer({required this.playerId});

  @override
  List<Object> get props => [playerId];
}

class CreatePlayer extends PlayerEvent{
  final int clubId;
  final PlayerCreationModel createdPlayer;
  CreatePlayer({required this.createdPlayer,required this.clubId});

  @override
  List<Object> get props => [createdPlayer,clubId];
}
