

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent{

  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent{
  @override
  List<Object> get props => [];
}
