import 'package:flutter/material.dart';

class HomeNP extends StatefulWidget {
  const HomeNP({super.key});

  @override
  _HomeNPState createState() => _HomeNPState();
}

class _HomeNPState extends State<HomeNP> {
  // Danh sách các bài học, mỗi bài học gồm ảnh, tiêu đề và thông tin
  final List<Map<String, String>> lessons = [
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Cấu trúc câu đơn giản',
      'info': 'Học cách xây dựng câu đơn giản trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các thì trong tiếng Anh',
      'info': 'Tìm hiểu về các thì cơ bản trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Từ vựng hàng ngày',
      'info': 'Mở rộng vốn từ vựng tiếng Anh qua các tình huống giao tiếp.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Câu hỏi và câu trả lời',
      'info': 'Học cách tạo câu hỏi và câu trả lời trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các động từ bất quy tắc',
      'info': 'Tìm hiểu về các động từ bất quy tắc và cách sử dụng chúng.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Mệnh đề quan hệ',
      'info': 'Hiểu về mệnh đề quan hệ và cách sử dụng trong câu.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các loại câu điều kiện',
      'info': 'Khám phá các loại câu điều kiện trong tiếng Anh.',
    },
  ];

  // Danh sách các bài viết đề xuất
  final List<Map<String, String>> suggestedArticles = [
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Ngữ pháp nâng cao',
      'info': 'Tìm hiểu về các cấu trúc ngữ pháp nâng cao trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Phát âm chuẩn',
      'info': 'Các bài học giúp cải thiện kỹ năng phát âm tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Luyện nghe tiếng Anh',
      'info': 'Bài học luyện nghe các đoạn hội thoại tiếng Anh.',
    },
    // Thêm bài viết khác nếu cần
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Tắt hiệu ứng bóng của AppBar
        backgroundColor: Colors.transparent, // Tắt màu nền của AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề bài học ngữ pháp, căn giữa
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bài học Ngữ pháp',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center, // Căn giữa tiêu đề
              ),
            ),
          ),
          // Danh sách bài học
          Expanded(
            child: ListView.builder(
              itemCount: lessons.length + 1 + suggestedArticles.length, // Thêm 1 cho tiêu đề "Bài viết đề xuất"
              itemBuilder: (context, index) {
                if (index < lessons.length) {
                  final item = lessons[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Row(
                        children: [
                          // Ảnh đại diện của bài học
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              item['image']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Nội dung bài học: Tiêu đề và thông tin
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['info']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (index == lessons.length) {
                  // Hiển thị tiêu đề bài viết đề xuất
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Bài viết đề xuất',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  final item = suggestedArticles[index - lessons.length - 1];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Row(
                        children: [
                          // Ảnh đại diện của bài viết đề xuất
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              item['image']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Nội dung bài viết đề xuất
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 16, // Font nhỏ hơn cho bài viết đề xuất
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['info']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
