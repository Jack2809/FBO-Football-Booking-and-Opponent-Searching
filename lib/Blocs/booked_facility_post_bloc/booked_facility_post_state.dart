

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/booked_facility_post_model.dart';

abstract class BookedFacilityPostState extends Equatable{
  const BookedFacilityPostState();

  @override
  List<Object> get props => [];
}

class LoadingBookedFacilityByPost extends BookedFacilityPostState{

}

class LoadedBookedFacilityByPost extends BookedFacilityPostState{
  final BookedFacilityByPost bookedFacilityByPost;

  LoadedBookedFacilityByPost({required this.bookedFacilityByPost});

  @override
  List<Object> get props => [bookedFacilityByPost];

}