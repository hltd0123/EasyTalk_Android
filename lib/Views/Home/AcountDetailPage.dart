import 'package:flutter/material.dart';
import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});
  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}
class _AccountDetailPage extends State<AccountDetailPage> {
  // Biến lưu trữ chế độ hiện tại (sáng hoặc tối)
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData.light(), // Định nghĩa theme sáng
      darkTheme: ThemeData.dark(), // Định nghĩa theme tối
      themeMode: _themeMode, // Áp dụng theme hiện tại
      home: const AccountDetailPage(),
    );
  }
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            children: [
              // CircleAvatar
              Center(
                child: CircleAvatar(
                  radius: 80, // Kích thước avatar
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16.0),

              // Nút chỉnh sửa dưới CircleAvatar
              OutlinedButton(
                onPressed: () {
                  // Thêm hành động chỉnh sửa avatar ở đây
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey), // Màu viền xám
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Bo tròn viền
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Chỉnh sửa',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.edit, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Các MenuItem không có menuOptions và mũi tên
              MenuItem(
                icon: const Icon(Icons.account_circle, color: Colors.white),
                text: 'Thông tin tài khoản',
                colorArrow: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.notifications, color: Colors.white),
                text: 'Thông báo',
                colorArrow: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.settings, color: Colors.white),
                text: 'Cài đặt',
                colorArrow: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.help, color: Colors.white),
                text: 'Trợ giúp & Phản hồi',
                colorArrow: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
