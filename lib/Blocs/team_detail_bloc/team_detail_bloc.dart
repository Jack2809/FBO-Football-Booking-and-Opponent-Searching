


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/services/team_services.dart';
import 'package:rxdart/subjects.dart';

import 'team_detail_event.dart';
import 'team_detail_state.dart';

class TeamDetailBloc extends Bloc<TeamDetailEvent,TeamDetailState>{

  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  TeamDetailBloc() : super (LoadingTeamDetail()){
    on<FetchTeamDetail> ((event,emit) async{
      emit(LoadingTeamDetail());
      var fetchedTeamDetail = await fetchTeamDetail(event.teamId);
      emit(LoadedTeamDetail(team: fetchedTeamDetail));
    });

    on<UpdateTeam> ((event,emit) async{
      emit(LoadingTeamDetail());
      var updatedTeam = await updateTeam(event.teamId,event.teamName,event.description,event.imageUrl);
      listener.add(updatedTeam);
      var fetchedTeamDetail = await fetchTeamDetail(event.teamId);
      emit(LoadedTeamDetail(team: fetchedTeamDetail));
      listener.add('');
    });



  }

}