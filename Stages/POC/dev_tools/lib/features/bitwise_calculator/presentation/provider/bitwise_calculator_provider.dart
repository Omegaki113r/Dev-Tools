/*
 * Project: Xtronic Dev Tools
 * File Name: bitwise_calculator_provider.dart
 * File Created: Wednesday, 3rd January 2024 10:03:08 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:31:14 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_solver_entity.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_convert_usecase.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_evaluate_usecase.dart';
import 'package:flutter/material.dart';

enum ChangedType { hex, octal, decimal, binary }

class BitwiseCalculatorProvider with ChangeNotifier {
  final TextEditingController _hexEditingController = TextEditingController();
  final TextEditingController _decimalEditingController =
      TextEditingController();
  final TextEditingController _binaryEditingController =
      TextEditingController();
  final TextEditingController _octalEditingController = TextEditingController();

  BitwiseConverterEntity _typeConverterModel = BitwiseConverterEntity.empty();
  BitwiseSolverEntity _bitwiseSolverEntity = BitwiseSolverEntity.empty();

  final BitwiseConvert _bitwiseConvert;
  final BitwiseEvaluate _bitwiseEvaluate;

  BitwiseCalculatorProvider(this._bitwiseConvert, this._bitwiseEvaluate);

  void changeText(ChangedType type, String text) {
    var currentPosition = 0;
    switch (type) {
      case ChangedType.hex:
        currentPosition = _hexEditingController.selection.base.offset;
        _typeConverterModel = _bitwiseConvert.convertFromHex(text);
        break;
      case ChangedType.decimal:
        currentPosition = _decimalEditingController.selection.base.offset;
        _typeConverterModel = _bitwiseConvert.convertFromDecimal(text);
        break;
      case ChangedType.binary:
        currentPosition = _binaryEditingController.selection.base.offset;
        _typeConverterModel = _bitwiseConvert.convertFromBinary(text);
        break;
      case ChangedType.octal:
        currentPosition = _octalEditingController.selection.base.offset;
        _typeConverterModel = _bitwiseConvert.convertFromOctal(text);
        break;
    }

    _bitwiseSolverEntity =
        _bitwiseEvaluate.evaluate(_typeConverterModel.decimal);

    _decimalEditingController.text = _typeConverterModel.decimal;
    _binaryEditingController.text = _typeConverterModel.binary;
    _octalEditingController.text = _typeConverterModel.octal;
    _hexEditingController.text = _typeConverterModel.hex;
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
  String get decimalResult => _bitwiseSolverEntity.decimal;
  String get binaryResult => _bitwiseSolverEntity.binary;
  String get octalResult => _bitwiseSolverEntity.octal;
  String get hexResult => _bitwiseSolverEntity.hex;

  BitwiseConverterEntity get typeConverterModel => _typeConverterModel;
}
