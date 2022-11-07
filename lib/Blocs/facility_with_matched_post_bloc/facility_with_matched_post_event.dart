

import 'package:equatable/equatable.dart';

abstract class FacilityWithMatchedPostEvent extends Equatable{
  const FacilityWithMatchedPostEvent();

  @override
  List<Object> get props => [];
}

class FetchFacilityWithMatchedPost extends FacilityWithMatchedPostEvent{
  final int myRequestId;
  final int opponentRequestId;
  final double duration;
  final int fieldTypeId;
  final String startDate;

  FetchFacilityWithMatchedPost(
      {required this.myRequestId,
        required this.opponentRequestId,
        required this.duration,
        required this.fieldTypeId,
        required this.startDate
  });

  @override
  List<Object> get props => [myRequestId,opponentRequestId,duration,fieldTypeId,startDate];
}