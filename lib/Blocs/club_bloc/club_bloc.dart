//
// import 'dart:async';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
// import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_state.dart';
// import 'package:football_booking_fbo_mobile/services/club_services.dart';
//
//
// class ClubBloc extends Bloc<ClubEvent,ClubState>{
//
//
//   ClubBloc():super(ClubState(clubList: [], isLoading: true)){
//     on((event,emit) async {
//       if(event is FetchClubs){
//         var clubList = await fetchClubs();
//         emit(state.copyWith(newClubList: clubList,isLoading: false));
//       }else if (event is ChangeLoading){
//         emit(state.copyWith(newClubList: state.clubList, isLoading: true));
//       }else if( event is FetchAfterCreateClub){
//         var clubList = await fetchClubsAfterCreation(event.club);
//         emit(state.copyWith(newClubList: clubList,isLoading: false));
//       }else if(event is DeleteClub){
//          var clubList = await deleteClub(event.selectedIndexClub);
//          print(clubList.length.toString());
//         emit(state.copyWith(newClubList: clubList, isLoading: false));
//       }
//     }
//     );
//   }
//
//
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/club_bloc/club_state.dart';
import 'package:football_booking_fbo_mobile/Validator/club_validator.dart';
import 'package:football_booking_fbo_mobile/services/club_services.dart';

class ClubBloc extends Bloc<ClubEvent,ClubState>{
  ClubBloc() : super (LoadingClubs()){
    on<FetchClubs> ((event,emit) async{
      emit(LoadingClubs());
      var fetchedList = await fetchClubs();
      emit(LoadedClubs(clubList:fetchedList /*event.fetchClub*/));
    });

    on<DeleteClub> ((event,emit) async{
      emit(LoadingClubs());
      var deletedList = await deleteClub(event.clubId);
      var fetchedListAfterDeletion = await fetchClubs();
      emit(LoadedClubs(clubList: fetchedListAfterDeletion));
    });

    on<CreateClub> ((event,emit) async{
        emit(LoadingClubs());
        var createdList = await createClub(event.clubName);
        var fetchedListAfterCreation = await fetchClubs();
        emit(LoadedClubs(clubList: fetchedListAfterCreation));

    });

  }

}
