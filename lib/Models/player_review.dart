

class PlayerReview{
  final int playerId;
  final String playerName;
  final bool isReviewed;
  final int star ;
  final String comment;
  final int reviewId;
  final bool blackListed;

  PlayerReview({
    required this.playerId,
    required this.playerName,
    required this.isReviewed,
    required this.star,
    required this.comment,
    required this.reviewId,
    required this.blackListed
});

  factory PlayerReview.fromJson(Map<String,dynamic> json){
    return PlayerReview(
        playerId: json['playerId'],
        playerName: json['playerName'],
        isReviewed: json['reviewed'],
        star: json['reviewsDTO'][0]['star'],
        comment: json['reviewsDTO'][0]['comment'] == null ? "" : json['reviewsDTO'][0]['comment'],
      reviewId: json['reviewsDTO'][0]['id'] == null ? 0 : json['reviewsDTO'][0]['id'],
      blackListed: json['blacklisted'] as bool
    );
  }

}