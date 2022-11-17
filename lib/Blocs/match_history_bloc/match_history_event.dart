

import 'package:equatable/equatable.dart';

abstract class MatchHistoryEvent extends Equatable{
  const MatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchMatchHistory extends MatchHistoryEvent{

  final int teamId;

  FetchMatchHistory({required this.teamId});

  @override
  List<Object> get props => [];
}
