import 'package:cryptx/Constants/Constants.dart';
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
      height: UserDevice.getDeviceHeight(context) * 20 / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: AppColors.lightBlue.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "C R Y P T X",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 30, color: AppColors.lightBlue),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(style: Theme.of(context).textTheme.overline, "Balance"),
                  const BalanceWidget(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  CurrentUser.user!.username!,
                ),
              ),
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
    double? _currentBalance = ref.watch(userBalanceProvider);
    debugPrint("Rebuild Wallet");
    return Text(
        style: Theme.of(context).textTheme.headline6,
        Constants.appPriceFormat(_currentBalance!));
  }
}
