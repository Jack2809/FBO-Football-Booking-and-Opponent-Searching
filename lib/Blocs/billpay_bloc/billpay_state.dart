

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/bill_pay.dart';

abstract class BillPayState extends Equatable{
  const BillPayState();

  @override
  List<Object> get props => [];
}



class LoadingBillPay extends BillPayState{

}

class LoadedBillPay extends BillPayState{

  List<BillPay> billPayList;

  LoadedBillPay({required this.billPayList});

  @override
  List<Object> get props => [billPayList];

}