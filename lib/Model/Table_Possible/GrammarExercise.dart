import 'package:dacn/Model/No_Table_Possible/QuestionExercise.dart';

class GrammarExercise {
  String id;
  String title;
  DateTime createdAt;
  List<QuestionExercise> questions = [];

  GrammarExercise({
    required this.id,
    required this.title,
    DateTime? createdAt,
    this.questions = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  // Phương thức chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  // Phương thức khởi tạo object từ JSON
  factory GrammarExercise.fromJson(Map<String, dynamic> json) {
    return GrammarExercise(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionExercise.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  String getTableName(){
    return 'grammarexercises';
  }
}