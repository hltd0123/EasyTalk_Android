class GrammarExerciseQuestion {
  String question;
  String type;
  String correctAnswer;
  String explanation;
  List<String> options;

  GrammarExerciseQuestion({
    required this.question,
    required this.type,
    required this.correctAnswer,
    required this.explanation,
    required this.options,
  });

  factory GrammarExerciseQuestion.fromJson(Map<String, dynamic> json) {
    return GrammarExerciseQuestion(
      question: json['question'],
      type: json['type'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      options: List<String>.from(json['options']),
    );
  }
}
