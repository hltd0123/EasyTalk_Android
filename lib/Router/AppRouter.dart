import 'package:dacn/Model/FlashCard.dart';
import 'package:dacn/Views/AiChat/ChatPage.dart';
import 'package:dacn/Views/NguPhap/BaiTapNguPhap.dart';
import 'package:dacn/Views/ThongTinTaiKhoang/AcountDetailPage.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/NguPhap/LuyenNguPhap.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:dacn/Views/PhatAm/MainPagePhatAm.dart';
import 'package:dacn/Views/TuVung/FlashCard.dart';
import 'package:dacn/Views/TuVung/FlashCardStudying.dart';
import 'package:dacn/Views/WidgetBuiding/customPageRoute.dart';
import 'package:flutter/material.dart';

class AppRouter {
  //Định nghĩa các tham số để truy xuất dễ dàng
  static const String home = '/home';
  static const String main = '/main';
  static const String nguphap = '/nguphap';
  static const String phatam = '/phatam';
  static const String setting = '/setting';
  static const String aichat = '/aichat';
  static const String luyentapnguphap = '/luyentapnguphap';
  static const String flashcard = '/flashcard';
  static const String flashcardstudying = '/flashcardstudying';

  //Điều hướng theo tham số
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return customPageRoute(MainPage());
      case home:
        return customPageRoute(HomePage());
      case nguphap:
        return customPageRoute(HomeNP());
      case setting:
        return customPageRoute(AccountDetailPage());
      case phatam:
        final int initPage = settings.arguments is int ? settings.arguments as int : 0;
        return customPageRoute(MainPagePhatAm(initPage: initPage,));
      case aichat:
        return customPageRoute(ChatPage());
      case luyentapnguphap:
        return customPageRoute(BaiTapNguPhap());
      case flashcard:
        return customPageRoute(FlashCardPage());
      case flashcardstudying:
        List<FlashCard> checkData = settings.arguments is List<FlashCard>
          ? settings.arguments as List<FlashCard>
          : [];
        for(var d in checkData){
          print('\n${d.id}');
        }
        return customPageRoute(FlashCardStudying(flashCards: checkData));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Lỗi: Báo dev ngay đi')),
          ),
        );
    }
  }
}
