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

import 'package:dev_tools/core/widgets/soft_divider.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/binary_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/decimal_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/hex_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/octal_bitwise_widget.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/widgets/ascii_bitwise_widget.dart';
import 'package:flutter/material.dart';

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
          children: const [
            DecimalBitwise(),
            SoftDivider(),
            BinaryBitwise(),
            SoftDivider(),
            OctalBitwise(),
            SoftDivider(),
            HexBitwise(),
            SoftDivider(),
            ASCIIBitwise(),
          ],
        ),
      ),
    );
  }
}
