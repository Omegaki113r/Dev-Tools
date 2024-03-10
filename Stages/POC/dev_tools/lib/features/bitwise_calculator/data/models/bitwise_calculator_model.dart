/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_calculator_model.dart
 * File Created: Saturday, 10th February 2024 10:51:59 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:45 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';

class BitwiseCalculatorModel extends BitwiseConverterEntity {
  BitwiseCalculatorModel(
    String hexText,
    String decimalText,
    String decimal2sComplimentText,
    String binaryText,
    String octalText,
    String ascii,
  ) : super(hexText, decimalText, decimal2sComplimentText, binaryText,
            octalText, ascii);
}
