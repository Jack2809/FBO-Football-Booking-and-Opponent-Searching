

import 'package:equatable/equatable.dart';

abstract class OpponentRequestEvent extends Equatable{
  const OpponentRequestEvent();

  @override
  List<Object> get props => [];
}

class FetchOpponentRequests extends OpponentRequestEvent{

  @override
  List<Object> get props => [];
}

class DeleteOpponentRequest extends OpponentRequestEvent{
  final int requestId;

  DeleteOpponentRequest({required this.requestId});

  @override
  List<Object> get props => [requestId];
}

class CreateOpponentRequest extends OpponentRequestEvent{
  final List<int> districtIdList;
  final String bookingDate;
  final String freetimeStart;
  final String freetimeEnd;
  final int duration;
  final int teamId;
  final int fieldTypeId;

  CreateOpponentRequest({
    required this.districtIdList,
    required this.bookingDate,
    required this.duration,
    required this.freetimeStart,
    required this.freetimeEnd,
    required this.fieldTypeId,
    required this.teamId
});

  @override
  List<Object> get props => [districtIdList,bookingDate,duration,freetimeStart,freetimeEnd,fieldTypeId,teamId];
}


