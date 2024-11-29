import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

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
                    // Chèn hình ảnh vào đây
                    Center(
                      child: Image.asset(
                        'assets/eztalk2.jpg',  // Đảm bảo bạn có ảnh logo trong thư mục 'assets'
                        height: 100,  // Điều chỉnh chiều cao của ảnh nếu cần
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tiêu đề "Đăng Nhập"
                    Center(
                      child: const Text(
                        'Đăng Nhập',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                      obscureText: true,
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
                    // Checkbox "Ghi nhớ đăng nhập"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text('Ghi nhớ đăng nhập'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Nút "Quên mật khẩu" căn trái
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // Xử lý hành động quên mật khẩu ở đây
                          print('Quên mật khẩu');
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue, // Màu giống nút đăng ký
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Nút Đăng nhập căn giữa
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Kiểm tra nếu form hợp lệ
                          if (_formKey.currentState?.validate() ?? false) {
                            // Xử lý đăng nhập ở đây
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            // In thông tin đăng nhập để kiểm tra
                            print('Email: $email');
                            print('Mật khẩu: $password');
                          }
                        },
                        child: const Text('Đăng Nhập'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Nút Đăng ký căn giữa
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Xử lý chuyển đến màn hình đăng ký ở đây
                          print('Chuyển đến màn hình đăng ký');
                        },
                        child: const Text(
                          'Chưa có tài khoản? Đăng ký ngay',
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
