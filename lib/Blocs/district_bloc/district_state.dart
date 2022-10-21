

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/district_model.dart';

abstract class DistrictState extends Equatable{
  const DistrictState();

  @override
  List<Object> get props => [];
}

class LoadingDistricts extends DistrictState{

}

class LoadedDistricts extends DistrictState{
  final List<District> districtList;

  LoadedDistricts({required this.districtList});

  @override
  List<Object> get props => [districtList];

}