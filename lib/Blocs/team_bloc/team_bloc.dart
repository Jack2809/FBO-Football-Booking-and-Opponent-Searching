


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/team_bloc/team_state.dart';
import 'package:football_booking_fbo_mobile/services/team_services.dart';


class TeamBloc extends Bloc<TeamEvent,TeamState>{
  TeamBloc() : super (LoadingTeams()){
    on<FetchTeams> ((event,emit) async{
      emit(LoadingTeams());
      var fetchedTeamList = await fetchTeams();
      emit(LoadedTeams(teamList: fetchedTeamList));
    });

    on<CreateTeam> ((event,emit) async{
      emit(LoadingTeams());
<<<<<<< HEAD
      var createdTeam = await createTeam(event.teamName,event.description,event.imageUrl);
=======
      var createdTeam = await createTeam(event.teamName);
>>>>>>> f7fbb583d6e9cdbbcbb9f5e0109f4ee8d3a9bc55
      var fetchedTeamListAfterCreation = await fetchTeams();
      emit(LoadedTeams(teamList: fetchedTeamListAfterCreation));
    });
    //
    on<DeleteTeam> ((event,emit) async{
      emit(LoadingTeams());
      var deletedTeam = await deleteTeam(event.teamId);
      var fetchedTeamListAfterDeletion = await fetchTeams();
      emit(LoadedTeams(teamList: fetchedTeamListAfterDeletion));
    });



  }

}