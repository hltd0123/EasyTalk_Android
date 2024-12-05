class FlashCardList {
  String? id;  // id có thể null khi tạo mới
  String name;
  String description;
  String? createdAt;  // Thêm thuộc tính createdAt
  int wordCount;  // Thêm thuộc tính wordCount

  FlashCardList({
    this.id,
    required this.name,
    required this.description,
    this.createdAt,
    required this.wordCount,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      '_id': id,
      'createdAt': createdAt,
      'wordCount': wordCount,
    };
  }

  // Factory constructor để tạo đối tượng từ JSON
  factory FlashCardList.fromJson(Map<String, dynamic> json) {
    return FlashCardList(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      wordCount: json['wordCount'] ?? 0,
    );
  }
}
