class Leaderboard {
  String id;
  int experiencePoints;
  String username;

  Leaderboard({
    required this.id,
    required this.experiencePoints,
    required this.username,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      id: json['_id'],
      experiencePoints: json['experiencePoints'],
      username: json['username'],
    );
  }
}
