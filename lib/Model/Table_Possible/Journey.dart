class Journey {
  final String _id;
  final String _title;
  final List<String> _gates;
  final DateTime _createdAt;

  Journey({
    required String id,
    required String title,
    required List<String> gates,
    required DateTime createdAt,
  })  : _id = id,
        _title = title,
        _gates = gates,
        _createdAt = createdAt;

  String get id => _id;
  String get title => _title;
  List<String> get gates => _gates;
  DateTime get createdAt => _createdAt;

  factory Journey.fromMap(Map<String, dynamic> map) {
    return Journey(
      id: map['_id']['\$oid'],
      title: map['title'],
      gates: List<String>.from(map['gates'].map((x) => x['\$oid'])),
      createdAt: DateTime.parse(map['createdAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'title': _title,
      'gates': _gates.map((x) => {'\$oid': x}).toList(),
      'createdAt': {'\$date': _createdAt.toIso8601String()},
    };
  }

  String getTableName(){
    return 'journeys';
  }
}
