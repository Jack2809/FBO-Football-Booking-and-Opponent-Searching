

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';

abstract class PlayerMatchHistoryState extends Equatable{
  const PlayerMatchHistoryState();

  @override
  List<Object> get props => [];
}

class LoadingPlayerMatchHistory extends PlayerMatchHistoryState{

}

class LoadedPlayerMatchHistory extends PlayerMatchHistoryState{
  final List<MatchHistory> matchHistoryList;

  LoadedPlayerMatchHistory({required this.matchHistoryList});

  @override
  List<Object> get props => [matchHistoryList];

}