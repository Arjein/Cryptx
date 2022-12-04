import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'coinlist_provider.dart';

final userBalanceProvider = StateProvider<num?>(
  (ref) {
    num balance = 0;
    AppUser? user = CurrentUser.user!;
    var userCoins = user.coins;
    Map<String, Coin> cl = CoinListObject.coinMap;

    if (cl.isNotEmpty) {
      for (Coin c in cl.values) {
        if (userCoins!.containsKey(c.symbol)) {
          balance += c.current_price! * userCoins[c.symbol];
        }
      }
    }

    return balance; // 16537.061
  },
);
