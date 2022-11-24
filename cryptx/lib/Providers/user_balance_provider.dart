import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'market_provider.dart';

final userBalanceProvider = StateProvider<num?>(
  (ref) {
    num balance = 0;
    AppUser? user = CurrentUser.user!;
    var userCoins = user.coins;
    List<Coin> cl = ref.watch(marketProvider).value ?? [];

    if (cl.isNotEmpty) {
      for (Coin c in cl) {
        if (userCoins!.containsKey(c.id)) {
          balance += c.current_price * userCoins[c.id];
        }
      }
    }

    return balance; // 16537.061
  },
);
