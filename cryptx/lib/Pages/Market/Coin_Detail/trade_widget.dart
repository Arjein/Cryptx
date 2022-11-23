import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/TradeButton.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/cash_input.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/trade_op.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Trade_Operations/coin_output.dart';

class TradeWidget extends StatelessWidget {
  const TradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              func(context);
            },
            tabs: const [
              Tab(
                text: "Buy",
              ),
              Tab(
                text: "Sell",
              )
            ],
          ),
          SizedBox(
            height: UserDevice().getDeviceHeight(context) * 18 / 100,
            child: const TabBarView(
              children: [
                TradeOperationWidget(
                  text: "Buy",
                ),
                TradeOperationWidget(
                  text: "Sell",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void func(context) {
  var a = ProviderScope.containerOf(context, listen: false)
      .read(usdProvider.notifier)
      .update((state) => 0);
  debugPrint("Provider okuma denemesi: $a");
}
