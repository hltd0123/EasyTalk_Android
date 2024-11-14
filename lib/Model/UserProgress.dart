class UserProgress {
  String id;
  String user;
  List<String> unlockedGates;
  List<String> unlockedStages;
  int experiencePoints;

  UserProgress({
    required this.id,
    required this.user,
    required this.unlockedGates,
    required this.unlockedStages,
    required this.experiencePoints,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['_id'],
      user: json['user'],
      unlockedGates: List<String>.from(json['unlockedGates']),
      unlockedStages: List<String>.from(json['unlockedStages']),
      experiencePoints: json['experiencePoints'],
    );
  }
}
