class FlashCard {
  String? id;
  String word;
  String meaning;
  String pos;
  String pronunciation;
  String exampleSentence;
  String image;

  FlashCard({
    this.id,
    required this.word,
    required this.meaning,
    required this.pos,
    required this.pronunciation,
    required this.exampleSentence,
    required this.image,
  });

  // Hàm để chuyển đối tượng FlashCard thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id' : id,
      'word': word,
      'meaning': meaning,
      'pos': pos,
      'pronunciation': pronunciation,
      'exampleSentence': exampleSentence,
      'image': image,
    };
  }

  // Hàm khởi tạo từ JSON (sử dụng để nhận phản hồi từ server nếu cần)
  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      id: json['_id'],
      word: json['word'],
      meaning: json['meaning'],
      pos: json['pos'],
      pronunciation: json['pronunciation'],
      exampleSentence: json['exampleSentence'],
      image: json['image'],
    );
  }
}
