class Gate {
  final String _id;
  final String _name;
  final List<String> _questions;
  final DateTime _createdAt;

  Gate({
    required String id,
    required String name,
    required List<String> questions,
    required DateTime createdAt,
  })  : _id = id,
        _name = name,
        _questions = questions,
        _createdAt = createdAt;

  String get id => _id;
  String get name => _name;
  List<String> get questions => _questions;
  DateTime get createdAt => _createdAt;

  factory Gate.fromMap(Map<String, dynamic> map) {
    return Gate(
      id: map['_id']['\$oid'],
      name: map['name'],
      questions: List<String>.from(map['questions']),
      createdAt: DateTime.parse(map['createdAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'name': _name,
      'questions': _questions,
      'createdAt': {'\$date': _createdAt.toIso8601String()},
    };
  }
}
