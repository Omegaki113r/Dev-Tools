/*
 * Project: Xtronic Dev Tools
 * File Name: decimal_bitwise_widget.dart
 * File Created: Sunday, 11th February 2024 1:24:07 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:18 pm
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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DecimalBitwise extends StatelessWidget {
  const DecimalBitwise({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      cornerRadius: 20,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SoftTextField(
                  label: lblDecimal,
                  inputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(regExDecimal))
                  ],
                  controller: context
                      .read<BitwiseCalculatorProvider>()
                      .decimalController,
                  onChanged: (value) {
                    context
                        .read<BitwiseCalculatorProvider>()
                        .changeText(ChangedType.decimal, value);
                  },
                ),
              ),
            ),
            // ConstrainedBox(
            //   constraints:
            //       BoxConstraints(maxWidth: boxConstraints.maxWidth * 0.5),
            //   child: Padding(
            //     padding: const EdgeInsets.all(30),
            //     child: SoftTextField(
            //       label: lblDecimal,
            //       controller: context
            //           .read<BitwiseCalculatorProvider>()
            //           .decimalController,
            //       onChanged: (value) {
            //         context
            //             .read<BitwiseCalculatorProvider>()
            //             .changeText(ChangedType.decimal, value);
            //       },
            //     ),
            //   ),
            // ),
            // Consumer<BitwiseCalculatorProvider>(
            //     builder: (context, value, child) {
            //   return AnimatedContainer(
            //     duration: const Duration(milliseconds: 1000),
            //     width: value.decimalResult.isNotEmpty
            //         ? boxConstraints.maxWidth * 0.3
            //         : 0,
            //     child: Padding(
            //         padding: const EdgeInsets.all(30),
            //         child: SoftText(
            //           value.typeConverterModel.decimal2sCompliment,
            //           label: lbl2sCompliment,
            //           textStyle: Theme.of(context).textTheme.bodyLarge,
            //           maxLines: 1,
            //           contentPadding: const EdgeInsets.symmetric(
            //               vertical: 10, horizontal: 20),
            //         )),
            //   );
            // }),
            Consumer<BitwiseCalculatorProvider>(
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: value.decimalResult.isNotEmpty
                      ? boxConstraints.maxWidth * 0.5
                      : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SoftText(
                      value.decimalResult,
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
        );
      }),
    );
  }
}
