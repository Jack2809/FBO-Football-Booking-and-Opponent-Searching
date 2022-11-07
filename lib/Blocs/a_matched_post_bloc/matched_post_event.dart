import 'package:equatable/equatable.dart';

abstract class MatchedPostEvent extends Equatable{
  const MatchedPostEvent();

  @override
  List<Object> get props => [];
}

class GetMatchedPost extends MatchedPostEvent{
  final int myPostId;

  GetMatchedPost({required this.myPostId});


  @override
  List<Object> get props => [myPostId];
}