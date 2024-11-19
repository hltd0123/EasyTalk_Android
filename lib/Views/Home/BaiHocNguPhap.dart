import 'package:flutter/material.dart';

class BHNP extends StatelessWidget {
  final Map<String, String> lesson;
  final List<Map<String, String>> allLessons;

  const BHNP({
    super.key,
    required this.lesson,
    required this.allLessons,
  });

  @override
  Widget build(BuildContext context) {
    // Lọc ra danh sách các bài học liên quan, trừ bài học hiện tại
    final relatedLessons = allLessons.where((e) => e != lesson).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Không bóng
        backgroundColor: Colors.blue, // Màu nền
        automaticallyImplyLeading: true, // Hiển thị nút Back
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề dưới AppBar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                lesson['title']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ảnh bài học
                  Image.asset(
                    lesson['image']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  // Thông tin bài học
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      lesson['info']!,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  // Các bài học liên quan
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Các bài học liên quan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...relatedLessons.map((related) {
                    return ListTile(
                      leading: Image.asset(
                        related['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(related['title']!),
                      subtitle: Text(related['info']!),
                      onTap: () {
                        // Chuyển đến BHNP mới khi nhấn
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BHNP(
                              lesson: related, // Truyền bài học được chọn
                              allLessons: allLessons, // Truyền danh sách đầy đủ
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
