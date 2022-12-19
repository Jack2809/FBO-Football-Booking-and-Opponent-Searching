


import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/player_review.dart';

abstract class PlayerReviewsState extends Equatable{
  const PlayerReviewsState();

  @override
  List<Object> get props => [];
}

class LoadingPlayerReviews extends PlayerReviewsState{

}

class LoadedPlayerReviews extends PlayerReviewsState{
  final List<PlayerReview> reviewList;

  LoadedPlayerReviews({required this.reviewList});

  @override
  List<Object> get props => [reviewList];

}