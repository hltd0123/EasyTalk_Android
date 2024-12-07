import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dacn/Model/Achievements.dart';
import 'package:dacn/Model/User.dart';
import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Service/Local/UserStoreService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dacn/Views/NhacNho/Reminder.dart';
import 'package:dacn/Views/ThongTinTaiKhoang/AccountInfoPage.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  File? _image;

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Cập nhật ảnh được chọn
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  backgroundImage: _image != null
                      ? FileImage(_image!) as ImageProvider
                      : const AssetImage('assets/avatar.jpg'),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16.0),

              // Nút chỉnh sửa dưới CircleAvatar
              OutlinedButton(
                onPressed: _pickImage, // Gọi hàm chọn ảnh
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey), // Màu viền xám
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Bo tròn viền
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Chỉnh sửa',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.edit, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Các MenuItem không có menuOptions và mũi tên
              MenuItem(
                icon: const Icon(Icons.account_circle, color: Colors.white),
                text: 'Thông tin tài khoản',
                borderColor: Colors.blue,
                onTap: () async {
                  final data = await UserStoreService.getCurrentUserAndAchievements();
                  if(data != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountInfoPage(
                          user: GetDataFromMap.getUser(data)!,
                          achievements: GetDataFromMap.getAchievements(data)!,
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.notifications, color: Colors.white),
                text: 'Tạo lời nhắc',
                borderColor: Colors.blue,
                onTap: () {
                  // Chuyển sang trang Tạo lời nhắc
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReminderPage()),
                  );
                },
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.settings, color: Colors.white),
                text: 'Cài đặt',
                borderColor: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.help, color: Colors.white),
                text: 'Trợ giúp & Phản hồi',
                borderColor: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              MenuItem(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                text: 'Đăng xuất',
                borderColor: Colors.blue,
                onTap: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'Đăng xuất',
                    desc: 'Bạn có chắc chắn muốn đăng xuất',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Navigator.pushReplacementNamed(context, AppRouter.dangnhap);
                    },
                  ).show();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color borderColor;
  final VoidCallback? onTap;

  const MenuItem({
    required this.icon,
    required this.text,
    required this.borderColor,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gọi callback khi nhấn
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: icon,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(width: 16.0),
            Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
