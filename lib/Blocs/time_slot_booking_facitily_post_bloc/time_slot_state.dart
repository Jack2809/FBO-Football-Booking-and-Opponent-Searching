


import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/time_slot_model.dart';

abstract class TimeSlotState extends Equatable{
  const TimeSlotState();

  @override
  List<Object> get props => [];
}

class LoadingTimeSlot extends TimeSlotState{

}

class LoadedTimeSlot extends TimeSlotState{
  final List<TimeSlot> timeSlotList;

  LoadedTimeSlot({required this.timeSlotList});

  @override
  List<Object> get props => [timeSlotList];

}