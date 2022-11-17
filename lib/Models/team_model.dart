
class Team {
  final int id;
  final String name;
  final String description;
  final double teamScore;
  final String imageUrl;
  final int numberOfPlayers;

  Team({required this.id,required this.name,required this.description,required this.teamScore,required this.imageUrl,required this.numberOfPlayers});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      teamScore: json['teamScore'] as double,
      numberOfPlayers: json['numberOfPlayers'] as int
    );
  }
}