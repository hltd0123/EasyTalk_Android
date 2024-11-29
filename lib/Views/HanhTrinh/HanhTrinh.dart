import 'package:flutter/material.dart';
import 'CuaVaChang.dart'; // Import màn hình mới

class HanhTrinh extends StatelessWidget {
  const HanhTrinh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hành Trình Học Tập',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Căn giữa tiêu đề AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Cửa và Chặng',
              style: TextStyle(
                fontSize: 24, // Kích thước chữ giống AppBar
                fontWeight: FontWeight.bold, // In đậm giống AppBar
                color: Colors.black, // Màu đen giống AppBar
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildSquareTile('Luyện tập sơ cấp', 60, context), // Ví dụ với 60% hoàn thành
                const SizedBox(height: 10),
                _buildSquareTile('Luyện tập trung cấp', 40, context), // Ví dụ với 40% hoàn thành
                const SizedBox(height: 10),
                _buildSquareTile('Luyện tập cao cấp', 80, context), // Ví dụ với 80% hoàn thành
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareTile(String title, double progress, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Khi nhấn vào một bài luyện tập, chuyển đến màn hình Cửa và Chặng
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CuaVaChang(title: title),
          ),
        );
      },
      child: Container(
        height: 140, // Giảm chiều cao khung vuông
        width: 120,  // Giảm chiều rộng khung vuông
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // Màu nền xám nhạt
          borderRadius: BorderRadius.circular(12), // Bo góc nhẹ
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Đổ bóng nhẹ
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Padding cho toàn bộ khung
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22, // Giảm kích thước font so với tiêu đề AppBar (24px -> 22px)
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  // Container bao quanh LinearProgressIndicator để điều chỉnh chiều rộng
                  Container(
                    width: 120, // Đặt chiều rộng thanh tiến trình bằng chiều rộng khung
                    child: LinearProgressIndicator(
                      value: progress / 100, // Tính tiến độ từ phần trăm
                      backgroundColor: Colors.grey.shade400,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Phần trăm hoàn thành
                  Text(
                    '${progress.toStringAsFixed(0)}% hoàn thành',
                    style: const TextStyle(
                      fontSize: 20, // Giảm kích thước font so với tiêu đề (24px -> 20px)
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
