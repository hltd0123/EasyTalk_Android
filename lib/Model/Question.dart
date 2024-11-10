class Question {
  final String _id;
  final String _questionText;
  final List<String> _options;
  final String _correctAnswer;
  final String _explanation;
  final DateTime _createdAt;

  Question({
    required String id,
    required String questionText,
    required List<String> options,
    required String correctAnswer,
    required String explanation,
    required DateTime createdAt,
  })  : _id = id,
        _questionText = questionText,
        _options = options,
        _correctAnswer = correctAnswer,
        _explanation = explanation,
        _createdAt = createdAt;

  String get id => _id;
  String get questionText => _questionText;
  List<String> get options => _options;
  String get correctAnswer => _correctAnswer;
  String get explanation => _explanation;
  DateTime get createdAt => _createdAt;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['_id']['\$oid'],
      questionText: map['questionText'],
      options: List<String>.from(map['options']),
      correctAnswer: map['correctAnswer'],
      explanation: map['explanation'],
      createdAt: DateTime.parse(map['createdAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'questionText': _questionText,
      'options': _options,
      'correctAnswer': _correctAnswer,
      'explanation': _explanation,
      'createdAt': {'\$date': _createdAt.toIso8601String()},
    };
  }
}
