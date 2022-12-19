

import 'package:equatable/equatable.dart';

abstract class ViewDetailFacilityEvent extends Equatable{
  const ViewDetailFacilityEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailFacility extends ViewDetailFacilityEvent{

  final int facilityId;

  FetchDetailFacility({required this.facilityId});

  @override
  List<Object> get props => [facilityId];
}