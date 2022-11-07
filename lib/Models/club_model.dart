

import 'player_model.dart';
import 'team_model.dart';

class Club{
  // final String image;
  final int id;
  final String name;
  // final String description;
  // final String description;
  // final List<Player> playerList;

Club({required this.id,required this.name});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] as int,
      name: json['clubName'] as String,
      // description: json['description'] as String
    );
  }


  // Club({required this.image,required this.name,required this.description,required this.playerList,});
}