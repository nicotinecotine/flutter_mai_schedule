import 'package:flutter/material.dart';
import 'package:flutter_mai_schedule/pages/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mai_schedule/my_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyAppProvider>.value(value: MyAppProvider()),
      ],
      child: const MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  build(BuildContext context) {
    MyAppProvider state = Provider.of<MyAppProvider>(context);
    return MaterialApp(
      title: 'Mai Schedule',
      home: const WelcomePage(),
      theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
