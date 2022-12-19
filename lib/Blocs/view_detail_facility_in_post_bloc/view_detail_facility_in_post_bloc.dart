

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/view_detail_facility_in_post_bloc/view_detail_facility_in_post_state.dart';
import 'package:football_booking_fbo_mobile/services/field_services.dart';

class ViewDetailFacilityBloc extends Bloc<ViewDetailFacilityEvent,ViewDetailFacilityState>{

  ViewDetailFacilityBloc() : super (LoadingDetailFacility()){
    on<FetchDetailFacility> ((event,emit) async{
      emit(LoadingDetailFacility());
      var facility = await getFieldById(event.facilityId);
      emit(LoadedDetailFacility(field:facility));
    });

  }
}