

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/facility_with_matched_post_bloc/facility_with_matched_post_state.dart';
import 'package:football_booking_fbo_mobile/services/facility_with_matched_post_services.dart';

class FacilityWithMatchedPostBloc extends Bloc<FacilityWithMatchedPostEvent,FacilityWithMatchedPostState>{
  FacilityWithMatchedPostBloc() : super (LoadingFacilityWithMatchedPost()){
    on<FetchFacilityWithMatchedPost> ((event,emit) async{
      emit(LoadingFacilityWithMatchedPost());
      var fetchedFacilities = await fetchFacilityWithMatchedPost(event.myRequestId,event.opponentRequestId,event.duration,event.fieldTypeId,event.startDate);
      emit(LoadedFacilityWithMatchedPost(facilityData: fetchedFacilities));
    });



  }

}