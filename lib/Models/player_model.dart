
import 'package:equatable/equatable.dart';

class Player extends Equatable{
  final int id;
  final String name;


  Player({required this.id,required this.name});

  factory Player.fromJson(Map<String,dynamic> json){
    return Player(
      id: json['playerId'] as int,
      name: json['playerName'] as String,
    );
  }

  @override
  List<Object?> get props => [id,name];

}

class PlayerCreationModel {
  final String name;
  final String phone;
  final int jerseyNo;
  final String email;
  final int age;



  PlayerCreationModel({
    required this.name,
    required this.phone,
    required this.jerseyNo,
    required this.email,
    required this.age,
  });

  factory PlayerCreationModel.fromJson(Map<String,dynamic> json){
    return PlayerCreationModel(
      name: json['playerName'] as String,
      phone: json['phone'] as String,
      jerseyNo: json['jerseyNo'] as int,
      email: json['email'] as String,
      age: json['age'] as int
    );
  }

}