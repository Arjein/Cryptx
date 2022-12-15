import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Firebase/auth.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Pages/Login/login_page.dart';
import 'package:cryptx/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Objects/app_user.dart';
import 'firebase_options.dart';
import 'Pages/Home/home_page.dart';
import 'Themes/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String? email = await UserSecureStorage.getEmail();
  String? password = await UserSecureStorage.getPassword();
  bool isLogged = await authUser(email, password);
  await CoinListObject().initCoinList();
  AppUser? usr;
  if (isLogged) {
    usr = await UserSecureStorage.getUser();

    CurrentUser.user = usr;
    runApp(ProviderScope(
      child: MyApp(
        isLogged: isLogged,
        user: usr!,
      ),
    ));
  } else {
    runApp(ProviderScope(
      child: MyApp(
        isLogged: isLogged,
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLogged, this.user});
  final bool isLogged;
  AppUser? user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptx',
      darkTheme: appDarkTheme,
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => Login_Screen(),
      },
      initialRoute: isLogged ? '/home' : '/login',
    );
  }
}
