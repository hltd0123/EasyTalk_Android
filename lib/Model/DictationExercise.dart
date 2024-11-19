class DictationExercise {
  String? id;
  String? title;
  String? content;

  DictationExercise({this.id, this.title, this.content});

  // Phương thức từ JSON
  factory DictationExercise.fromJson(Map<String, dynamic> json) {
    return DictationExercise(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
    );
  }

  // Phương thức chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
    };
  }
}
