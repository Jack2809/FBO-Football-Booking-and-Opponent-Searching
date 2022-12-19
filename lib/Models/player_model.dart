
import 'package:equatable/equatable.dart';
import 'package:football_booking_fbo_mobile/Models/team_model.dart';

class Player extends Equatable{
  final int id;
  final String name;
  final String phone;
  final List<JoinedTeam> teamList;


  Player({required this.id,required this.name,required this.phone,required this.teamList});

  factory Player.fromJson(Map<String,dynamic> json){
    return Player(
      id: json['id'] as int,
      name: json['playerName'] as String,
      phone: json['phone'] ?? "",
      teamList: json['teamsJoined'].map<JoinedTeam>((json) => JoinedTeam.fromJson(json)).toList(),
    );
  }

  @override
  List<Object?> get props => [id,name];

}

class TeamPlayer extends Equatable{
  final int id;
  final String name;
  final String phone;


  TeamPlayer({required this.id,required this.name,required this.phone});

  factory TeamPlayer.fromJson(Map<String,dynamic> json){
    return TeamPlayer(
      id: json['playerId'] as int,
      name: json['playerName'] as String,
      phone: json['playerPhone'] ?? ""
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