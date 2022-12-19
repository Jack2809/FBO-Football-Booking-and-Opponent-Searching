

import 'package:equatable/equatable.dart';

abstract class PlayerMatchHistoryEvent extends Equatable{
  const PlayerMatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchPlayerMatchHistory extends PlayerMatchHistoryEvent{

  final String phoneNumber;

  FetchPlayerMatchHistory({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}