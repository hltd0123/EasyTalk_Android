import 'package:dacn/Model/Achievements.dart';
import 'package:dacn/Model/User.dart';
import 'package:dacn/Service/APICall/UserService.dart';
import 'package:dacn/Service/Local/UserStoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends StatefulWidget {
  final User user;
  final Achievements achievements;

  const AccountInfoPage({super.key, required this.user, required this.achievements});

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  // Controllers để nhận giá trị từ các TextField trong dialog
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirm = _confirmPasswordController.text;
    if(await UserStoreService.changePassword(currentPassword, newPassword, confirm))
    {
      setState(() {
        widget.user.password = newPassword;
      });

      // Đóng dialog và hiển thị thông báo thành công
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật mật khẩu thành công')),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thất bại, lỗi không thể cập nhật')),
      );
    }
  }

  // Hàm hiển thị dialog đổi mật khẩu
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ô nhập mật khẩu hiện tại
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu hiện tại',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Ô nhập mật khẩu mới
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu mới',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Ô xác nhận mật khẩu mới
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nhập lại mật khẫu mới',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Đổi mật khẩu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: widget.user.email);
    final usernameController = TextEditingController(text: widget.user.username);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back)),
        title: Text('Thông tin', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        backgroundColor: Colors.blue, // Màu chủ đạo là xanh dương
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    // Username
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        label: Text('User Name'),
                        prefixIcon: Icon(Icons.person_3),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      controller: emailController, // Sử dụng controller để lấy giá trị
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Nút Cập nhật thông tin
                    ElevatedButton(
                      onPressed: () async {
                        String updatedUsername = usernameController.text;
                        String updatedEmail = emailController.text;
                        if(await UserStoreService.updateProfile(updatedUsername, updatedEmail)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cập nhật thành công')),
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Thất bại')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Cập nhật thông tin', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _showChangePasswordDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Màu xanh dương cho nút
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Đổi mật khẩu', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
