import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/waiting_request_bloc/waiting_request_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';
import 'package:rxdart/subjects.dart';

class WaitingRequestBloc extends Bloc<WaitingRequestEvent,WaitingRequestState> {
  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  WaitingRequestBloc() : super (LoadingWaitingRequests()) {
    on<GetWaitingRequest>((event, emit) async {
      emit(LoadingWaitingRequests());
      var waitingRequests = await getWaitingRequest(event.requestId);
      emit(LoadedWaitingRequests(requestList:waitingRequests ));
    });
    on<AcceptWaitingRequestChallenge>((event, emit) async {
      var acceptedRequestChallenge = await acceptChallenge(event.myRequestId,event.opponentRequestId,event.opponentTeamId);
      listener.add(acceptedRequestChallenge);
      log(acceptedRequestChallenge);
      listener.add("");

    });

    on<DeclineWaitingRequestChallenge>((event, emit) async {
      emit(LoadingWaitingRequests());
      var declinedRequest = await declineRequest(event.myRequestId, event.opponentRequestId);
      var reloadWaitingRequests = await getWaitingRequest(event.myRequestId);
      emit(LoadedWaitingRequests(requestList:reloadWaitingRequests ));

    });

  }
}