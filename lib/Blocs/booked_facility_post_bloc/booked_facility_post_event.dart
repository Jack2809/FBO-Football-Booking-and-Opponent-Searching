import 'package:equatable/equatable.dart';

abstract class BookedFacilityPostEvent extends Equatable{
  const BookedFacilityPostEvent();

  @override
  List<Object> get props => [];
}

class BookFacilityByPost extends BookedFacilityPostEvent{
  final int postId;
  final int facilityId;
  final double duration;
  final int fieldTypeId;
  final String startDateTime;

  BookFacilityByPost({required this.postId,required this.facilityId,required this.fieldTypeId,required this.duration,required this.startDateTime});


  @override
  List<Object> get props => [postId,facilityId,duration,fieldTypeId,startDateTime];
}