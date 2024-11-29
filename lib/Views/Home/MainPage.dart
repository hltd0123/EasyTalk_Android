import 'package:dacn/Views/Home/AcountDetailPage.dart';
import 'package:dacn/Views/Home/BaiHocNguPhap.dart';
import 'package:dacn/Views/Home/BaiTapNguPhap.dart';
import 'package:dacn/Views/Home/FlashCard.dart';
import 'package:dacn/Views/Home/HanhTrinh.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/Home/LuyenNguPhap.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Enum cho các trang trong Bottom Navigation
enum MainPageBottomNavigation {
  home(icon: Icons.home, label: 'Trang chủ', selectedItem: 0),
  lessons(icon: Icons.edit_road, label: 'Hành trình', selectedItem: 1),
  account(icon: Icons.text_snippet, label: 'Bài viết', selectedItem: 2),
  settings(icon: Icons.settings_rounded, label: 'Cài đặt', selectedItem: 3);

  final IconData icon;
  final String label;
  final int selectedItem;

  const MainPageBottomNavigation({
    required this.icon,
    required this.label,
    required this.selectedItem,
  });
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainPageAppBar(),
      body: Consumer<MainPageProvider>(
        builder: (context, provider, child) {
          // Render trang con dựa trên selectedIndex của provider
          switch (provider.selectedIndex) {
            case 0:
              return const BaiTapNguPhap();
            case 1:
              return const HanhTrinh();
            case 3:
              return const AccountDetailPage();

            default:
              return HomePage();
          }
        },
      ),
      bottomNavigationBar: _buildMainPageBottomNavigation(
        initialIndex: context.watch<MainPageProvider>().selectedIndex,
        onTap: (index) {
          context.read<MainPageProvider>().updateIndex(index); // Cập nhật selectedIndex
        },
      ),
    );
  }

  // BottomNavigationBar cho MainPage
  Widget _buildMainPageBottomNavigation({
    required int initialIndex,
    required ValueChanged<int> onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFF64B5F6), // Xanh dương nhạt
            Color(0xFF42A5F5), // Xanh nước biển nhạt
            Color(0xFF1976D2), // Xanh nước biển vừa
            Color(0xFF0D47A1), // Xanh nước biển đậm
          ],
          stops: [0.0, 0.3, 0.7, 1.0], // Các điểm chuyển màu mềm mại
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent, // Để gradient có thể hiển thị
        items: MainPageBottomNavigation.values.map((item) {
          bool isSelected = item.selectedItem == initialIndex;
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                item.icon,
                color: isSelected ? Colors.amber : Colors.white,
                size: isSelected ? 30 : 25, // Thay đổi kích thước của icon khi được chọn
              ),
            ),
            label: item.label,
          );
        }).toList(),
        currentIndex: initialIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        onTap: onTap,
      ),
    );
  }

  // AppBar của MainPage
  AppBar _mainPageAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.shield, color: Colors.white),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nội dung cho tiêu đề nếu cần
        ],
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D47A1), // Xanh nước biển đậm
              Color(0xFF1976D2), // Xanh nước biển vừa
              Color(0xFF42A5F5), // Xanh nước biển nhạt
              Color(0xFF64B5F6), // Xanh dương nhạt
            ],
            stops: [0.0, 0.3, 0.7, 1.0], // Các điểm chuyển màu mềm mại
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_fire_department, color: Colors.orange),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.bolt, color: Colors.yellow),
          onPressed: () {},
        ),
      ],
    );
  }
}
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

];

