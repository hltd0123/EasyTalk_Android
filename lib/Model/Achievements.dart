class Achievements {
  int unlockedGates;
  int unlockedStages;
  int experiencePoints;

  Achievements({
    required this.unlockedGates,
    required this.unlockedStages,
    required this.experiencePoints,
  });

  factory Achievements.fromJson(Map<String, dynamic> json) {
    return Achievements(
      unlockedGates: json['unlockedGates'],
      unlockedStages: json['unlockedStages'],
      experiencePoints: json['experiencePoints'],
    );
  }
}
