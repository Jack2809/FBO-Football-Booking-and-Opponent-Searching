import 'package:equatable/equatable.dart';

abstract class DepositFeeEvent extends Equatable{
  const DepositFeeEvent();

  @override
  List<Object> get props => [];
}

class GetDepositFee extends DepositFeeEvent{
  final int facilityId;
  final double duration;
  final int fieldTypeId;
  final String startDateTime;


  GetDepositFee({required this.facilityId,required this.duration,required this.fieldTypeId,required this.startDateTime});


  @override
  List<Object> get props => [facilityId,duration,fieldTypeId,startDateTime];
}