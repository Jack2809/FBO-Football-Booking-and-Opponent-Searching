

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/match_history_score_bloc/match_history_score_state.dart';
import 'package:football_booking_fbo_mobile/services/match_history_services.dart';

class MatchHistoryScoreBloc extends Bloc<MatchHistoryScoreEvent,MatchHistoryScoreState> {
  MatchHistoryScoreBloc() : super (LoadingMatchHistoryScore()) {
    on<FetchMatchHistoryScore>((event, emit) async {
      emit(LoadingMatchHistoryScore());
      var matchScores = await getMatchScores(event.matchId,event.teamId);
      emit(LoadedMatchHistoryScore(matchScores: matchScores));
    });

    on<AddScore>((event, emit) async {
      // emit(LoadingMatchHistoryScore());
      var submitedScore = await submitScore(event.matchId,event.teamId,event.homeScore,event.awayScore);
      // emit(LoadedMatchHistoryScore(matchScores: matchScores));
    });

    on<SubmitScore>((event, emit) async {
      emit(LoadingMatchHistoryScore());
      // var submitedScore = await submitScore(event.matchId,event.teamId,event.homeScore,event.awayScore);
      var lockedScore = await lockScore(event.matchId, event.teamId,event.rivalry);
      var matchScores = await getMatchScores(event.matchId,event.teamId);
      emit(LoadedMatchHistoryScore(matchScores: matchScores));

    });

  }
}