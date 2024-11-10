class FlashCard {
  final String _id;
  final String _word;
  final String _meaning;
  final String _pos;
  final String _pronunciation;
  final String _exampleSentence;
  final String? _image;
  final String? _audio;
  final List<String> _flashcardList;
  final DateTime _createdAt;

  FlashCard({
    required String id,
    required String word,
    required String meaning,
    required String pos,
    required String pronunciation,
    required String exampleSentence,
    String? image,
    String? audio,
    required List<String> flashcardList,
    required DateTime createdAt,
  })  : _id = id,
        _word = word,
        _meaning = meaning,
        _pos = pos,
        _pronunciation = pronunciation,
        _exampleSentence = exampleSentence,
        _image = image,
        _audio = audio,
        _flashcardList = flashcardList,
        _createdAt = createdAt;

  String get id => _id;
  String get word => _word;
  String get meaning => _meaning;
  String get pos => _pos;
  String get pronunciation => _pronunciation;
  String get exampleSentence => _exampleSentence;
  String? get image => _image;
  String? get audio => _audio;
  List<String> get flashcardList => _flashcardList;
  DateTime get createdAt => _createdAt;

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      id: map['_id']['\$oid'],
      word: map['word'],
      meaning: map['meaning'],
      pos: map['pos'],
      pronunciation: map['pronunciation'],
      exampleSentence: map['exampleSentence'],
      image: map['image'],
      audio: map['audio'],
      flashcardList: List<String>.from(map['flashcardList']),
      createdAt: DateTime.parse(map['createdAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'word': _word,
      'meaning': _meaning,
      'pos': _pos,
      'pronunciation': _pronunciation,
      'exampleSentence': _exampleSentence,
      'image': _image,
      'audio': _audio,
      'flashcardList': _flashcardList,
      'createdAt': {'\$date': _createdAt.toIso8601String()},
    };
  }
}
