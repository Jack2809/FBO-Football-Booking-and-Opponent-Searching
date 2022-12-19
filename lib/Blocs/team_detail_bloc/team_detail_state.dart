


import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

abstract class TeamDetailState extends Equatable{
  const TeamDetailState();

  @override
  List<Object> get props => [];
}

class LoadingTeamDetail extends TeamDetailState{

}

class LoadedTeamDetail extends TeamDetailState{
  final TeamDetail team;

  LoadedTeamDetail({required this.team});

  @override
  List<Object> get props => [team];

}