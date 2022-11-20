import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  const CoinDetail({super.key, required this.coin});
  final Coin coin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("${coin.name} details..."),
      ),
    );
  }
}
