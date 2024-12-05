import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      child: MyApp(tk: token),
    ),
  );
}

class MyApp extends StatefulWidget {
  String? tk;

  MyApp({super.key, this.tk});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String init = widget.tk == null ? AppRouter.dangnhap : AppRouter.main;
    return MaterialApp(
      initialRoute: init,
      onGenerateRoute: AppRouter.generateRoute
    );
  }
}
