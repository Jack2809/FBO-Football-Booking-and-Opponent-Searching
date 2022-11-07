


import 'package:equatable/equatable.dart';

abstract class OpponentRequestDetailEvent extends Equatable{
  const OpponentRequestDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchOpponentRequestDetail extends OpponentRequestDetailEvent{
  final int requestId;

  FetchOpponentRequestDetail({required this.requestId});

  @override
  List<Object> get props => [requestId];
}

