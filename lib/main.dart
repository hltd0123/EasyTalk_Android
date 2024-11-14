import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Views/Home/MainPage.dart';
import 'package:dacn/Views/Home/MainPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async{
  await dotenv.load(fileName: ".env");
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
      home: MainPage(),
      initialRoute: AppRouter.main,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
