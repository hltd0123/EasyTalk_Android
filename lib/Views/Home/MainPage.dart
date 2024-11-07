import 'package:dacn/Views/Home/AcountDetailPage.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Điều chỉnh các Page xuất hiện dưới Bottom Nav ở MainPageBottomNavigation
//Thêm các tham số tương tự home sẽ tự render ra

//Điều chỉnh Page xuất hiện theo Bottom Nav ở MainPage ( dòng 41 -> )
//Thêm sửa case theo selectedItem index tương ứng

//Màu cũ: Color(0xFF1D1E33)

enum MainPageBottomNavigation {
  home(icon: Icons.home, label: 'Trang chủ', selectedItem: 0),

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
          // Render trang HomePage hoặc AccountDetailPage dựa trên trạng thái của provider
          switch (provider.selectedIndex) {
            case 0:
              return const HomePage();
            case 2:
              return const AccountDetailPage();
            default:
              return HomePage();
          }
        },
      ),
      bottomNavigationBar: _buildMainPageBottomNavigation(
        initialIndex: context.watch<MainPageProvider>().selectedIndex,
        onTap: (index) {
          context.read<MainPageProvider>().updateIndex(index); // Cập nhật giá trị index
        },
      ),
    );
  }

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
        backgroundColor: Colors.transparent, // Để gradient có thể hiển thị
        items: MainPageBottomNavigation.values.map((item) {
          bool isSelected = item.selectedItem == initialIndex;
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                item.icon,
                size: isSelected ? 30 : 25, // Thay đổi kích thước của icon khi được chọn
              ),
            ),
            label: item.label,
          );
        }).toList(),
        currentIndex: initialIndex,
        unselectedItemColor: Colors.white,
        onTap: onTap,
      ),
    );
  }

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
