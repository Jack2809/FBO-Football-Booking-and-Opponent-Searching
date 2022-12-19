
import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/player_bloc/player_state.dart';
import 'package:football_booking_fbo_mobile/services/club_player_services.dart';
import 'package:rxdart/subjects.dart';



class PlayerBloc extends Bloc<PlayerEvent,PlayerState>{

  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;


  PlayerBloc() : super (LoadingPlayers()){
    on<FetchPlayers> ((event,emit) async{
      emit(LoadingPlayers());
      var fetchedPlayersList = await fetchPlayers();
      emit(LoadedPlayers(playersList: fetchedPlayersList));
    });

    on<CreatePlayer> ((event,emit) async{
      emit(LoadingPlayers());
      var createdPlayer = await createPlayerInClub(event.createdPlayer, event.clubId);
      // log(createdPlayer);
      var fetchedPlayersClubListAfterCreation = await fetchPlayers();
      emit(LoadedPlayers(playersList: fetchedPlayersClubListAfterCreation));
    });

    on<DeletePlayer> ((event,emit) async{
      emit(LoadingPlayers());
      var deletedPlayer = await deletePlayer(event.playerId);
      listener.add(deletedPlayer);
      var fetchedPlayersListAfterDeletion = await fetchPlayers();
      log(fetchedPlayersListAfterDeletion.length.toString());
      emit(LoadedPlayers(playersList: fetchedPlayersListAfterDeletion));
      listener.add("");
    });



  }

}