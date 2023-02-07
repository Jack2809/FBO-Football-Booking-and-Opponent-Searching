

import 'package:equatable/equatable.dart';

abstract class MatchHistoryScoreEvent extends Equatable{
  const MatchHistoryScoreEvent();

  @override
  List<Object> get props => [];
}

class FetchMatchHistoryScore extends MatchHistoryScoreEvent{
  final int matchId;
  final int teamId;

  FetchMatchHistoryScore({required this.matchId,required this.teamId});

  @override
  List<Object> get props => [matchId,teamId];
}

class SubmitScore extends MatchHistoryScoreEvent{
  final int teamId;
  final int matchId;
  final bool rivalry;

  SubmitScore({required this.matchId,required this.teamId,required this.rivalry});

  @override
  List<Object> get props => [teamId,matchId,rivalry];



}

class AddScore extends MatchHistoryScoreEvent{
  final int homeScore;
  final int awayScore;
  final int teamId;
  final int matchId;
  final bool rivalry;

  AddScore({required this.matchId,required this.teamId,required this.homeScore,required this.awayScore,required this.rivalry});

  @override
  List<Object> get props => [homeScore,awayScore,teamId,matchId,rivalry];



}