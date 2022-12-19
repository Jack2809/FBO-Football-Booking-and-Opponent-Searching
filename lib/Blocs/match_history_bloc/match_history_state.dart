



import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/match_history.dart';

abstract class MatchHistoryState extends Equatable{
  const MatchHistoryState();

  @override
  List<Object> get props => [];
}

class LoadingMatchHistory extends MatchHistoryState{

}

class LoadedMatchHistory extends MatchHistoryState{
  final List<MatchHistory> matchHistoryList;

  LoadedMatchHistory({required this.matchHistoryList});

  @override
  List<Object> get props => [matchHistoryList];

}