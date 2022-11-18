import 'package:flutter/material.dart';

import 'Pages/Home/home_page.dart';
import 'Themes/dark_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptx',
      darkTheme: appDarkTheme,
      home: const HomePage(),
    );
  }
}
