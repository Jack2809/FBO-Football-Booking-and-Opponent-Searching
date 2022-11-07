

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/a_matched_post_bloc/matched_post_state.dart';
import 'package:football_booking_fbo_mobile/services/opponent_request_services.dart';

class MatchedPostBloc extends Bloc<MatchedPostEvent,MatchedPostState>{
  MatchedPostBloc() : super (LoadingMatchedPost()){
    on<GetMatchedPost> ((event,emit) async{
      emit(LoadingMatchedPost());
      var matchedPost = await getMatchedRequest(event.myPostId);
      emit(LoadedMatchedPost(matchedRequest: matchedPost));
    });

  }

}