
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