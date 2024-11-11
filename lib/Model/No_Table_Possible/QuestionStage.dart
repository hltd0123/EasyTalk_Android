class QuestionStage {
  String question;
  String type; // 'multiple-choice', 'fill-in-the-blank', 'translation'
  String correctAnswer;
  String explanation;
  List<String> options;

  QuestionStage({
    required this.question,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
    this.options = const [],
  });

  // Phương thức chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'type': type,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'options': type == 'multiple-choice' ? options : [],
    };
  }

  // Phương thức khởi tạo object từ JSON
  factory QuestionStage.fromJson(Map<String, dynamic> json) {
    return QuestionStage(
      question: json['question'],
      type: json['type'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      options: List<String>.from(json['options'] ?? []),
    );
  }
}
