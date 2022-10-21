

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_state.dart';
import 'package:football_booking_fbo_mobile/services/user_services.dart';

class UserBloc extends Bloc<UserEvent,UserState>{

  UserBloc() : super (LoadingUser()){
    on<FetchUser> ((event,emit) async{
      emit(LoadingUser());
      var userInfo = await getCurrentUser();
      emit(LoadedUser(user: userInfo));
    });

  }
}