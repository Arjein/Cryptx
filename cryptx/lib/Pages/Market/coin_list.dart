import 'dart:async';

import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Objects/coingecko_data_service.dart';
import 'package:cryptx/Pages/Market/coin_list_tile.dart';
import 'package:flutter/material.dart';

class CoinList extends StatefulWidget {
  const CoinList({super.key});

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  //late List<Coin>? _list;
  late List<Coin> _list;
  @override
  void initState() {
    _list = [];
    init();
    super.initState();
  }

  void init() async {
    List<Coin> newlist = await DataService().fetch_coin_data();
    setState(() {
      _list = newlist;
    });

    Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        newlist = await DataService().fetch_coin_data();
        debugPrint("Bum"); // DOGE 426 ile biitiyo RIPPLE 966 ile bitiyor.
        setState(() {
          _list = newlist;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return Center(child: Container(child: Text("Error loading Data")));
    }

    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return CoinListTile(coin: _list[index]);
      },
    );
  }
}
