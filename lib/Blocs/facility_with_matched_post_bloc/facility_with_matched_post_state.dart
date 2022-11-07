

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/facility_with_matched_post.dart';

abstract class FacilityWithMatchedPostState extends Equatable{
  const FacilityWithMatchedPostState();

  @override
  List<Object> get props => [];
}

class LoadingFacilityWithMatchedPost extends FacilityWithMatchedPostState{

}

class LoadedFacilityWithMatchedPost extends FacilityWithMatchedPostState{
  FacilityWithMatchedPost facilityData;

  LoadedFacilityWithMatchedPost({required this.facilityData});

  @override
  List<Object> get props => [facilityData];

}