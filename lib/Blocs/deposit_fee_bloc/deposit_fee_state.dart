import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/deposit_fee_model.dart';


abstract class DepositFeeState extends Equatable{
  const DepositFeeState();

  @override
  List<Object> get props => [];
}

class LoadingDepositFee extends DepositFeeState{

}

class LoadedDepositFee extends DepositFeeState{
  final DepositFeeModel depositFeeModel;

  LoadedDepositFee({required this.depositFeeModel});

  @override
  List<Object> get props => [depositFeeModel];

}