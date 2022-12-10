import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Pages/Market/Coin_Detail/Trade_Operations/trade_op.dart';
import 'package:flutter/material.dart';

class TradeWidget extends StatelessWidget {
  const TradeWidget({super.key, required this.coinSymbol});
  final String coinSymbol;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.lightBlue,
            indicatorColor: AppColors.lightBlue,
            unselectedLabelColor: AppColors.obsidian_invert,
            tabs: [
              Tab(
                text: "Buy",
              ),
              Tab(
                text: "Sell",
              )
            ],
          ),
          SizedBox(
            height: CurrentUser.deviceHeight! * 0.18,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TradeOperationWidget(
                  coinSymbol: coinSymbol,
                  text: "Buy",
                ),
                TradeOperationWidget(
                  text: "Sell",
                  coinSymbol: coinSymbol,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
