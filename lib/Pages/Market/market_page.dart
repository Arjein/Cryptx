import 'dart:async';
import 'dart:convert';

import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Objects/API.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Pages/Market/coin_list.dart';
import 'package:cryptx_cs50x/Providers/basic_providers.dart';
import 'package:cryptx_cs50x/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_socket_channel/io.dart';

class CoinListPage extends ConsumerWidget {
  CoinListPage({super.key});

  List<Coin>? queryList;

  String? query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    query = ref.watch(queryProvider);
    ref.watch(coinMapProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("C R Y P T X"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            // Search Bar.
            height: 45,
            margin: const EdgeInsets.fromLTRB(24, 2, 24, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.lightBlue,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: AppColors.obsidian_invert),
                hintText: "Search Coin",
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              autocorrect: false,
              onChanged: (value) {
                ref
                    .read(queryProvider.notifier)
                    .update((state) => value.toLowerCase());
                searchCoin(value);
              },
            ),
          ),
          Expanded(
            child: CoinListObject.coinMap != null
                ? CoinList(
                    querycoinList: queryList,
                  )
                : const Center(
                    child: SpinKitFadingCircle(
                    color: AppColors.obsidian_invert,
                  )),
          ),
        ],
      ),
    );
  }

  // Search coin in ListView.
  void searchCoin(String query) {
    final List<Coin> coins =
        CoinListObject.coinMap.values.toList().where((coin) {
      final nameLower = coin.name.toLowerCase();
      final symbolLower = coin.symbol.toLowerCase();
      final qLower = query.toLowerCase();

      return nameLower.contains(qLower) || symbolLower.contains(qLower);
    }).toList();
    queryList = coins;
  }
}

// CoinList(coinList: coinList),
