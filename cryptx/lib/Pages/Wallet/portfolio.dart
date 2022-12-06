import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Objects/CoinListObject.dart';
import 'package:cryptx/Objects/coin.dart';
import 'package:cryptx/Pages/Wallet/portfolio_coin_tile.dart';
import 'package:cryptx/Providers/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserDevice.addVerticalSpace(context, 1),
          const Text("USDT"),
          PortfolioCoinTile(coin: CoinListObject.tether),
          UserDevice.addVerticalSpace(context, 1),
          const Text(
            "Crypto Assets",
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: UserDevice.getDeviceHeight(context) * 40 / 100),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: AppColors.obsidian_darker,
              ),
              child: const PortfolioCoinList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioCoinList extends ConsumerWidget {
  const PortfolioCoinList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(coinMapProvider);

    Map<String, Coin> cl = CoinListObject.coinMap;
    var userCoins = CurrentUser.user!.coins!; // Get the Id's of coins.
    List<Coin> userwallet = [];
    debugPrint(userCoins.toString());
    if (cl.isNotEmpty) {
      for (Coin c in cl.values) {
        if (userCoins.containsKey(c.symbol)) {
          userwallet.add(c);
        }
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: userwallet.length,
      itemBuilder: (context, index) {
        return PortfolioCoinTile(
          coin: userwallet[index],
        );
      },
    );
  }
}
