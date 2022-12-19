import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/services/player_review_services.dart';
import 'review_player_event.dart';
import 'review_player_state.dart';

class PlayerReviewsBloc extends Bloc<PlayerReviewsEvent,PlayerReviewsState>{

  PlayerReviewsBloc() : super (LoadingPlayerReviews()){

    on<FetchReviews> ((event,emit) async{
      emit(LoadingPlayerReviews());
      var reviewList = await fetchPlayerReviews(event.matchId,event.myTeamId);
      emit(LoadedPlayerReviews(reviewList: reviewList));
    });

    on<CreatePlayerReview> ((event,emit) async{
      emit(LoadingPlayerReviews());
      var createdPlayerReview = await createPlayerReview(event.matchId, event.reviewedPlayerId, event.comment, event.star);
      var reviewList = await fetchPlayerReviews(event.matchId,event.teamId);
      emit(LoadedPlayerReviews(reviewList: reviewList));
    });

    on<UpdatePlayerReview> ((event,emit) async{
      emit(LoadingPlayerReviews());
      var updatedPlayerReview = await updatePlayerReview(event.matchId, event.reviewId, event.comment, event.star);
      var reviewList = await fetchPlayerReviews(event.matchId,event.teamId);
      emit(LoadedPlayerReviews(reviewList: reviewList));
    });

    on<LockPlayer> ((event,emit) async{
      emit(LoadingPlayerReviews());
      var lockedPlayer = await lockPlayer(event.playerId);
      var reviewList = await fetchPlayerReviews(event.matchId,event.teamId);
      emit(LoadedPlayerReviews(reviewList: reviewList));
    });



  }


}