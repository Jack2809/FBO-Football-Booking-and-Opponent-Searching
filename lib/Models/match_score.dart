

class MatchScores {
  final MatchScore homeTeam;
  final MatchScore awayTeam;
  
  MatchScores({required this.homeTeam,required this.awayTeam});
  
  factory MatchScores.fromJson(Map<String,dynamic> json){
    return MatchScores(
        homeTeam: MatchScore.fromJson(json['homeTeamScores']),
        awayTeam: MatchScore.fromJson(json['awayTeamScores']));
  }
}


class MatchScore {
  final int teamId;
  final int homeScore;
  final int awayScore;

  MatchScore({required this.teamId,required this.homeScore,required this.awayScore});

  factory MatchScore.fromJson(Map<String, dynamic> json){
    return MatchScore(
        teamId: json['teamId'],
        homeScore: json['homeScore'],
        awayScore: json['awayScore']);
  }
}