

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';

abstract class UserState extends Equatable{
  const UserState();


  @override
  List<Object> get props => [];
}

class LoadingUser extends UserState{

}

class LoadedUser extends UserState{

  UserInfoModel user;

  LoadedUser({required this.user});

  @override
  List<Object> get props => [user];

}