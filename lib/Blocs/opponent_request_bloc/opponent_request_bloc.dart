

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';

class OpponentRequestBloc extends Bloc<OpponentRequestEvent,OpponentRequestState> {
  OpponentRequestBloc() : super (LoadingOpponentRequests()) {
    on<FetchOpponentRequests>((event, emit) async {
      emit(LoadingOpponentRequests());
      var fetchedRequestList = await fetchOpponentRequests();
      emit(LoadedOpponentRequests(requestList:fetchedRequestList ));
    });

    on<DeleteOpponentRequest> ((event,emit) async{
      emit(LoadingOpponentRequests());
      var deletedOpponentRequest = await deleteOpponentRequest(event.requestId);
      log("message:"+deletedOpponentRequest);
      var fetchedRequestListAfterDeletion = await fetchOpponentRequests();
      emit(LoadedOpponentRequests(requestList:fetchedRequestListAfterDeletion));
    });

    on<CreateOpponentRequest> ((event,emit) async{
      emit(LoadingOpponentRequests());
      var createdOpponentRequest = await createOpponentRequest(event.districtIdList, event.bookingDate, event.duration, event.freetimeStart, event.freetimeEnd, event.fieldTypeId, event.teamId);
      log("message:"+createdOpponentRequest);
      var fetchedRequestListAfterCreation = await fetchOpponentRequests();
      emit(LoadedOpponentRequests(requestList:fetchedRequestListAfterCreation ));

    });

  }
}