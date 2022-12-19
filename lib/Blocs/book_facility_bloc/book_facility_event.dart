

import 'package:equatable/equatable.dart';

abstract class BookFacilityEvent extends Equatable{
  const BookFacilityEvent();

  @override
  List<Object> get props => [];
}

class BookFacility extends BookFacilityEvent{
  final double depositMoney;
  final int facilityId;
  final double duration;
  final int fieldTypeId;
  final String startDateTime;


  BookFacility({required this.depositMoney,required this.facilityId,required this.fieldTypeId,required this.duration,required this.startDateTime});


  @override
  List<Object> get props => [depositMoney,facilityId,duration,fieldTypeId,startDateTime];
}