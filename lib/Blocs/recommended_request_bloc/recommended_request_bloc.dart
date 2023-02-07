

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/recommended_request_bloc/recommended_request_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';
import 'package:rxdart/subjects.dart';


class RecommendedRequestBloc extends Bloc<RecommendedRequestEvent,RecommendedRequestState> {
  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  RecommendedRequestBloc() : super (LoadingRecommendedRequests()) {
    on<GetRecommendedRequest>((event, emit) async {
      emit(LoadingRecommendedRequests());
      var recommendedRequests = await getRecommendedRequest(event.requestId);
      emit(LoadedRecommendedRequests(requestList:recommendedRequests ));
    });
    on<SendChallengeRequest>((event, emit) async {
      var sentChallenge = await sendChallenge(event.myRequestId, event.opponentRequestId, event.myTeamId);
      log(sentChallenge);
    });

    on<CancelChallengeRequest>((event, emit) async {
      var canceledRequest = await declineRequest(event.opponentRequestId, event.myRequestId);
      listener.add(canceledRequest);
      var recommendedRequests = await getRecommendedRequest(event.myRequestId);
      emit(LoadedRecommendedRequests(requestList:recommendedRequests ));
      listener.add("");
    });


  }
}