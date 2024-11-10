import 'PronunciationQuestion.dart';

class PronunciationExercise {
  final String _id;
  final String _title;
  final List<PronunciationQuestion> _questions;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  PronunciationExercise({
    required String id,
    required String title,
    required List<PronunciationQuestion> questions,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _id = id,
        _title = title,
        _questions = questions,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get id => _id;
  String get title => _title;
  List<PronunciationQuestion> get questions => _questions;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  factory PronunciationExercise.fromMap(Map<String, dynamic> map) {
    return PronunciationExercise(
      id: map['_id']['\$oid'],
      title: map['title'],
      questions: List<PronunciationQuestion>.from(
          map['questions'].map((x) => PronunciationQuestion.fromMap(x))),
      createdAt: DateTime.parse(map['createdAt']['\$date']),
      updatedAt: DateTime.parse(map['updatedAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'title': _title,
      'questions': _questions.map((x) => x.toMap()).toList(),
      'createdAt': {'\$date': _createdAt.toIso8601String()},
      'updatedAt': {'\$date': _updatedAt.toIso8601String()},
    };
  }
}
