

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/match_score.dart';

abstract class MatchHistoryScoreState extends Equatable{
  const MatchHistoryScoreState();

  @override
  List<Object> get props => [];
}

class LoadingMatchHistoryScore extends MatchHistoryScoreState{

}

class LoadedMatchHistoryScore extends MatchHistoryScoreState{

  MatchScores matchScores;

  LoadedMatchHistoryScore({required this.matchScores});


  @override
  List<Object> get props => [matchScores];

}