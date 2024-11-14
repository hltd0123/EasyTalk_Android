import 'package:dacn/Model/GrammarExerciseQuestion.dart';

class GrammarExercise {
  String id;
  String title;
  List<GrammarExerciseQuestion> questions;

  GrammarExercise({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory GrammarExercise.fromJson(Map<String, dynamic> json) {
    return GrammarExercise(
      id: json['_id'],
      title: json['title'],
      questions: (json['questions'] as List)
          .map((q) => GrammarExerciseQuestion.fromJson(q))
          .toList(),
    );
  }
}
