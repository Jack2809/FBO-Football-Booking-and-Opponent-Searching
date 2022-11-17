

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/deposit_fee_bloc/deposit_fee_state.dart';
import 'package:football_booking_fbo_mobile/services/deposit_fee_services.dart';

class DepositFeeBloc extends Bloc<DepositFeeEvent,DepositFeeState>{
  DepositFeeBloc() : super (LoadingDepositFee()){
    on<GetDepositFee> ((event,emit) async{
      emit(LoadingDepositFee());
      final depositFee = await getDepositFee(event.facilityId,event.duration, event.fieldTypeId, event.startDateTime);
      emit(LoadedDepositFee(depositFeeModel: depositFee));
    });

  }

}