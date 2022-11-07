

import 'package:equatable/equatable.dart';

abstract class TimeSlotEvent extends Equatable{
  const TimeSlotEvent();

  @override
  List<Object> get props => [];
}

class FetchTimeSlot extends TimeSlotEvent{
  final int facilityId;
  final String bookingDate;
  final int fieldTypeId ;

  FetchTimeSlot({required this.facilityId,required this.bookingDate,required this.fieldTypeId});

  @override
  List<Object> get props => [facilityId,bookingDate,fieldTypeId];
}