class PronunciationExercisesQuestion {
  String? question;
  String? type;
  String? correctAnswer;
  String? explanation;
  List<String>? options;

  PronunciationExercisesQuestion({
    this.question,
    this.type,
    this.correctAnswer,
    this.explanation,
    this.options,
  });

  factory PronunciationExercisesQuestion.fromJson(Map<String, dynamic> json) {
    return PronunciationExercisesQuestion(
      question: json['question'],
      type: json['type'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
    );
  }
}