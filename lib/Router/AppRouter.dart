import 'package:dacn/Views/Home/AcountDetailPage.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:flutter/material.dart';

class AppRouter {
  //Định nghĩa các tham số để truy xuất dễ dàng
  static const String home = '/home';
  static const String main = '/main';
  static const String lessons = '/lessons';
  static const String account = '/account';

  //Điều hướng theo tham số
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case account:
        return MaterialPageRoute(builder: (_) => AccountDetailPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Lỗi: Báo dev ngay đi')),
          ),
        );
    }
  }
}
