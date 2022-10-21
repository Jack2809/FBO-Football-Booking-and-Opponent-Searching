import 'package:equatable/equatable.dart';


abstract class ClubEvent extends Equatable{
  const ClubEvent();

  @override
  List<Object> get props => [];
}

class FetchClubs extends ClubEvent{

  @override
  List<Object> get props => [];
}

class DeleteClub extends ClubEvent{
  final int clubId;
  DeleteClub({required this.clubId});

  @override
  List<Object> get props => [clubId];
}

class CreateClub extends ClubEvent{
  final String clubName;
  CreateClub({required this.clubName});

  @override
  List<Object> get props => [clubName];
}



