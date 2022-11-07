


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_state.dart';

class MatchedPostBloc extends Bloc<BookedFacilityPostEvent,BookedFacilityPostState>{
  MatchedPostBloc() : super (LoadingBookedFacilityByPost()){
    on<BookFacilityByPost> ((event,emit) async{
      // emit(LoadingBookedFacilityByPost());
      // var bookedFacilityByPost = await
      // emit(LoadedMatchedPost(matchedRequest: matchedPost));
    });

  }

}