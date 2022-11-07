

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

abstract class TeamEvent extends Equatable{
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class FetchTeams extends TeamEvent{

}

class DeleteTeam extends TeamEvent{
  final int teamId;
  DeleteTeam({required this.teamId});

  @override
  List<Object> get props => [teamId,];
}

class CreateTeam extends TeamEvent{
  final String teamName;
  CreateTeam({required this.teamName});

  @override
  List<Object> get props => [teamName];
}