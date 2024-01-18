// import 'dart:ffi';

import 'package:dart_eval/dart_eval.dart';
import 'package:dev_tools/models/type_converter_model.dart';
import 'package:dev_tools/utils/bitwise_calculator/lexer.dart';
import 'package:flutter/material.dart';

enum ChangedType { HEX, OCTAL, DECIMAL, BINARY }

class TypeConverterProvider with ChangeNotifier {
  final TextEditingController _hexEditingController = TextEditingController();
  final TextEditingController _decimalEditingController =
      TextEditingController();
  final TextEditingController _binaryEditingController =
      TextEditingController();
  final TextEditingController _octalEditingController = TextEditingController();
  String _decimalResult = "";
  String _binaryResult = "";
  String _octalResult = "";
  String _hexResult = "";

  TypeConverterModel _typeConverterModel =
      TypeConverterModel("", "", "", "", "", "");
  TypeConverterModel typeConverterModel =
      TypeConverterModel("", "", "", "", "", "");
  void change_text(ChangedType type, String text) {
    var current_position = 0;
    _typeConverterModel = TypeConverterModel("", "", "", "", "", "");
    _decimalResult = "";
    _binaryResult = "";
    _octalResult = "";
    _hexResult = "";
    Lexer lexer = Lexer(text);
    switch (type) {
      case ChangedType.HEX:
        current_position = _hexEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.EOF &&
            token.token != TokenType.NEWLINE) {
          if (token.token == TokenType.NUMBER) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 16);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              int roundedUpTo = TypeConverterModel.roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText +=
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? parsed.toSigned(roundedUpTo).toString() + " "
                      : "N/A ");
            }
          } else {
            _typeConverterModel.binaryText += token.tokenText;
            _typeConverterModel.octalText += token.tokenText;
            _typeConverterModel.decimalText += token.tokenText;
          }
          token = lexer.getToken();
        }
        _typeConverterModel.hexText = text;
        break;
      case ChangedType.DECIMAL:
        current_position = _decimalEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.EOF &&
            token.token != TokenType.NEWLINE) {
          if (token.token == TokenType.NUMBER) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 10);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = TypeConverterModel.roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText +=
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? parsed.toSigned(roundedUpTo).toString() + " "
                      : "N/A ");
            }
          } else {
            _typeConverterModel.binaryText += token.tokenText;
            _typeConverterModel.octalText += token.tokenText;
            _typeConverterModel.hexText += token.tokenText;
          }
          token = lexer.getToken();
        }
        _typeConverterModel.decimalText = text;
        break;
      case ChangedType.BINARY:
        current_position = _binaryEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.EOF &&
            token.token != TokenType.NEWLINE) {
          if (token.token == TokenType.NUMBER) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 2);
            if (parsed != null) {
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = TypeConverterModel.roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText =
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? parsed.toSigned(roundedUpTo).toString() + " "
                      : "N/A ");
            }
          } else {
            _typeConverterModel.decimalText += token.tokenText;
            _typeConverterModel.octalText += token.tokenText;
            _typeConverterModel.hexText += token.tokenText;
          }
          token = lexer.getToken();
        }
        _typeConverterModel.binaryText = text;
        break;
      case ChangedType.OCTAL:
        current_position = _octalEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.EOF &&
            token.token != TokenType.NEWLINE) {
          if (token.token == TokenType.NUMBER) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 8);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = TypeConverterModel.roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = TypeConverterModel.roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText =
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? parsed.toSigned(roundedUpTo).toString() + " "
                      : "N/A ");
            }
          } else {
            _typeConverterModel.decimalText += token.tokenText;
            _typeConverterModel.binaryText += token.tokenText;
            _typeConverterModel.hexText += token.tokenText;
          }
          token = lexer.getToken();
        }
        _typeConverterModel.octalText = text;
        break;
    }
    typeConverterModel = _typeConverterModel;

    List arr = typeConverterModel.decimalText.split(" ");
    for (String element in arr) {
      try {
        BigInt evaluatedString = BigInt.from(eval(element));
        if (evaluatedString.toRadixString(10) != element) {
          _decimalResult += evaluatedString.toString() + " ";
          _binaryResult += evaluatedString.toRadixString(2) + " ";
          _octalResult += evaluatedString.toRadixString(8) + " ";
          _hexResult += evaluatedString.toRadixString(16).toUpperCase() + " ";
        }
        print(decimalResult);
      } catch (e) {
        _decimalResult = "";
        _binaryResult = "";
        _octalResult = "";
        _hexResult = "";
        print(e);
      }
    }

    _decimalEditingController.text = typeConverterModel.decimalText;
    _binaryEditingController.text = typeConverterModel.binaryText;
    _octalEditingController.text = typeConverterModel.octalText;
    _hexEditingController.text = typeConverterModel.hexText;
    switch (type) {
      case ChangedType.DECIMAL:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection =
            TextSelection.collapsed(offset: current_position);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.BINARY:
        _binaryEditingController.selection =
            TextSelection.collapsed(offset: current_position);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection = TextSelection.collapsed(
            offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.OCTAL:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection =
            TextSelection.collapsed(offset: current_position);
        _decimalEditingController.selection = TextSelection.collapsed(
            offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.HEX:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection =
            TextSelection.collapsed(offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: current_position);
        break;
    }
    notifyListeners();
  }

  TextEditingController get decimalController => _decimalEditingController;
  TextEditingController get binaryController => _binaryEditingController;
  TextEditingController get octalController => _octalEditingController;
  TextEditingController get hexController => _hexEditingController;
  String get decimalResult => _decimalResult;
  String get binaryResult => _binaryResult;
  String get octalResult => _octalResult;
  String get hexResult => _hexResult;
}
