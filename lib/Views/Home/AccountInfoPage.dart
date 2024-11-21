import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  final String userName;
  final int lessonsRead;
  final int exercisesCompleted;
  final int doorsPassed;
  final int stagesCleared;
  final int totalPoints;

  const AccountInfoPage({
    required this.userName,
    required this.lessonsRead,
    required this.exercisesCompleted,
    required this.doorsPassed,
    required this.stagesCleared,
    required this.totalPoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn trái nội dung
          children: [
            // Tên tài khoản
            const Text(
              'Tên tài khoản',
              style: TextStyle(
                fontSize: 20.0, // Tăng kích thước chữ tiêu đề
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18.0, // Tăng kích thước chữ thông tin
              ),
            ),
            const Divider(height: 24.0),

            // Số bài học đã đọc
            const Text(
              'Số bài học đã đọc',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$lessonsRead',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Divider(height: 24.0),

            // Số bài tập đã làm
            const Text(
              'Số bài tập đã làm',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$exercisesCompleted',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Divider(height: 24.0),

            // Các cửa đã vượt qua
            const Text(
              'Các cửa đã vượt qua',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$doorsPassed',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Divider(height: 24.0),

            // Các chặng đã vượt qua
            const Text(
              'Các chặng đã vượt qua',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$stagesCleared',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Divider(height: 24.0),

            // Tổng số điểm xếp hạng
            const Text(
              'Tổng số điểm xếp hạng',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$totalPoints',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
