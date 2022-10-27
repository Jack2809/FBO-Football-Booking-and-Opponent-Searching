
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';

abstract class RecommendedRequestState extends Equatable{
  const RecommendedRequestState();

  @override
  List<Object> get props => [];
}

class LoadingRecommendedRequests extends RecommendedRequestState{

}

class LoadedRecommendedRequests extends RecommendedRequestState{
  final List<RecommendedRequest> requestList;

  LoadedRecommendedRequests({required this.requestList});

  @override
  List<Object> get props => [requestList];

}