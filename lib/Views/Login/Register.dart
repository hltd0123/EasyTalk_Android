import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Service/APICall/UserService.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2), // Viền đen
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thêm ảnh ở trên tiêu đề
                    Center(
                      child: Image.asset(
                        'assets/eztalk2.jpg', // Đường dẫn đến ảnh trong thư mục assets
                        height: 150, // Chiều cao ảnh
                        width: 150,  // Chiều rộng ảnh
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Tiêu đề "Đăng Ký"
                    Center(
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Trường nhập "Tên người dùng"
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Tên người dùng',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên người dùng';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Trường nhập "Gmail"
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Gmail',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Gmail';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Vui lòng nhập email hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Trường nhập "Mật khẩu"
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Ẩn mật khẩu
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Trường nhập "Xác nhận mật khẩu"
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true, // Ẩn mật khẩu
                      decoration: const InputDecoration(
                        labelText: 'Xác nhận mật khẩu',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng xác nhận mật khẩu';
                        }
                        if (value != _passwordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Nút Đăng ký căn giữa
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Kiểm tra nếu form hợp lệ
                          if (_formKey.currentState?.validate() ?? false) {
                            // Xử lý đăng ký ở đây
                            String username = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            if(await UserService.register(username, email, password, password)){
                              Navigator.pushReplacementNamed(context, AppRouter.dangnhap);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đăng ký thành công, vui lòng đăng nhập lại!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Đăng Ký'),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nút chuyển đến màn hình đăng nhập
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Chuyển đến màn hình đăng nhập
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Đã có tài khoản? Đăng nhập ngay',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue, // Màu giống nút quên mật khẩu
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
