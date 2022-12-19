

import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/user_model.dart';
import 'package:football_booking_fbo_mobile/services/access_key_shared_references.dart';

abstract class UserAccessState extends Equatable{
  const UserAccessState();


  @override
  List<Object> get props => [];
}

class LoadingUserAccess extends UserAccessState{

}

class BannedAccount extends UserAccessState{

}

class LoadedUserAccess extends UserAccessState{

  UserModel user;

  LoadedUserAccess({required this.user});

  @override
  List<Object> get props => [user];

}