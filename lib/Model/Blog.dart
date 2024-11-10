class Blog {
  final String _id;
  final String _title;
  final String _content;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  Blog({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _id = id,
        _title = title,
        _content = content,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  String get id => _id;
  String get title => _title;
  String get content => _content;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['_id']['\$oid'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']['\$date']),
      updatedAt: DateTime.parse(map['updatedAt']['\$date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': _id},
      'title': _title,
      'content': _content,
      'createdAt': {'\$date': _createdAt.toIso8601String()},
      'updatedAt': {'\$date': _updatedAt.toIso8601String()},
    };
  }
}
