class Pronunciation {
  String id;
  String description;
  String content;
  DateTime createdAt;
  List<String> images;

  Pronunciation({
    required this.id,
    required this.description,
    required this.content,
    DateTime? createdAt,
    this.images = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  // Phương thức chuyển object thành JSON theo định dạng MongoDB
  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id}, // Dùng định dạng JSON MongoDB cho ObjectId
      'description': description,
      'content': content,
      'createdAt': {'\$date': createdAt.toIso8601String()}, // Dùng định dạng ISO cho Date
      'images': images,
    };
  }

  // Phương thức khởi tạo object từ JSON MongoDB
  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      id: json['_id']['\$oid'],
      description: json['description'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']['\$date']),
      images: List<String>.from(json['images'] ?? []),
    );
  }

  String getTableName(){
    return 'pronunciations';
  }
}
