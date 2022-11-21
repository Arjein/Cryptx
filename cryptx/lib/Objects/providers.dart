import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinProvider = StateProvider<Coin?>(
  (ref) => null,
);

final chartProvider = StateNotifierProvider<ChartNotifier, AsyncValue>((ref) {
  final coin = ref.watch(coinProvider);
  return ChartNotifier(coin!);
});

class ChartNotifier extends StateNotifier<AsyncValue> {
  ChartNotifier(Coin coin) : super(const AsyncValue.loading()) {
    fetchChart(coin);
  }

  Future<void> fetchChart(Coin coin) async {
    try {
      final data = await API().fetchGraphBinance(coin.symbol);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final marketProvider = StateNotifierProvider<MarketNotifier, AsyncValue>(
    (ref) => MarketNotifier());

class MarketNotifier extends StateNotifier<AsyncValue> {
  MarketNotifier() : super(const AsyncValue.loading()) {
    fetchLoopWithdelay(const Duration(seconds: 20));
  }

  Future<void> fetchLoopWithdelay(Duration delay) async {
    while (true) {
      try {
        final data = await API().fetchMarket();
        state = AsyncValue.data(data);
      } catch (e) {
        state = AsyncValue.error(e, StackTrace.current);
      }

      await Future.delayed(delay);
    }
  }
}
