import 'package:cryptx/Firebase/auth.dart';
import 'package:cryptx/Pages/Login/login_page.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Pages/Home/home_page.dart';
import 'Themes/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var email = await UserSecureStorage.getEmail();
  var password = await UserSecureStorage.getPassword();
  bool isLogged = await Auth_User(email!, password);

  runApp(MyApp(
    isLogged: isLogged,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogged});
  final isLogged;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptx',
      darkTheme: appDarkTheme,
      routes: {
        '/home': (context) => HomePage(AppUser: UserSecureStorage.getUser()),
        '/login': (context) => Login_Screen(),
      },
      initialRoute: isLogged ? '/home' : '/login',
/*
      home: isLogged
          ? HomePage(AppUser: UserSecureStorage.getUser())
          : Login_Screen(),
          */
    );
  }
}
