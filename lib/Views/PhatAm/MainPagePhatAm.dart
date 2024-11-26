import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:dacn/Views/PhatAm/ExerciseListPagePhatAm.dart';
import 'package:dacn/Views/PhatAm/StudyPagePhatAm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MainPagePhatAmBottomNavigation {
  study(icon: Icons.book, label: 'Bài học', selectedItem: 0),
  lessons(icon: Icons.edit, label: 'Luyện tập', selectedItem: 1);

  final IconData icon;
  final String label;
  final int selectedItem;

  const MainPagePhatAmBottomNavigation({
    required this.icon,
    required this.label,
    required this.selectedItem,
  });
}

class MainPagePhatAm extends StatelessWidget {
  const MainPagePhatAm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainPageAppBar(),
      body: Consumer<MainPageProvider>(
        builder: (context, provider, child) {
          print(provider.selectedIndex);
          // Render trang HomePage hoặc AccountDetailPage dựa trên trạng thái của provider
          switch (provider.selectedIndex) {
            case 0: return const StudyPagePhatAm();
            case 1: return const ExerciseListPagePhatAm();
            default: return const StudyPagePhatAm();
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
            Color(0xFF0D47A1), // Xanh nước biển đậm
            Color(0xFF1976D2), // Xanh nước biển vừa
            Color(0xFF42A5F5), // Xanh nước biển nhạt
            Color(0xFF64B5F6), // Xanh dương nhạt
          ],
          stops: [0.0, 0.3, 0.7, 1.0], // Các điểm chuyển màu mềm mại
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Để gradient có thể hiển thị
        items: MainPagePhatAmBottomNavigation.values.map((item) {
          bool isSelected = item.selectedItem == initialIndex;
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                item.icon,
                color: isSelected ? Colors.red : Colors.white,
                size: isSelected ? 30 : 25, // Thay đổi kích thước của icon khi được chọn
              ),
            ),
            label: item.label,
          );
        }).toList(),
        currentIndex: initialIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: onTap,
      ),
    );
  }

  AppBar _mainPageAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
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