import 'package:cryptx/Objects/coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinProvider = StateProvider<Coin?>(
  (ref) => null,
);
final queryProvider = StateProvider<String?>(
  (ref) => null,
);
