

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalo_state.dart';
import 'package:football_booking_fbo_mobile/Blocs/zalopay_bloc/zalopay_event.dart';
import 'package:football_booking_fbo_mobile/services/zalopay_services.dart';

class ZaloPayBloc extends Bloc<ZaloPayEvent,ZaloPayState>{

  ZaloPayBloc() : super (LoadingZaloPay()){
    on<CreateOrder> ((event,emit) async{
      // emit(LoadingZaloPay());
      var zaloPayResponse = await createOrder(event.totalAmount);
      emit(LoadedZaloPay(zaloPayResponse: zaloPayResponse));
    });

  }
}