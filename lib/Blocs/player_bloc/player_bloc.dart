
import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_state.dart';
import 'package:football_booking_fbo_mobile/services/club_player_services.dart';



class PlayerClubBloc extends Bloc<PlayerClubEvent,PlayerClubState>{
  PlayerClubBloc() : super (LoadingClubPlayers()){
    on<FetchClubPlayers> ((event,emit) async{
      emit(LoadingClubPlayers());
      var fetchedPlayersClubList = await fetchPlayersInClub(event.clubId);
      emit(LoadedClubPlayers(clubPlayersList: fetchedPlayersClubList));
    });

    on<CreatePlayer> ((event,emit) async{
      emit(LoadingClubPlayers());
      var createdPlayer = await createPlayerInClub(event.createdPlayer, event.clubId);
      // log(createdPlayer);
      var fetchedPlayersClubListAfterCreation = await fetchPlayersInClub(event.clubId);
      emit(LoadedClubPlayers(clubPlayersList: fetchedPlayersClubListAfterCreation));
    });

    on<DeletePlayer> ((event,emit) async{
      emit(LoadingClubPlayers());
      var deletedPlayerClub = await deletePlayerInClub(event.clubId,event.playerId);
      log(deletedPlayerClub);
      var fetchedPlayersClubListAfterDeletion = await fetchPlayersInClub(event.clubId);
      log(fetchedPlayersClubListAfterDeletion.length.toString());
      emit(LoadedClubPlayers(clubPlayersList: fetchedPlayersClubListAfterDeletion));
    });



  }

}