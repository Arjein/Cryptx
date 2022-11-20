import 'dart:async';

import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/market_page.dart';
import 'package:cryptx/Pages/Settings/settings_page.dart';
import 'package:cryptx/Pages/Wallet/app_wallet.dart';
import 'package:flutter/material.dart';

// TODO
/*
Use Riverpod to manage states. Unless, using pure flutter will decrease the efficiency.
 */
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.appUser,
  }) : super(key: key);
  final AppUser appUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late List<Widget> _pages;
  late List<Coin> _coinList;
  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      const CoinListPage(),
      AppWallet(appUser: widget.appUser),
    ];
    _coinList = [];

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet")
        ],
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
