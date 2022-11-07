

import 'package:football_booking_fbo_mobile/Models/field_model.dart';

class FacilityWithMatchedPost {
  final String matchedTimeStart;
  final String matchedTimeEnd;
  final List<Facility> facilityList;

  FacilityWithMatchedPost({required this.matchedTimeStart,required this.matchedTimeEnd,required this.facilityList});

  factory FacilityWithMatchedPost.fromJson(Map<String, dynamic> json) {
    return FacilityWithMatchedPost(
      matchedTimeStart: json['timeslot']['timeStart'] as String,
      matchedTimeEnd: json['timeslot']['timeEnd'] as String,
      facilityList: json['facilities'].map<Facility>((json) => Facility.fromJson(json)).toList(),
    );
  }
}