

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/time_slot_booking_facitily_post_bloc/time_slot_state.dart';
import 'package:football_booking_fbo_mobile/services/time_slot_services.dart';

class TimeSlotBloc extends Bloc<TimeSlotEvent,TimeSlotState>{
  TimeSlotBloc() : super (LoadingTimeSlot()){
    on<FetchTimeSlot> ((event,emit) async{
      emit(LoadingTimeSlot());
      var fetchedTimeSlotList = await fetchTimeSlots(event.facilityId,event.bookingDate,event.fieldTypeId);
      emit(LoadedTimeSlot(timeSlotList: fetchedTimeSlotList));
    });


  }

}