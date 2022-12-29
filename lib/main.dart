import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Objects/app_user.dart';
import 'Pages/Home/home_page.dart';
import 'Themes/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CoinListObject().initCoinList();
  AppUser? usr;
  usr = await UserSecureStorage.getUser();
  //if (usr == null) {
    usr = AppUser(
      coins: <String, dynamic>{"USDT": 1000.0},
    );
    await UserSecureStorage.setUser(usr);
  //}
  CurrentUser.user = usr;
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptx',
      darkTheme: appDarkTheme,
      theme: appDarkTheme,
      routes: {
        '/home': (context) => const HomePage(),
      },
      initialRoute: '/home',
    );
  }
}
