/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_converter_entity.dart
 * File Created: Wednesday, 3rd January 2024 9:56:14 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:54 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

class BitwiseConverterEntity {
  final String hex;
  final String decimal;
  final String decimal2sCompliment;
  final String binary;
  final String octal;
  BitwiseConverterEntity(
    this.hex,
    this.decimal,
    this.decimal2sCompliment,
    this.binary,
    this.octal,
  );

  BitwiseConverterEntity.empty()
      : hex = "",
        decimal = "",
        decimal2sCompliment = "",
        binary = "",
        octal = "";
}
