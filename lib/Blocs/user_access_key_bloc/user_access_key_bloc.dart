

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_access_key_bloc/user_access_key_state.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';
import 'package:football_booking_fbo_mobile/services/user_services.dart';

class UserAccessBloc extends Bloc<UserAccessEvent,UserAccessState>{

  UserAccessBloc() : super (LoadingUserAccess()){
    on<FetchUserAccess> ((event,emit) async{
      emit(LoadingUserAccess());
      var userAccess = await fetchUserIdAndAccessToken();
      var user = await getCurrentUser(userAccess.id);
      if(user.status == 0){
        emit(BannedAccount());
      }else{
        UserAccessKey.saveAccessKey(userAccess);
        emit(LoadedUserAccess(user: userAccess));
      }
    });

  }
}