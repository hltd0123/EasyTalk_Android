class UserProgresses {
  String id;
  String user;
  List<String> unlockedGates;
  List<String> unlockedStages;
  int experiencePoints;

  UserProgresses({
    required this.id,
    required this.user,
    this.unlockedGates = const [],
    this.unlockedStages = const [],
    this.experiencePoints = 0,
  });

  // Phương thức chuyển đổi object thành JSON theo định dạng MongoDB
  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id}, // Dùng định dạng JSON MongoDB cho ObjectId
      'user': user,
      'unlockedGates': unlockedGates,
      'unlockedStages': unlockedStages,
      'experiencePoints': experiencePoints,
    };
  }

  // Phương thức khởi tạo object từ JSON MongoDB
  factory UserProgresses.fromJson(Map<String, dynamic> json) {
    return UserProgresses(
      id: json['_id']['\$oid'],
      user: json['user'],
      unlockedGates: List<String>.from(json['unlockedGates'] ?? []),
      unlockedStages: List<String>.from(json['unlockedStages'] ?? []),
      experiencePoints: json['experiencePoints'] ?? 0,
    );
  }

  String getTableName(){
    return 'userprogresses';
  }
}
