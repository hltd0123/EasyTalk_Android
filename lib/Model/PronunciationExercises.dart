import 'package:dacn/Model/PronunciationExercisesQuestion.dart';

class PronunciationExercises {
  String? id;
  String? title;
  List<PronunciationExercisesQuestion>? questions;

  PronunciationExercises({this.id, this.title, this.questions});

  factory PronunciationExercises.fromJson(Map<String, dynamic> json) {
    return PronunciationExercises(
      id: json['_id'],
      title: json['title'],
      questions: json['questions'] != null
          ? (json['questions'] as List)
          .map((q) => PronunciationExercisesQuestion.fromJson(q))
          .toList()
          : null,
    );
  }
}