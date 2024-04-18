/*
 * Project: Xtronic Dev Tools
 * File Name: hex_bitwise_widget.dart
 * File Created: Sunday, 11th February 2024 1:18:09 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:20 pm
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
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/bitwise_calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HexBitwise extends StatelessWidget {
  const HexBitwise({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      cornerRadius: 20,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: SoftTextField(
                label: lblHex,
                controller:
                    context.read<BitwiseCalculatorProvider>().hexController,
                width: 200,
                onChanged: (value) {
                  context
                      .read<BitwiseCalculatorProvider>()
                      .changeText(ChangedType.hex, value);
                },
              ),
            ),
            Consumer<BitwiseCalculatorProvider>(
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: value.hexResult.isNotEmpty ? 300 : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SoftText(
                      value.hexResult,
                      label: lblExpressionResult,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
