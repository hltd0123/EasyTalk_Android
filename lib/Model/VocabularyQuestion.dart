class VocabularyQuestion {
  String question;
  String type;
  String correctAnswer;
  String explanation;
  List<String> options;

  VocabularyQuestion({
    required this.question,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
    required this.options,
  });

  factory VocabularyQuestion.fromJson(Map<String, dynamic> json) {
    return VocabularyQuestion(
      question: json['question'],
      type: json['type'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      options: List<String>.from(json['options']),
    );
  }
}