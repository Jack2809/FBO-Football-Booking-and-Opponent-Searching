

import 'package:equatable/equatable.dart';

abstract class TeamDetailEvent extends Equatable{
  const TeamDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTeamDetail extends TeamDetailEvent{
  final int teamId;

  FetchTeamDetail({required this.teamId});


  @override
  List<Object> get props => [teamId];
}

class UpdateTeam extends TeamDetailEvent{
  final int teamId;
  final String teamName;
  final String description;
  final String imageUrl;
  UpdateTeam({required this.teamId,required this.teamName,required this.description,required this.imageUrl});

  @override
  List<Object> get props => [teamId,teamName,description,imageUrl];

}