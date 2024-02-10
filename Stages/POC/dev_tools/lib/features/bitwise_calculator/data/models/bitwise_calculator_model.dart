import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';

class BitwiseCalculatorModel extends BitwiseConverterEntity {
  BitwiseCalculatorModel(
    String hexText,
    String decimalText,
    String decimal2sComplimentText,
    String binaryText,
    String octalText,
  ) : super(hexText, decimalText, decimal2sComplimentText,
            binaryText, octalText);
}
