/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_calculator_view.dart
 * File Created: Wednesday, 3rd January 2024 9:39:05 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:10 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_card.dart';
import 'package:dev_tools/core/widgets/soft_checkbox.dart';
import 'package:dev_tools/core/widgets/soft_divider.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/bitwise_calculator_provider.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/binary_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/decimal_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/hex_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/octal_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/ascii_bitwise_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TypeConverterView extends StatelessWidget {
  const TypeConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            const SoftDivider(),
            SoftCard(
              height: 100,
              cornerRadius: 20,
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SoftCheckbox(
                      lblDecimal,
                      onChanged: (checked) => context
                          .read<BitwiseCalculatorProvider>()
                          .isDecimalVisible = checked ?? false,
                      value: context
                          .watch<BitwiseCalculatorProvider>()
                          .isDecimalVisible,
                      labelStyle: const TextStyle(fontSize: 12.0),
                    ),
                    const Gap(15),
                    SoftCheckbox(
                      lblBinary,
                      onChanged: (checked) => context
                          .read<BitwiseCalculatorProvider>()
                          .isBinaryVisible = checked ?? false,
                      value: context
                          .watch<BitwiseCalculatorProvider>()
                          .isBinaryVisible,
                      labelStyle: const TextStyle(fontSize: 12.0),
                    ),
                    const Gap(15),
                    SoftCheckbox(
                      lblOctal,
                      onChanged: (checked) => context
                          .read<BitwiseCalculatorProvider>()
                          .isOctalVisible = checked ?? false,
                      value: context
                          .watch<BitwiseCalculatorProvider>()
                          .isOctalVisible,
                      labelStyle: const TextStyle(fontSize: 12.0),
                    ),
                    const Gap(15),
                    SoftCheckbox(
                      lblHex,
                      onChanged: (checked) => context
                          .read<BitwiseCalculatorProvider>()
                          .isHexVisible = checked ?? false,
                      value: context
                          .read<BitwiseCalculatorProvider>()
                          .isHexVisible,
                      labelStyle: const TextStyle(fontSize: 12.0),
                    ),
                    const Gap(15),
                    SoftCheckbox(
                      lblAscii,
                      onChanged: (checked) => context
                          .read<BitwiseCalculatorProvider>()
                          .isAsciiVisible = checked ?? false,
                      value: context
                          .watch<BitwiseCalculatorProvider>()
                          .isAsciiVisible,
                      labelStyle: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(40),
            if (context
                .watch<BitwiseCalculatorProvider>()
                .isDecimalVisible) ...[
              const DecimalBitwise(),
              const SoftDivider(),
            ],
            if (context.watch<BitwiseCalculatorProvider>().isBinaryVisible) ...[
              const BinaryBitwise(),
              const SoftDivider(),
            ],
            if (context.watch<BitwiseCalculatorProvider>().isOctalVisible) ...[
              const OctalBitwise(),
              const SoftDivider(),
            ],
            if (context.watch<BitwiseCalculatorProvider>().isHexVisible) ...[
              const HexBitwise(),
              const SoftDivider(),
            ],
            if (context.watch<BitwiseCalculatorProvider>().isAsciiVisible) ...[
              const ASCIIBitwise()
            ],
          ],
        ),
      ),
    );
  }
}
