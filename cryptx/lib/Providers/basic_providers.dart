import 'package:cryptx/Objects/coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'market_provider.dart';

final coinProvider = StateProvider<Coin?>(
  (ref) => null,
);
final queryProvider = StateProvider<String?>(
  (ref) => null,
);

final coinDetailProvider = StateProvider<Coin?>(
  (ref) {
    var coin = ref.watch(coinProvider);
    List<Coin> cl = ref.watch(marketProvider).value;
    var c = cl.where((element) => element.id == coin!.id).first;
    return c;
  },
);

final usdProvider = StateProvider.autoDispose<num>((ref) => 0);
final coin_usdProvider = StateProvider.autoDispose<num>((ref) => 0);
