
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/field_model.dart';

abstract class ViewDetailFacilityState extends Equatable{
  const ViewDetailFacilityState();


  @override
  List<Object> get props => [];
}

class LoadingDetailFacility extends ViewDetailFacilityState{

}

class LoadedDetailFacility extends ViewDetailFacilityState{

  Field field;

  LoadedDetailFacility({required this.field});

  @override
  List<Object> get props => [field];

}