import 'package:equatable/equatable.dart';

abstract class BookedFacilityPostEvent extends Equatable{
  const BookedFacilityPostEvent();

  @override
  List<Object> get props => [];
}

class BookFacilityByPost extends BookedFacilityPostEvent{
  final int postId;
<<<<<<< HEAD
  final double depositMoney;
=======
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
  final int facilityId;
  final double duration;
  final int fieldTypeId;
  final String startDateTime;

<<<<<<< HEAD
  BookFacilityByPost({required this.postId,required this.depositMoney,required this.facilityId,required this.fieldTypeId,required this.duration,required this.startDateTime});


  @override
  List<Object> get props => [postId,depositMoney,facilityId,duration,fieldTypeId,startDateTime];
}

class GetBookedFacilityByPost extends BookedFacilityPostEvent{
  final int postId;

  GetBookedFacilityByPost({required this.postId});


  @override
  List<Object> get props => [postId];
=======
  BookFacilityByPost({required this.postId,required this.facilityId,required this.fieldTypeId,required this.duration,required this.startDateTime});


  @override
  List<Object> get props => [postId,facilityId,duration,fieldTypeId,startDateTime];
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
}