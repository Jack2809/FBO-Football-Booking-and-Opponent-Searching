

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent{
  final int userId;

  FetchUser({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateUser extends UserEvent{
  final int userId;
  final String image;
  final String name;
  final String birthday;
  final String phone;
  final String address;
  final String email;


  UpdateUser({
    required this.userId,
    required this.image,
    required this.name,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.email

  });

  @override
  List<Object> get props => [userId,image,name,birthday,address,phone,email];
}

