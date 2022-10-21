
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';

abstract class OpponentRequestState extends Equatable{
  const OpponentRequestState();

  @override
  List<Object> get props => [];
}

class LoadingOpponentRequests extends OpponentRequestState{

}

class LoadedOpponentRequests extends OpponentRequestState{
  final List<OpponentRequest> requestList;

  LoadedOpponentRequests({required this.requestList});

  @override
  List<Object> get props => [requestList];

}