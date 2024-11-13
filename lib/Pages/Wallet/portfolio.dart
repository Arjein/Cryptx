import 'package:cryptx_cs50x/Constants/app_colors.dart';
import 'package:cryptx_cs50x/Constants/current_user.dart';
import 'package:cryptx_cs50x/Objects/CoinListObject.dart';
import 'package:cryptx_cs50x/Objects/coin.dart';
import 'package:cryptx_cs50x/Pages/Wallet/portfolio_coin_tile.dart';
import 'package:cryptx_cs50x/Providers/coinlist_provider.dart';
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
          CurrentUser.addVerticalSpace(1),
          const PortfolioTether(),
          CurrentUser.addVerticalSpace(2),
          Text(
            "Currencies",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!.copyWith(color: AppColors.lightBlue),
          ),
          CurrentUser.addVerticalSpace(1),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: CurrentUser.deviceHeight! * 0.43),
            child: const PortfolioCoinList(),
          ),
        ],
      ),
    );
  }
}

class PortfolioTether extends ConsumerWidget {
  // PEK AKILLICA DEĞİL SANIRIM BUNA BAKMAK LAZIM
  const PortfolioTether({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(coinMapProvider);
    return PortfolioCoinTile(coin: CoinListObject.tether);
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
      userwallet.sort(
        (a, b) => (b.current_price! * userCoins[b.symbol])
            .compareTo(a.current_price! * userCoins[a.symbol]),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: userwallet.length,
      itemBuilder: (context, index) {
        return userwallet[index].current_price! *
                    userCoins[userwallet[index].symbol] >
                0.1
            ? PortfolioCoinTile(
                coin: userwallet[index],
              )
            : Container();
      },
    );
  }
}
