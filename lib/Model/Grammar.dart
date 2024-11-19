class Grammar {
  String? id;
  String? title;
  String? description;
  String? content;
  String? image;

  Grammar({
    this.id,
    this.title,
    this.description,
    this.content,
    this.image,
  });

  // Phương thức khởi tạo từ JSON
  factory Grammar.fromJson(Map<String, dynamic> json) {
    return Grammar(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      content: json['content'] as String?,
      image: json['images'] as String?,
    );
  }

  // Phương thức chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'content': content,
      'images': image,
    };
  }
}
