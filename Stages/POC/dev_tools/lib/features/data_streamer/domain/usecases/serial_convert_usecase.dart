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

  Stream<StreamDataEntity> convertCharacter(Uint8List incomingBytes) async* {
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
    yield const StreamDataEntity("", "", "", "");
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
