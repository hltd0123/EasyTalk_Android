import 'package:flutter/material.dart';

class AccountInfoPage extends StatefulWidget {
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
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Lưu thông tin mới
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thông tin đã được lưu!')),
                  );
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên tài khoản
            const Text(
              'Tên tài khoản',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            _isEditing
                ? TextFormField(
              controller: _nameController,
              style: const TextStyle(fontSize: 18.0),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập tên tài khoản',
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _nameController.text,
                style: const TextStyle(fontSize: 18.0),
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
              '${widget.lessonsRead}',
              style: const TextStyle(fontSize: 18.0),
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
              '${widget.exercisesCompleted}',
              style: const TextStyle(fontSize: 18.0),
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
              '${widget.doorsPassed}',
              style: const TextStyle(fontSize: 18.0),
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
              '${widget.stagesCleared}',
              style: const TextStyle(fontSize: 18.0),
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
              '${widget.totalPoints}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
