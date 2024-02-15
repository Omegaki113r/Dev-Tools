import 'dart:ffi';
import 'dart:typed_data';

import 'package:dev_tools/features/data_streamer/domain/entities/serial_data_entitiy.dart';

class SerialConvert {
  SerialDataEntity convert(Uint8List incomingBytes) {
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
    return SerialDataEntity(ascii, binary, decimal, hex);
  }

  String _ascii(byte) {
    return String.fromCharCode(byte);
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
