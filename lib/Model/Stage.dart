class QuestionStage {
  String question;
  String type;
  List<String> options;
  String correctAnswer;
  String explanation;

  QuestionStage({
    required this.question,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory QuestionStage.fromJson(Map<String, dynamic> json) {
    return QuestionStage(
      question: json['question'],
      type: json['type'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
    );
  }
}

class Stage {
  String id;
  String title;
  String gate;
  List<QuestionStage> questions;

  Stage({
    required this.id,
    required this.title,
    required this.gate,
    required this.questions,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['_id'],
      title: json['title'],
      gate: json['gate'],
      questions: List<QuestionStage>.from(
        json['questions'].map((x) => QuestionStage.fromJson(x)),
      ),
    );
  }
}
