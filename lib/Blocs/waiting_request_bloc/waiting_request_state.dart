

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';

abstract class WaitingRequestState extends Equatable{
  const WaitingRequestState();

  @override
  List<Object> get props => [];
}

class LoadingWaitingRequests extends WaitingRequestState{

}

class LoadedWaitingRequests extends WaitingRequestState{
  final List<WaitingRequest> requestList;

  LoadedWaitingRequests({required this.requestList});

  @override
  List<Object> get props => [requestList];

}