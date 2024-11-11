class VocabularyQuestion {
  final String question;
  final String type; // 'multiple-choice', 'fill-in-the-blank', 'translation'
  final String correctAnswer;
  final String explanation;
  final List<String> options;

  VocabularyQuestion({
    required this.question,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
    this.options = const [],
  });

  factory VocabularyQuestion.fromMap(Map<String, dynamic> map) {
    return VocabularyQuestion(
      question: map['question'],
      type: map['type'],
      correctAnswer: map['correctAnswer'],
      explanation: map['explanation'],
      options: List<String>.from(map['options'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'type': type,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'options': options,
    };
  }
}