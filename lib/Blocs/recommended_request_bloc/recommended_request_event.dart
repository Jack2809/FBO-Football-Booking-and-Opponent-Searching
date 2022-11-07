

import 'package:equatable/equatable.dart';

abstract class RecommendedRequestEvent extends Equatable{
  const RecommendedRequestEvent();

  @override
  List<Object> get props => [];
}



class GetRecommendedRequest extends RecommendedRequestEvent{
  final int requestId;

  GetRecommendedRequest({required this.requestId});

  @override
  List<Object> get props => [requestId];
}

class SendChallengeRequest extends RecommendedRequestEvent{
  final int myRequestId;
  final int opponentRequestId;
  final int myTeamId;

  SendChallengeRequest({required this.myRequestId,required this.opponentRequestId,required this.myTeamId});

  @override
  List<Object> get props => [myRequestId,opponentRequestId,myTeamId];
}