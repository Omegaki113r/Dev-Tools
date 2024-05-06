/*
 * Project: Xtronic Dev Tools
 * File Name: serial_convert_usecase.dart
 * File Created: Friday, 16th February 2024 12:40:44 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:40 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'dart:typed_data';

import 'package:dev_tools/features/data_streamer/domain/entities/stream_data_entitiy.dart';

class SerialConvert {
  StreamDataEntity convert(Uint8List incomingBytes) {
    String ascii = "";
    String binary = "";
    String decimal = "";
    String hex = "";
    for (var element in incomingBytes) {
      ascii += _ascii(element);
      binary += "${_binary(element)} ";
      decimal += "${_decimal(element)} ";
      hex += "${_hex(element)} ";
    }
    return StreamDataEntity(ascii, binary, decimal, hex);
  }

  Stream<StreamDataEntity> convertCharacter(List<int> incomingBytes) async* {
    String ascii = "";
    String binary = "";
    String decimal = "";
    String hex = "";
    for (var element in incomingBytes) {
      ascii = _ascii(element);
      binary = _binary(element);
      decimal = _decimal(element);
      hex = _hex(element);
      yield StreamDataEntity(ascii, binary, decimal, hex);
    }
  }

  String _ascii(byte) {
    return String.fromCharCode(byte).replaceAll('\n', '');
  }

  String _binary(byte) {
    return byte.toRadixString(2);
  }

  String _decimal(byte) {
    return byte.toRadixString(10);
  }

  String _hex(byte) {
    var hex0 = byte.toRadixString(16).toUpperCase();
    return hex0.padLeft(2, "0");
  }
}
