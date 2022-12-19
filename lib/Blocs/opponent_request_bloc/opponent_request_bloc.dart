import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/opponent_request_bloc/opponent_request_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';
import 'package:rxdart/subjects.dart';

class OpponentRequestBloc extends Bloc<OpponentRequestEvent,OpponentRequestState> {
  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  OpponentRequestBloc() : super (LoadingOpponentRequests()) {
    on<FetchOpponentRequests>((event, emit) async {
      emit(LoadingOpponentRequests());
      var fetchedRequestList = await fetchOpponentRequests();
      emit(LoadedOpponentRequests(requestList:fetchedRequestList));
    });

    on<DeleteOpponentRequest> ((event,emit) async{
      emit(LoadingOpponentRequests());
      var deletedOpponentRequest = await deleteOpponentRequest(event.requestId);
      listener.add(deletedOpponentRequest);
      var fetchedRequestListAfterDeletion = await fetchOpponentRequests();
      emit(LoadedOpponentRequests(requestList:fetchedRequestListAfterDeletion));
      listener.add('');
    });

    on<CreateOpponentRequest> ((event,emit) async{
      emit(LoadingOpponentRequests());
      var createdOpponentRequest = await createOpponentRequest(event.districtIdList, event.bookingDate, event.duration, event.freetimeStart, event.freetimeEnd, event.fieldTypeId, event.teamId,event.isRivalry);
        listener.add(createdOpponentRequest);
        var fetchedRequestListAfterCreation = await fetchOpponentRequests();
        emit(LoadedOpponentRequests(requestList:fetchedRequestListAfterCreation ));
        listener.add('');
    });

  }
}