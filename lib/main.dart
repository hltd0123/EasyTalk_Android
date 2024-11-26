import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Views/Home/LuyenNguPhap.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:dacn/Views/PhatAm/MainPagePhatAm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmM3OWZjMTQwZDAwYzYwZDRkYTAwNCIsInJvbGUiOiJ1c2VyIiwidXNlcm5hbWUiOiJWaW5wcm8iLCJpYXQiOjE3MzIzNTk2NTMsImV4cCI6MTczMjM2MzI1M30.-AHctUVbmQ_v8PHBlz_oXa5-Xz90YClUQ3OWgXXIORk');
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
      initialRoute: AppRouter.main,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRouter.main:
            return MaterialPageRoute(builder: (context) => MainPage());
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
          case AppRouter.phatam:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MainPagePhatAm(),
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
        }
      },
    );
  }
}
