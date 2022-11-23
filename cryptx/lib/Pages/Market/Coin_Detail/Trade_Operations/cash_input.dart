import 'package:cryptx/Constants/app_colors.dart';
import 'package:cryptx/Providers/basic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashInput extends ConsumerWidget {
  const CashInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        decoration: const InputDecoration(
          icon: Icon(
            Icons.attach_money,
            color: AppColors.obsidian_invert,
          ),
          hintText: "Cash",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          ref
              .read(usdProvider.notifier)
              .update((state) => value != "" ? num.parse(value) : 0);
        },
        autocorrect: false,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
