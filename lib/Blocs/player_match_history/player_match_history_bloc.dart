

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_match_history/player_match_history_state.dart';

import '../../services/player_match_history.dart';

class PlayerMatchHistoryBloc extends Bloc<PlayerMatchHistoryEvent,PlayerMatchHistoryState> {
  PlayerMatchHistoryBloc() : super (LoadingPlayerMatchHistory()) {
    on<FetchPlayerMatchHistory>((event, emit) async {
      emit(LoadingPlayerMatchHistory());
      var playerMatchHistoryList = await fetchPlayerMatchHistory(event.phoneNumber);
      emit(LoadedPlayerMatchHistory(matchHistoryList: playerMatchHistoryList));
    });

  }
}