import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Constants/current_user.dart';
import 'package:cryptx/Constants/device_options.dart';
import 'package:cryptx/Providers/user_balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: UserDevice().getDeviceHeight(context) * 20 / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: AppColors.obsidian_invert,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "C R Y P T X",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 30),
                ),
                Container(
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.obsidian_invert,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.obsidian_darker,
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                      CurrentUser.user!.username!,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  children: [
                    const BalanceWidget(),
                    Text(
                        style: Theme.of(context).textTheme.overline, "Balance"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _currentBalance = ref.watch(userBalanceProvider);
    return Text(
        style: Theme.of(context).textTheme.headline6,
        "\$${_currentBalance!.toStringAsFixed(6)}");
  }
}
