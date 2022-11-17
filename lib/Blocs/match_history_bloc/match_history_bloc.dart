


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_bloc/match_history_event.dart';
import 'package:football_booking_fbo_mobile/services/match_history_services.dart';
import 'match_history_state.dart';

class MatchHistoryBloc extends Bloc<MatchHistoryEvent,MatchHistoryState> {
  MatchHistoryBloc() : super (LoadingMatchHistory()) {
    on<FetchMatchHistory>((event, emit) async {
      emit(LoadingMatchHistory());
      var matchHistoryList = await fetchMatchHistory(event.teamId);
      emit(LoadedMatchHistory(matchHistoryList: matchHistoryList));
    });

  }
}