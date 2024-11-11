import 'package:dacn/Model/No_Table_Possible/QuestionStage.dart';

class Stage {
  String id;
  String title;
  String gate;
  DateTime createdAt;
  List<QuestionStage> questions;

  Stage({
    required this.id,
    required this.title,
    required this.gate,
    DateTime? createdAt,
    this.questions = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  // Phương thức thêm câu hỏi vào danh sách
  void addQuestion({
    required String question,
    required String type,
    required String correctAnswer,
    required String explanation,
    List<String> options = const [],
  }) {
    final newQuestion = QuestionStage(
      question: question,
      type: type,
      correctAnswer: correctAnswer,
      explanation: explanation,
      options: type == 'multiple-choice' ? options : [],
    );
    questions.add(newQuestion);
  }

  // Phương thức chuyển object thành JSON theo định dạng MongoDB
  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id},
      'title': title,
      'gate': gate,
      'createdAt': {'\$date': createdAt.toIso8601String()},
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  // Phương thức khởi tạo object từ JSON
  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['_id']['\$oid'],
      title: json['title'],
      gate: json['gate'],
      createdAt: DateTime.parse(json['createdAt']['\$date']),
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionStage.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  String getTableName(){
    return 'stages';
  }
}
