import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';
import 'package:football_booking_fbo_mobile/Models/opponent_request_model.dart';

abstract class MatchedPostState extends Equatable{
  const MatchedPostState();

  @override
  List<Object> get props => [];
}

class LoadingMatchedPost extends MatchedPostState{

}

class LoadedMatchedPost extends MatchedPostState{
  final MatchedRequest matchedRequest;

  LoadedMatchedPost({required this.matchedRequest});

  @override
  List<Object> get props => [matchedRequest];

}