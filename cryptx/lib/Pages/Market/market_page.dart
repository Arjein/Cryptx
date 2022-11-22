import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Market/coin_list.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:cryptx/Providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO PROVIDER

class CoinListPage extends ConsumerWidget {
  CoinListPage({super.key});
  List<Coin>? coinList;
  List<Coin>? oldcoinList;
  List<Coin>? queryList;
  String quasdery = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (coinList != null && coinList!.length > 1) {
      if (coinList!.isNotEmpty) {
        oldcoinList = coinList;
      }
    }
    coinList = ref.watch(marketProvider).value;
    final String? query = ref.watch(queryProvider) as String?;
    debugPrint("Query:$query");
    return Scaffold(
      appBar: AppBar(
        title: const Text("C R Y P T X"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 45,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.obsidian_invert,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: AppColors.obsidian_invert),
                hintText: "Search Coin",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ref
                    .read(queryProvider.notifier)
                    .update((state) => value.toLowerCase());
                searchCoin(value);
              },
            ),
          ),
          Expanded(
            child: coinList != null
                ? CoinList(
                    coinList: coinList,
                    querycoinList: queryList,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  // Search coin in ListView.
  void searchCoin(String query) {
    final List<Coin> coins = coinList!.where((coin) {
      final nameLower = coin.name.toLowerCase();
      final qLower = query.toLowerCase();

      return nameLower.contains(qLower);
    }).toList();
    queryList = coins;
    debugPrint(queryList.toString());
  }
}








// CoinList(coinList: coinList),
