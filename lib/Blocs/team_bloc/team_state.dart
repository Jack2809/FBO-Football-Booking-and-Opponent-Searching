

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

abstract class TeamState extends Equatable{
  const TeamState();

  @override
  List<Object> get props => [];
}

class LoadingTeams extends TeamState{

}

class LoadedTeams extends TeamState{
  final List<Team> teamList;

  LoadedTeams({required this.teamList});

  @override
  List<Object> get props => [teamList];

}