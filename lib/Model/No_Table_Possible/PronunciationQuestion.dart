class PronunciationQuestion {
  final String _question;
  final String _type;
  final String _correctAnswer;
  final List<String> _options;
  final String _explanation;
  final String? _audioUrl;

  PronunciationQuestion({
    required String question,
    required String type,
    required String correctAnswer,
    required List<String> options,
    required String explanation,
    String? audioUrl,
  })  : _question = question,
        _type = type,
        _correctAnswer = correctAnswer,
        _options = options,
        _explanation = explanation,
        _audioUrl = audioUrl;

  String get question => _question;
  String get type => _type;
  String get correctAnswer => _correctAnswer;
  List<String> get options => _options;
  String get explanation => _explanation;
  String? get audioUrl => _audioUrl;

  factory PronunciationQuestion.fromMap(Map<String, dynamic> map) {
    return PronunciationQuestion(
      question: map['question'],
      type: map['type'],
      correctAnswer: map['correctAnswer'],
      options: List<String>.from(map['options']),
      explanation: map['explanation'],
      audioUrl: map['audioUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': _question,
      'type': _type,
      'correctAnswer': _correctAnswer,
      'options': _options,
      'explanation': _explanation,
      'audioUrl': _audioUrl,
    };
  }
}
