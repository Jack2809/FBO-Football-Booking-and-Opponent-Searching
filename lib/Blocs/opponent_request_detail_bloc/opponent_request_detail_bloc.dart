

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';

import 'opponent_request_detail_event.dart';
import 'opponent_request_detail_state.dart';

class OpponentRequestDetailBloc extends Bloc<OpponentRequestDetailEvent,OpponentRequestDetailState> {
  OpponentRequestDetailBloc() : super (LoadingOpponentRequestDetail()) {
    on<FetchOpponentRequestDetail>((event, emit) async {
      emit(LoadingOpponentRequestDetail());
      var fetchedRequestDetail = await fetchOpponentRequestDetail(event.requestId);
      emit(LoadedOpponentRequestDetail(requestDetail: fetchedRequestDetail));
    });

  }
}