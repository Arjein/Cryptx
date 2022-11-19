import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Pages/Settings/settings_page.dart';
import 'package:cryptx/Pages/Wallet/app_wallet.dart';
import 'package:flutter/material.dart';

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
  late var _pages;
  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      const Text("INDEX 0: Home"),
      AppWallet(appUser: widget.appUser),
    ];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C R Y P T X"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const Settings_Screen()),
                  ),
                );
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: IndexedStack(
          index: _index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
