class Reminder {
  String id;
  String user;
  String email;
  DateTime reminderTime;
  String frequency;
  String status;
  Map<String, dynamic> additionalInfo;

  Reminder({
    required this.id,
    required this.user,
    required this.email,
    required this.reminderTime,
    required this.frequency,
    required this.status,
    this.additionalInfo = const {},
  });

  // Phương thức chuyển object thành JSON theo định dạng MongoDB
  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id}, // Dùng định dạng JSON MongoDB cho ObjectId
      'user': user,
      'email': email,
      'reminderTime': {'\$date': reminderTime.toIso8601String()}, // Dùng định dạng ISO cho Date
      'frequency': frequency,
      'status': status,
      'additionalInfo': additionalInfo,
    };
  }

  // Phương thức khởi tạo object từ JSON MongoDB
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['_id']['\$oid'],
      user: json['user'],
      email: json['email'],
      reminderTime: DateTime.parse(json['reminderTime']['\$date']),
      frequency: json['frequency'],
      status: json['status'],
      additionalInfo: Map<String, dynamic>.from(json['additionalInfo'] ?? {}),
    );
  }
}
