import 'package:flutter/material.dart';

class CuaVaChang extends StatelessWidget {
  final String title;

  const CuaVaChang({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cửa và Chặng',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Cửa 1 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Cửa 1'),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(),
            const SizedBox(height: 20),
            // Chặng 1 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Chặng 1', 120),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(),
            const SizedBox(height: 20),
            // Chặng 2 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Chặng 2', 120),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(),
            const SizedBox(height: 20),
            // Cửa 2 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Cửa 2'),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(),
            const SizedBox(height: 20),
            // Chặng 1 của Cửa 2 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Chặng 1 của Cửa 2', 120),
            ),
            const SizedBox(height: 20),
            _buildArrowDown(),
            const SizedBox(height: 20),
            // Chặng 2 của Cửa 2 là một nút
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaiTapScreen(),
                  ),
                );
              },
              child: _buildCuaTile('Chặng 2 của Cửa 2', 120),
            ),
            const SizedBox(height: 500), // Giả lập thêm nhiều nội dung để cuộn
          ],
        ),
      ),
    );
  }

  // Hàm tạo khung "Cửa" hoặc "Chặng"
  Widget _buildCuaTile(String title, [double size = 180]) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      height: size,  // Dùng tham số size để điều chỉnh chiều cao
      width: size,   // Dùng tham số size để điều chỉnh chiều rộng
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Màu nền xám nhạt
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
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24, // Kích thước chữ giữ nguyên
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // Hàm tạo mũi tên chỉ xuống
  Widget _buildArrowDown() {
    return Icon(
      Icons.arrow_downward, // Mũi tên chỉ xuống
      size: 40,
      color: Colors.black,
    );
  }
}

class BaiTapScreen extends StatefulWidget {
  @override
  _BaiTapScreenState createState() => _BaiTapScreenState();
}

class _BaiTapScreenState extends State<BaiTapScreen> {
  int currentQuestionIndex = 0; // Biến lưu trữ câu hỏi hiện tại

  // Danh sách câu hỏi và các lựa chọn
  final List<Map<String, Object>> questions = [
    {
      'question': 'Câu hỏi 1: Flutter là gì?',
      'options': ['Framework', 'Library', 'SDK', 'Language', 'IDE'],
    },
    {
      'question': 'Câu hỏi 2: Dart được dùng để làm gì?',
      'options': ['Backend', 'Frontend', 'Language', 'Database', 'None'],
    },
    {
      'question': 'Câu hỏi 3: State trong Flutter là gì?',
      'options': ['Dữ liệu của widget', 'Widget', 'Route', 'Dependency', 'UI'],
    },
    // Thêm các câu hỏi khác nếu cần
  ];

  void goToQuestion(int index) {
    setState(() {
      currentQuestionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài Tập'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: (currentQuestion['options'] as List<String>)
                  .asMap()
                  .entries
                  .map((entry) {
                int idx = entry.key;
                String option = entry.value;
                return ElevatedButton(
                  onPressed: () {},
                  child: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.circle,
                    color: index == currentQuestionIndex
                        ? Colors.blue
                        : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () => goToQuestion(index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
