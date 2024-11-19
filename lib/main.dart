import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Views/Home/AcountDetailPage.dart';
import 'package:dacn/Views/Home/HomePage.dart';
import 'package:dacn/Views/Home/LuyenNguPhap.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      initialRoute: AppRouter.main,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRouter.main:
            return MaterialPageRoute(builder: (context) => HomePage());
          case AppRouter.nguphap:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeNP(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0); // Trượt từ dưới lên
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            );
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}
