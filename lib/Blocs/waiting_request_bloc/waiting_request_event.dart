
import 'package:equatable/equatable.dart';

abstract class WaitingRequestEvent extends Equatable{
  const WaitingRequestEvent();

  @override
  List<Object> get props => [];
}



class GetWaitingRequest extends WaitingRequestEvent{
  final int requestId;

  GetWaitingRequest({required this.requestId});

  @override
  List<Object> get props => [requestId];
}

class AcceptWaitingRequestChallenge extends WaitingRequestEvent{
  final int myRequestId;
  final int opponentRequestId;
  final int opponentTeamId;

  AcceptWaitingRequestChallenge({required this.myRequestId,required this.opponentRequestId,required this.opponentTeamId});

  @override
  List<Object> get props => [myRequestId,opponentRequestId,opponentTeamId];
}

class DeclineWaitingRequestChallenge extends WaitingRequestEvent{
  final int myRequestId;
  final int opponentRequestId;

  DeclineWaitingRequestChallenge({required this.myRequestId,required this.opponentRequestId});

  @override
  List<Object> get props => [myRequestId,opponentRequestId];
}