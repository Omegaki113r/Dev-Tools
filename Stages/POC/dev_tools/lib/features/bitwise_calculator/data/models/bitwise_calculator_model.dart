import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_calculator_entity.dart';

class BitwiseCalculatorModel extends BitwiseCalculatorEntity {
  BitwiseCalculatorModel(
    String focusedText,
    String hexText,
    String decimalText,
    String decimal2sComplimentText,
    String binaryText,
    String octalText,
  ) : super(focusedText, hexText, decimalText, decimal2sComplimentText,
            binaryText, octalText);
}
