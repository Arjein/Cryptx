import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Market/market_page.dart';
import 'package:cryptx/Pages/Wallet/app_wallet.dart';
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
      AppWallet(),
    ];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: UserDevice.getDeviceHeight(context) * 0.11,
        child: BottomNavigationBar(
          backgroundColor: AppColors.bgColor,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: AppColors.obsidian_invert,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: "Home",
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
