import 'package:cryptx/Colors/app_colors.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmountInput extends ConsumerWidget {
  const AmountInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    num asCoin = 0;
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(
          Icons.attach_money,
          color: AppColors.obsidian_invert,
        ),
        hintText: "Amount",
        border: InputBorder.none,
      ),
      onChanged: (value) {
        ref
            .read(usdProvider.notifier)
            .update((state) => value != "" ? num.parse(value) : 0);
        debugPrint("Builded something");
      },
      autocorrect: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
