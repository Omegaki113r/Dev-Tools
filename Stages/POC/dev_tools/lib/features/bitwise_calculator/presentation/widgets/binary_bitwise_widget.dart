import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_card.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/bitwise_calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BinaryBitwise extends StatelessWidget {
  const BinaryBitwise({super.key});

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
                label: lblBinary,
                // width: 500,
                controller:
                    context.read<BitwiseCalculatorProvider>().binaryController,
                onChanged: (value) {
                  context
                      .read<BitwiseCalculatorProvider>()
                      .changeText(ChangedType.binary, value);
                },
              ),
            ),
          ),
          Consumer<BitwiseCalculatorProvider>(
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: value.binaryResult.isNotEmpty ? 300 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SoftText(
                    value.binaryResult,
                    label: lblExpressionResult,
                    maxLines: 1,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}