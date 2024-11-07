import 'package:flutter/material.dart';

class PreviewArticle extends StatelessWidget {
  final String id;
  final String title;
  final String content;

  const PreviewArticle({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    double heightContainer = MediaQuery.of(context).size.height * 0.5;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2), // Đổ bóng từ dưới
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: heightContainer * 0.25,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // SizedBox - 5% chiều cao của Container
          SizedBox(height: heightContainer * 0.05),

          // Content - 60% chiều cao của Container
          Container(
            height: heightContainer * 0.4, // 60% chiều cao của Container
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3, // Hiển thị tối đa 3 dòng
            ),
          ),

          Container(
            height: heightContainer * 0.15,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền của button
                foregroundColor: Colors.white, // Màu chữ của button
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Góc bo tròn
                ),
                elevation: 5, // Tạo hiệu ứng bóng cho button
              ),
              child: const Text(
                'Xem chi tiết',
                style: TextStyle(
                  fontSize: 16, // Kích thước chữ
                  fontWeight: FontWeight.bold, // Chữ đậm
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}