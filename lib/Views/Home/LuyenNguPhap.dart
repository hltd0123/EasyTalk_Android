import 'package:flutter/material.dart';
import 'package:dacn/Views/Home/BaiHocNguPhap.dart';

class HomeNP extends StatefulWidget {
  const HomeNP({super.key});

  @override
  _HomeNPState createState() => _HomeNPState();
}

class _HomeNPState extends State<HomeNP> {
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
      'title': 'Câu điều kiện',
      'info': 'Tìm hiểu về các câu điều kiện trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Mệnh đề quan hệ',
      'info': 'Khám phá các mệnh đề quan hệ trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Câu phức',
      'info': 'Học cách sử dụng câu phức trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các động từ bất quy tắc',
      'info': 'Tìm hiểu về các động từ bất quy tắc trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Danh từ và các loại danh từ',
      'info': 'Khám phá các loại danh từ trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Tính từ và trạng từ',
      'info': 'Tìm hiểu cách sử dụng tính từ và trạng từ trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Cấu trúc câu phức tạp',
      'info': 'Học cách xây dựng các câu phức tạp trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Giới từ trong tiếng Anh',
      'info': 'Tìm hiểu cách sử dụng giới từ trong câu.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Thì hiện tại hoàn thành',
      'info': 'Tìm hiểu về thì hiện tại hoàn thành trong tiếng Anh.',
    },
  ];

  final List<Map<String, String>> suggestedLessons = [
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các động từ khuyết thiếu',
      'info': 'Tìm hiểu các động từ khuyết thiếu trong tiếng Anh.',
    },
    {
      'image': 'assets/hutech3.jpg',
      'title': 'Các cấu trúc ngữ pháp phức tạp',
      'info': 'Khám phá các cấu trúc ngữ pháp phức tạp trong tiếng Anh.',
    },
    // Thêm bài học đề xuất khác nếu cần
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Bài học Ngữ pháp',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // In đậm tiêu đề
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: lessons.length + 1 + suggestedLessons.length, // Cộng thêm bài học đề xuất
        itemBuilder: (context, index) {
          if (index < lessons.length) {
            // Hiển thị bài học chính
            final lesson = lessons[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BHNP(
                      lesson: lesson,
                      allLessons: lessons, // Truyền toàn bộ danh sách bài học
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        lesson['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            lesson['info']!,
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
            // Hiển thị tiêu đề "Các bài học đề xuất"
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'Các bài học đề xuất',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            // Hiển thị các bài học đề xuất
            final suggestedLesson = suggestedLessons[index - lessons.length - 1];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BHNP(
                      lesson: suggestedLesson,
                      allLessons: suggestedLessons, // Truyền toàn bộ danh sách bài học đề xuất
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        suggestedLesson['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            suggestedLesson['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            suggestedLesson['info']!,
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
    );
  }
}
