import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmM3OWZjMTQwZDAwYzYwZDRkYTAwNCIsInJvbGUiOiJ1c2VyIiwidXNlcm5hbWUiOiJWaW5wcm8iLCJpYXQiOjE3MzMyODg0MzUsImV4cCI6MTczMzI5MjAzNX0.3zrVGpUIf1ikBwvo5w9NlpPbDrA-TWtlPxlA2-83aZc');
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
    return const MaterialApp(
      initialRoute: AppRouter.main,
      onGenerateRoute: AppRouter.generateRoute
    );
  }
}
