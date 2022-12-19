

import 'package:equatable/equatable.dart';

abstract class UserAccessEvent extends Equatable{
  const UserAccessEvent();

  @override
  List<Object> get props => [];
}

class FetchUserAccess extends UserAccessEvent{

  @override
  List<Object> get props => [];
}