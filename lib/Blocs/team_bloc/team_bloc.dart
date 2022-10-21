


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/services/team_services.dart';


class TeamBloc extends Bloc<TeamEvent,TeamState>{
  TeamBloc() : super (LoadingTeams()){
    on<FetchTeams> ((event,emit) async{
      emit(LoadingTeams());
      var fetchedTeamList = await fetchTeams(event.clubId);
      emit(LoadedTeams(teamList: fetchedTeamList));
    });

    on<CreateTeam> ((event,emit) async{
      emit(LoadingTeams());
      var createdTeam = await createTeam(event.clubId, event.teamName);
      var fetchedTeamListAfterCreation = await fetchTeams(event.clubId);
      emit(LoadedTeams(teamList: fetchedTeamListAfterCreation));
    });

    on<DeleteTeam> ((event,emit) async{
      emit(LoadingTeams());
      var createdTeam = await deleteTeam(event.teamId);
      var fetchedTeamListAfterDeletion = await fetchTeams(event.clubId);
      emit(LoadedTeams(teamList: fetchedTeamListAfterDeletion));
    });



  }

}