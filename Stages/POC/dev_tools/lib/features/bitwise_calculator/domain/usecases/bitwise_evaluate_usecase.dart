/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_evaluate_usecase.dart
 * File Created: Sunday, 11th February 2024 3:05:11 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:06 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

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
        if (text.contains(".")) {
        } else {
          BigInt evaluatedString = BigInt.from(eval(element));
          if (evaluatedString.toRadixString(10) != element) {
            decimalResult += "$evaluatedString ";
            binaryResult += "${evaluatedString.toRadixString(2)} ";
            octalResult += "${evaluatedString.toRadixString(8)} ";
            hexResult += "${evaluatedString.toRadixString(16).toUpperCase()} ";
          }
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
