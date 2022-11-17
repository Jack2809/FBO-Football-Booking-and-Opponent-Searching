import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/booked_facility_post_bloc/booked_facility_post_state.dart';
import 'package:football_booking_fbo_mobile/services/book_facility_service.dart';

class BookedFacilityByPostBloc
    extends Bloc<BookedFacilityPostEvent, BookedFacilityPostState> {
  BookedFacilityByPostBloc() : super (LoadingBookedFacilityByPost()) {
    on<BookFacilityByPost>((event, emit) async {
      var bookedFacilityByPost = await bookFacilityByPost(
          event.postId, event.depositMoney, event.facilityId, event.duration,
          event.fieldTypeId, event.startDateTime);
      log('book message:' + bookedFacilityByPost);
    });

    on<GetBookedFacilityByPost>((event, emit) async {
      emit(LoadingBookedFacilityByPost());
      var fetchBookedFacility = await getBookedFacilityByPost(event.postId);
      emit(LoadedBookedFacilityByPost(
          bookedFacilityByPost: fetchBookedFacility));
    });
  }
}

