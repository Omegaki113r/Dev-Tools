import 'package:dart_eval/dart_eval.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_solver_entity.dart';

class BitwiseEvaluate {
  BitwiseSolverEntity evaluate(String text) {
    String decimalResult = "";
    String binaryResult = "";
    String octalResult = "";
    String hexResult = "";

    List arr = text.split(" ");
    for (String element in arr) {
      try {
        BigInt evaluatedString = BigInt.from(eval(element));
        if (evaluatedString.toRadixString(10) != element) {
          decimalResult += "$evaluatedString ";
          binaryResult += "${evaluatedString.toRadixString(2)} ";
          octalResult += "${evaluatedString.toRadixString(8)} ";
          hexResult += "${evaluatedString.toRadixString(16).toUpperCase()} ";
        }
      } catch (e) {
        decimalResult = "";
        binaryResult = "";
        octalResult = "";
        hexResult = "";
      }
    }
    return BitwiseSolverEntity(
        hexResult, decimalResult, binaryResult, octalResult);
  }
}
