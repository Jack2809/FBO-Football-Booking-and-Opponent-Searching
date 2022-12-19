


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/services/team_services.dart';
import 'package:rxdart/subjects.dart';


class TeamBloc extends Bloc<TeamEvent,TeamState>{

  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  TeamBloc() : super (LoadingTeams()){

    on<FetchTeams> ((event,emit) async{
      emit(LoadingTeams());
      var fetchedTeamList = await fetchTeams();
      emit(LoadedTeams(teamList: fetchedTeamList));
    });

    on<CreateTeam> ((event,emit) async{
      emit(LoadingTeams());
      var createdTeam = await createTeam(event.teamName,event.description,event.imageUrl);
      listener.add(createdTeam);
      var fetchedTeamListAfterCreation = await fetchTeams();
      for(var team in fetchedTeamListAfterCreation){
        if(team.numberOfPlayers == 0){
          var temp = await joinAsPlayer(team.id);
        }
      }
      emit(LoadedTeams(teamList: fetchedTeamListAfterCreation));
      listener.add('');
    });
    //
    on<DeleteTeam> ((event,emit) async{
      emit(LoadingTeams());
      var deletedTeam = await deleteTeam(event.teamId);
      listener.add(deletedTeam);
      var fetchedTeamListAfterDeletion = await fetchTeams();
      emit(LoadedTeams(teamList: fetchedTeamListAfterDeletion));
      listener.add("");
    });

  }

}