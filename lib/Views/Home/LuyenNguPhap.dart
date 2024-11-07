import 'package:dacn/Views/WidgetBuiding/ContainerMenuItem.dart';
import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';
import 'package:dacn/Views/WidgetBuiding/PreviewArticle.dart';
import 'package:dacn/Views/WidgetBuiding/PreviewArticleContainer.dart';
import 'package:flutter/material.dart';

class HomeNP extends StatefulWidget {
  const HomeNP({super.key});

  @override
  _HomeNPState createState() => _HomeNPState();
}

class _HomeNPState extends State<HomeNP> {
  Future<void> _refreshData() async {
    // Thêm hành động tải dữ liệu mới ở đây
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF81C784), // Xanh lá cây nhạt
                          Color(0xFF64B5F6), // Xanh dương nhạt
                          Color(0xFF4CAF50), // Xanh lá cây đậm
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Trở về trang trước
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: PopupMenuButton<int>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                // Xử lý các hành động cho từng tùy chọn
              },
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Cài đặt'),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Thông tin'),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Đăng xuất'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}