

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


class ShowPopUpMessageEvent extends OpponentRequestEvent{
  final String content;

  ShowPopUpMessageEvent({required this.content});

  @override
  List<Object> get props => [content];
}

class CreateOpponentRequest extends OpponentRequestEvent{
  final List<int> districtIdList;
  final String bookingDate;
  final String freetimeStart;
  final String freetimeEnd;
  final int duration;
  final int teamId;
  final int fieldTypeId;
  final int isRivalry;

  CreateOpponentRequest({
    required this.districtIdList,
    required this.bookingDate,
    required this.duration,
    required this.freetimeStart,
    required this.freetimeEnd,
    required this.fieldTypeId,
    required this.teamId,
    required this.isRivalry
});

  @override
  List<Object> get props => [districtIdList,bookingDate,duration,freetimeStart,freetimeEnd,fieldTypeId,teamId,isRivalry];
}


