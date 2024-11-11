class FlashCardList {
  final String _id;
  final String _name;
  final List<String> _listFlashCardId;
  final DateTime _createdAt;

  FlashCardList({
    required String id,
    required String name,
    required List<String> flashcards,
    required DateTime createdAt,
  })  : _id = id,
        _name = name,
        _listFlashCardId = flashcards,
        _createdAt = createdAt;

  String get id => _id;
  String get name => _name;
  List<String> get flashcards => _listFlashCardId;
  DateTime get createdAt => _createdAt;

  factory FlashCardList.fromMap(Map<String, dynamic> map) {
    return FlashCardList(
      id: map['_id']['\$oid'],
      name: map['name'],
      flashcards: List<String>.from(map['flashcards']),
      createdAt: DateTime.parse(map['createdAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'name': _name,
      'flashcards': _listFlashCardId,
      'createdAt': {'\$date': _createdAt.toIso8601String()},
    };
  }

  String getTableName(){
    return 'flashcardlists';
  }
}
