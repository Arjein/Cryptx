import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Objects/app_user.dart';
import 'package:flutter/material.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    Key? key,
    required this.appUser,
  }) : super(key: key);
  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    debugPrint("THIS IS WALLET WIDGET");
    debugPrint(appUser.toString());
    return Container(
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
                Container(
                  child: Text(
                    "C R Y P T X",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      style: Theme.of(context).textTheme.titleMedium,
                      appUser.username!,
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
                    Container(
                      child: Text(
                          style: Theme.of(context).textTheme.titleSmall,
                          appUser.balance.toString()),
                    ),
                    Container(
                      child: Text(
                          style: Theme.of(context).textTheme.overline,
                          "Balance"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  style: Theme.of(context).textTheme.caption,
                  appUser.publicKey == null ? "" : appUser.publicKey!),
            )
          ],
        ),
      ),
    );
  }
}
