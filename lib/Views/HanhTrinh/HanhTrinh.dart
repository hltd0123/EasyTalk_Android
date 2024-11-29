import 'package:flutter/material.dart';
import 'CuaVaChang.dart'; // Import màn hình mới
import 'BangXepHang.dart'; // Import màn hình Bảng Xếp Hạng

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
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black), // Icon ba gạch ngang
            onSelected: (value) {
              if (value == 'BangXepHang') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BangXepHang()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'BangXepHang',
                child: Text('Bảng Xếp Hạng'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Cửa và Chặng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildSquareTile('Luyện tập sơ cấp', 60, context),
                const SizedBox(height: 10),
                _buildSquareTile('Luyện tập trung cấp', 40, context),
                const SizedBox(height: 10),
                _buildSquareTile('Luyện tập cao cấp', 80, context),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CuaVaChang(title: title),
          ),
        );
      },
      child: Container(
        height: 140,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 120,
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: Colors.grey.shade400,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${progress.toStringAsFixed(0)}% hoàn thành',
                    style: const TextStyle(
                      fontSize: 20,
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
