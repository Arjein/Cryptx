import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/app_user.dart';
import 'package:cryptx_cs50x/Pages/Market/market_page.dart';
import 'package:cryptx_cs50x/Pages/Wallet/app_wallet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      CoinListPage(),
      const AppWallet(),
    ];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser.deviceHeight ??= MediaQuery.of(context).size.height;
    CurrentUser.deviceWidth ??= MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: SizedBox(
        height: CurrentUser.deviceHeight! * 0.11,
        child: BottomNavigationBar(
          backgroundColor: AppColors.bgColor,
          selectedFontSize: 12,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: AppColors.obsidian_invert,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_outlined),
              label: "Market",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: "Wallet",
            )
          ],
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
        ),
      ),
    );
  }
}
