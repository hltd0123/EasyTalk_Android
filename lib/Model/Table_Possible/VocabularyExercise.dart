import 'package:dacn/Model/No_Table_Possible/VocabularyQuestion.dart';

class VocabularyExercise {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<VocabularyQuestion> questions;

  VocabularyExercise({
    required this.id,
    required this.title,
    DateTime? createdAt,
    this.questions = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  void addQuestion({
    required String question,
    required String type,
    required String correctAnswer,
    required String explanation,
    List<String> options = const [],
  }) {
    final newQuestion = VocabularyQuestion(
      question: question,
      type: type,
      correctAnswer: correctAnswer,
      explanation: explanation,
      options: type == 'multiple-choice' ? options : [],
    );
    questions.add(newQuestion);
  }

  factory VocabularyExercise.fromMap(Map<String, dynamic> map) {
    return VocabularyExercise(
      id: map['_id'],
      title: map['title'],
      createdAt: DateTime.parse(map['createdAt']),
      questions: List<VocabularyQuestion>.from(
        map['questions'].map((x) => VocabularyQuestion.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }
}