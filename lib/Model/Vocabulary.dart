import 'package:dacn/Model/VocabularyQuestion.dart';

class Vocabulary {
  String id;
  String title;
  List<VocabularyQuestion> questions;
  String? updatedAt;

  Vocabulary({
    required this.id,
    required this.title,
    required this.questions,
    this.updatedAt,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      id: json['_id'],
      title: json['title'],
      questions: (json['questions'] as List)
          .map((questionJson) => VocabularyQuestion.fromJson(questionJson))
          .toList(),
      updatedAt: json['updatedAt'],
    );
  }
}