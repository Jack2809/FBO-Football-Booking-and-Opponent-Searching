


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/billpay_bloc/billpay_state.dart';
import 'package:football_booking_fbo_mobile/services/bill_pay_services.dart';

class BillPayBloc extends Bloc<BillPayEvent,BillPayState> {

  BillPayBloc() : super (LoadingBillPay()) {
    on<FetchBillPay>((event, emit) async {
      emit(LoadingBillPay());
      var billPayList = await fetchBillPay();
      emit(LoadedBillPay(billPayList:billPayList));
    });


  }
}