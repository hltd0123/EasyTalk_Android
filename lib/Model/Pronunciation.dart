class Pronunciation {
  final String id;
  final String title;
  final String description;
  final String content;
  final String images;

  Pronunciation({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.images,
  });

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'content': content,
      'images': images,
    };
  }
}
