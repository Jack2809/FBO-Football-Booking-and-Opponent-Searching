

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

abstract class TeamEvent extends Equatable{
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class FetchTeams extends TeamEvent{
  final int clubId;

  FetchTeams({required this.clubId});

  @override
  List<Object> get props => [clubId];
}

class DeleteTeam extends TeamEvent{
  final int clubId;
  final int teamId;
  DeleteTeam({required this.teamId,required this.clubId});

  @override
  List<Object> get props => [teamId,clubId];
}

class CreateTeam extends TeamEvent{
  final int clubId;
  final String teamName;
  CreateTeam({required this.clubId,required this.teamName});

  @override
  List<Object> get props => [clubId,teamName];
}