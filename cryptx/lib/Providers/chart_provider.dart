import 'package:cryptx/Objects/API.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      final data = await API().fetchChart(coin.id);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
