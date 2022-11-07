

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';

abstract class OpponentRequestDetailState extends Equatable{
  const OpponentRequestDetailState();

  @override
  List<Object> get props => [];
}

class LoadingOpponentRequestDetail extends OpponentRequestDetailState{

}

class LoadedOpponentRequestDetail extends OpponentRequestDetailState{
  final OpponentRequestDetailModel requestDetail;

  LoadedOpponentRequestDetail({required this.requestDetail});

  @override
  List<Object> get props => [requestDetail];

}