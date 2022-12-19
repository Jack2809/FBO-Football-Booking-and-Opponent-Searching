import 'package:equatable/equatable.dart';


abstract class PlayerReviewsEvent extends Equatable{
  const PlayerReviewsEvent();

  @override
  List<Object> get props => [];
}

class FetchReviews extends PlayerReviewsEvent{
  final int matchId;
  final int myTeamId;

  FetchReviews({required this.matchId,required this.myTeamId});

  @override
  List<Object> get props => [matchId,myTeamId];
}

class CreatePlayerReview extends PlayerReviewsEvent{
  final int matchId;
  final int reviewedPlayerId;
  final String comment;
  final int star;
  final int teamId;

  CreatePlayerReview({required this.matchId,required this.reviewedPlayerId,required this.comment,required this.star,required this.teamId});

  @override
  List<Object> get props => [matchId,reviewedPlayerId,comment,star,teamId];
}

class UpdatePlayerReview extends PlayerReviewsEvent{
  final int matchId;
  final int reviewId;
  final String comment;
  final int star;
  final int teamId;

  UpdatePlayerReview({required this.matchId,required this.reviewId,required this.comment,required this.star,required this.teamId});

  @override
  List<Object> get props => [matchId,reviewId,comment,star,teamId];
}

class LockPlayer extends PlayerReviewsEvent{
  final int playerId;
  final int matchId;
  final int teamId;

  LockPlayer({required this.playerId,required this.teamId,required this.matchId});

  @override
  List<Object> get props => [playerId,teamId,matchId];
}