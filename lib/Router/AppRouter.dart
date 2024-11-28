import 'package:dacn/Views/AiChat/ChatPage.dart';
import 'package:dacn/Views/Home/AcountDetailPage.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/Home/LuyenNguPhap.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:dacn/Views/PhatAm/MainPagePhatAm.dart';
import 'package:flutter/material.dart';

class AppRouter {
  //Định nghĩa các tham số để truy xuất dễ dàng
  static const String home = '/home';
  static const String main = '/main';
  static const String nguphap = '/nguphap';
  static const String phatam = '/phatam';
  static const String setting = '/setting';
  static const String aichat = '/aichat';

  //Điều hướng theo tham số
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case nguphap:
        return MaterialPageRoute(builder: (_) => HomeNP());
      case setting:
        return MaterialPageRoute(builder: (_) => AccountDetailPage());
      case phatam:
        return MaterialPageRoute(builder: (_) => MainPagePhatAm());
      case aichat:
        return MaterialPageRoute(builder: (_) => ChatPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Lỗi: Báo dev ngay đi')),
          ),
        );
    }
  }
}
