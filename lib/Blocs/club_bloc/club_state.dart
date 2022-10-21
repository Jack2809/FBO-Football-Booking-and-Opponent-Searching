

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/club_model.dart';

abstract class ClubState extends Equatable{
  const ClubState();

  @override
  List<Object> get props => [];
}

class LoadingClubs extends ClubState{

}

class LoadedClubs extends ClubState{
  final List<Club> clubList;

  LoadedClubs({required this.clubList});

  @override
  List<Object> get props => [clubList];

}
