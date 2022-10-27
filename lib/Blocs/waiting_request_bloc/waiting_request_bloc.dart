

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';

class WaitingRequestBloc extends Bloc<WaitingRequestEvent,WaitingRequestState> {
  WaitingRequestBloc() : super (LoadingWaitingRequests()) {
    on<GetWaitingRequest>((event, emit) async {
      emit(LoadingWaitingRequests());
      var waitingRequests = await getWaitingRequest(event.requestId);
      emit(LoadedWaitingRequests(requestList:waitingRequests ));
    });


  }
}