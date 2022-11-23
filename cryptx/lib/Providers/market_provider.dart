import 'package:cryptx/Objects/API.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final marketProvider = StateNotifierProvider<MarketNotifier, AsyncValue>(
    (ref) => MarketNotifier());

class MarketNotifier extends StateNotifier<AsyncValue> {
  MarketNotifier() : super(const AsyncValue.loading()) {
    fetchLoopWithdelay(const Duration(milliseconds: 4000));
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
