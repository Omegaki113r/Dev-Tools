import 'package:dart_eval/dart_eval.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_calculator_entity.dart';
import 'package:dev_tools/core/utils/bitwise_calculator/lexer.dart';
import 'package:dev_tools/core/utils/bitwise_calculator/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ChangedType { hex, octal, decimal, binary }

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

  BitwiseCalculatorEntity _typeConverterModel =
      BitwiseCalculatorEntity("", "", "", "", "", "");
  BitwiseCalculatorEntity typeConverterModel =
      BitwiseCalculatorEntity("", "", "", "", "", "");
  void changeText(ChangedType type, String text) {
    var currentPosition = 0;
    _typeConverterModel = BitwiseCalculatorEntity("", "", "", "", "", "");
    _decimalResult = "";
    _binaryResult = "";
    _octalResult = "";
    _hexResult = "";
    Lexer lexer = Lexer(text);
    switch (type) {
      case ChangedType.hex:
        currentPosition = _hexEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.eof &&
            token.token != TokenType.newline) {
          if (token.token == TokenType.number) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 16);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              int roundedUpTo = roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText +=
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? "${parsed.toSigned(roundedUpTo)} "
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
      case ChangedType.decimal:
        currentPosition = _decimalEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.eof &&
            token.token != TokenType.newline) {
          if (token.token == TokenType.number) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 10);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText +=
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? "${parsed.toSigned(roundedUpTo)} "
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
      case ChangedType.binary:
        currentPosition = _binaryEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.eof &&
            token.token != TokenType.newline) {
          if (token.token == TokenType.number) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 2);
            if (parsed != null) {
              _typeConverterModel.octalText += parsed.toRadixString(8);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText =
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? "${parsed.toSigned(roundedUpTo)} "
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
      case ChangedType.octal:
        currentPosition = _octalEditingController.selection.base.offset;
        Token? token = lexer.getToken();
        while (token != null &&
            token.token != TokenType.eof &&
            token.token != TokenType.newline) {
          if (token.token == TokenType.number) {
            BigInt? parsed = BigInt.tryParse(token.tokenText, radix: 8);
            if (parsed != null) {
              _typeConverterModel.binaryText += parsed.toRadixString(2);
              _typeConverterModel.decimalText += parsed.toRadixString(10);
              _typeConverterModel.hexText +=
                  parsed.toRadixString(16).toUpperCase();
              int roundedUpTo = roundUp(parsed.bitLength, 8);
              if (roundedUpTo > 64) {
                roundedUpTo = roundUp(roundedUpTo, 64);
              }
              if (roundedUpTo > 32) {
                roundedUpTo = roundUp(roundedUpTo, 32);
              }
              if (roundedUpTo > 16) {
                roundedUpTo = roundUp(roundedUpTo, 16);
              }
              if (roundedUpTo == 0) {
                roundedUpTo = 8;
              }
              _typeConverterModel.decimal2sComplimentText =
                  (parsed.toSigned(roundedUpTo) < BigInt.zero
                      ? "${parsed.toSigned(roundedUpTo)} "
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
          _decimalResult += "$evaluatedString ";
          _binaryResult += "${evaluatedString.toRadixString(2)} ";
          _octalResult += "${evaluatedString.toRadixString(8)} ";
          _hexResult += "${evaluatedString.toRadixString(16).toUpperCase()} ";
        }
        if (kDebugMode) {
          print(decimalResult);
        }
      } catch (e) {
        _decimalResult = "";
        _binaryResult = "";
        _octalResult = "";
        _hexResult = "";
        if (kDebugMode) {
          print(e);
        }
      }
    }

    _decimalEditingController.text = typeConverterModel.decimalText;
    _binaryEditingController.text = typeConverterModel.binaryText;
    _octalEditingController.text = typeConverterModel.octalText;
    _hexEditingController.text = typeConverterModel.hexText;
    switch (type) {
      case ChangedType.decimal:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection =
            TextSelection.collapsed(offset: currentPosition);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.binary:
        _binaryEditingController.selection =
            TextSelection.collapsed(offset: currentPosition);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection = TextSelection.collapsed(
            offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.octal:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection =
            TextSelection.collapsed(offset: currentPosition);
        _decimalEditingController.selection = TextSelection.collapsed(
            offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: _hexEditingController.text.length);
        break;
      case ChangedType.hex:
        _binaryEditingController.selection = TextSelection.collapsed(
            offset: _binaryEditingController.text.length);
        _octalEditingController.selection = TextSelection.collapsed(
            offset: _octalEditingController.text.length);
        _decimalEditingController.selection = TextSelection.collapsed(
            offset: _decimalEditingController.text.length);
        _hexEditingController.selection =
            TextSelection.collapsed(offset: currentPosition);
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
