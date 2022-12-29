import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/app_user.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'coinlist_provider.dart';

final userBalanceProvider = StateProvider<double?>(
  (ref) {
    ref.watch(coinMapProvider);
    double balance = 0;
    AppUser? user = CurrentUser.user!;
    var userCoins = user.coins;
    balance += userCoins!["USDT"] ?? 0;
    for (String symbol in userCoins.keys) {
      if (symbol != "USDT") {
        balance += CoinListObject.coinMap["${symbol}USDT"]!.current_price! *
            userCoins[symbol];
      }
    }
    return balance; // 16537.061
  },
);
