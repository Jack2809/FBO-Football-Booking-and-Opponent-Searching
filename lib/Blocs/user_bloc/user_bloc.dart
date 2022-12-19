

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_event.dart';
import 'package:football_booking_fbo_mobile/Blocs/user_bloc/user_state.dart';
import 'package:football_booking_fbo_mobile/services/user_services.dart';
import 'package:rxdart/subjects.dart';

class UserBloc extends Bloc<UserEvent,UserState>{

  final BehaviorSubject<dynamic> _listenerController = BehaviorSubject<dynamic>();

  Sink<dynamic> get listener => _listenerController.sink;
  Stream<dynamic> get listenerStream => _listenerController.stream;

  UserBloc() : super (LoadingUser()){
    on<FetchUser> ((event,emit) async{
      emit(LoadingUser());
      var userInfo = await getCurrentUser(event.userId);
      emit(LoadedUser(user: userInfo));
    });

    on<UpdateUser> ((event,emit) async{
      emit(LoadingUser());
      var updatedUser = await updateUser(event.userId,event.email ,event.name, event.image, event.birthday, event.phone, event.address);
      listener.add(updatedUser);
      var userInfo = await getCurrentUser(event.userId);
      emit(LoadedUser(user: userInfo));
      listener.add("");
    });

  }
}