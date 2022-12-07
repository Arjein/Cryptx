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
          const PortfolioTether(),
          UserDevice.addVerticalSpace(context, 2),
          Text(
            "Currencies",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: AppColors.lightBlue),
          ),
          UserDevice.addVerticalSpace(context, 1),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: UserDevice.getDeviceHeight(context) * 43 / 100),
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
        return PortfolioCoinTile(
          coin: userwallet[index],
        );
      },
    );
  }
}
