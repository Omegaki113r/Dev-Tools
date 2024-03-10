///
/// Project: Xtronic Dev Tools
/// File Name: ascii_bitwise_widget.dart
/// File Created: Sunday, 10th March 2024 8:17:57 pm
/// Author: Omegaki113r (omegaki113r@gmail.com)
/// -----
/// Last Modified: Sunday, 10th March 2024 8:21:04 pm
/// Modified By: Omegaki113r (omegaki113r@gmail.com)
/// -----
/// Copyright 2024 - 2024 0m3g4ki113r, Xtronic
/// -----
/// HISTORY:
/// Date      	By	Comments
/// ----------	---	---------------------------------------------------------
///

import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_card.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/bitwise_calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ASCIIBitwise extends StatelessWidget {
  const ASCIIBitwise({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      cornerRadius: 20,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SoftTextField(
                label: lblAscii,
                controller:
                    context.read<BitwiseCalculatorProvider>().asciiController,
                onChanged: (value) {
                  context
                      .read<BitwiseCalculatorProvider>()
                      .changeText(ChangedType.ascii, value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
