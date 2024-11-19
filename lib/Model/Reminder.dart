class Reminder {
  String id;
  String userId;
  String email;
  DateTime reminderTime;
  String frequency;
  String additionalInfo;
  String status;

  Reminder({
    required this.id,
    required this.userId,
    required this.email,
    required this.reminderTime,
    required this.frequency,
    required this.additionalInfo,
    required this.status,
  });

  // Convert JSON to Reminder object
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['_id'],
      userId: json['user'],
      email: json['email'],
      reminderTime: DateTime.parse(json['reminderTime']),
      frequency: json['frequency'],
      additionalInfo: json['additionalInfo'],
      status: json['status'],
    );
  }

  // Convert Reminder object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'email': email,
      'reminderTime': reminderTime.toIso8601String(),
      'frequency': frequency,
      'additionalInfo': additionalInfo,
      'status': status,
    };
  }
}