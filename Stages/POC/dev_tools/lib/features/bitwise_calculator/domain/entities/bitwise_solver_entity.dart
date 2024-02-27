/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_solver_entity.dart
 * File Created: Sunday, 11th February 2024 2:59:58 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:57 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

class BitwiseSolverEntity {
  final String hex;
  final String decimal;
  final String binary;
  final String octal;
  BitwiseSolverEntity(
    this.hex,
    this.decimal,
    this.binary,
    this.octal,
  );

  BitwiseSolverEntity.empty()
      : hex = "",
        decimal = "",
        binary = "",
        octal = "";
}
