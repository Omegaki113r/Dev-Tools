import 'package:dev_tools/models/type_converter_model.dart';
import 'package:flutter/material.dart';

enum ChangedType { HEX, OCTAL, DECIMAL, BINARY }

class TypeConverterProvider with ChangeNotifier {
  final TextEditingController _hexEditingController = TextEditingController();
  final TextEditingController _decimalEditingController =
      TextEditingController();
  final TextEditingController _binaryEditingController =
      TextEditingController();
  final TextEditingController _octalEditingController = TextEditingController();

  TypeConverterModel _typeConverterModel =
      TypeConverterModel("", "", "", "", "", "");
  TypeConverterModel typeConverterModel =
      TypeConverterModel("", "", "", "", "", "");
  void change_text(ChangedType type, String text) {
    _typeConverterModel = TypeConverterModel("", "", "", "", "", "");
    switch (type) {
      case ChangedType.HEX:
        if (text.contains(" ")) {
          List<BigInt> hex_list = [];
          final splittedBySpace = text.split(" ");
          for (var splittedElement in splittedBySpace) {
            if (splittedElement.isNotEmpty) {
              BigInt? parsed = BigInt.tryParse(splittedElement, radix: 16);
              if (parsed != null) {
                hex_list.add(parsed);
              }
            }
          }
          for (var int_element in hex_list) {
            _typeConverterModel.binaryText +=
                (int_element.toRadixString(2) + " ");
            _typeConverterModel.octalText +=
                (int_element.toRadixString(8) + " ");
            _typeConverterModel.decimalText +=
                (int_element.toRadixString(10) + " ");
            int roundedUpTo =
                TypeConverterModel.roundUp(int_element.bitLength, 8);
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
                ("${int_element.toSigned(roundedUpTo) < BigInt.zero ? int_element.toSigned(roundedUpTo).toString() : "N/A"} ");
          }
          _typeConverterModel.hexText = text;
        } else {
          BigInt? parsed = BigInt.tryParse(text, radix: 16);
          if (parsed != null) {
            _typeConverterModel.binaryText = parsed.toRadixString(2);
            _typeConverterModel.octalText = parsed.toRadixString(8);
            _typeConverterModel.decimalText = parsed.toRadixString(10);
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
            print(roundedUpTo);
            _typeConverterModel.decimal2sComplimentText =
                (parsed.toSigned(roundedUpTo) < BigInt.zero
                    ? parsed.toSigned(roundedUpTo).toString()
                    : "N/A");
          }
          _typeConverterModel.hexText = text;
        }
        break;
      case ChangedType.DECIMAL:
        if (text.contains(" ")) {
          List<BigInt> decimal_list = [];
          final splittedBySpace = text.split(" ");
          for (var splittedElement in splittedBySpace) {
            if (splittedElement.isNotEmpty) {
              BigInt? parsed = BigInt.tryParse(splittedElement, radix: 10);
              if (parsed != null) {
                decimal_list.add(parsed);
              }
            }
          }
          for (var int_element in decimal_list) {
            _typeConverterModel.binaryText +=
                (int_element.toRadixString(2) + " ");
            _typeConverterModel.octalText +=
                (int_element.toRadixString(8) + " ");
            _typeConverterModel.hexText +=
                (int_element.toRadixString(16) + " ");
            int roundedUpTo =
                TypeConverterModel.roundUp(int_element.bitLength, 8);
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
                ("${int_element.toSigned(roundedUpTo) < BigInt.zero ? int_element.toSigned(roundedUpTo).toString() : "N/A"} ");
          }
          _typeConverterModel.decimalText = text;
        } else {
          BigInt? parsed = BigInt.tryParse(text, radix: 10);
          if (parsed != null) {
            _typeConverterModel.binaryText = parsed.toRadixString(2);
            _typeConverterModel.octalText = parsed.toRadixString(8);
            _typeConverterModel.hexText = parsed.toRadixString(16);
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
            print(roundedUpTo);
            _typeConverterModel.decimal2sComplimentText =
                (parsed.toSigned(roundedUpTo) < BigInt.zero
                    ? parsed.toSigned(roundedUpTo).toString()
                    : "N/A");
          }
          _typeConverterModel.decimalText = text;
        }

        break;
      case ChangedType.BINARY:
        if (text.contains(" ")) {
          List<BigInt> binary_list = [];
          final splittedBySpace = text.split(" ");
          for (var splittedElement in splittedBySpace) {
            if (splittedElement.isNotEmpty) {
              BigInt? parsed = BigInt.tryParse(splittedElement, radix: 2);
              if (parsed != null) {
                binary_list.add(parsed);
              }
            }
          }
          for (var int_element in binary_list) {
            _typeConverterModel.octalText +=
                (int_element.toRadixString(8) + " ");
            _typeConverterModel.decimalText += (int_element.toString() + " ");
            _typeConverterModel.hexText +=
                (int_element.toRadixString(16) + " ");
            int roundedUpTo =
                TypeConverterModel.roundUp(int_element.bitLength, 8);
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
                ("${int_element.toSigned(roundedUpTo) < BigInt.zero ? int_element.toSigned(roundedUpTo).toString() : "N/A"} ");
          }
          _typeConverterModel.binaryText = text;
        } else {
          BigInt? parsed = BigInt.tryParse(text, radix: 2);
          if (parsed != null) {
            _typeConverterModel.octalText = parsed.toRadixString(8);
            _typeConverterModel.decimalText = parsed.toRadixString(10);
            _typeConverterModel.hexText = parsed.toRadixString(16);
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
            print(roundedUpTo);
            _typeConverterModel.decimal2sComplimentText =
                (parsed.toSigned(roundedUpTo) < BigInt.zero
                    ? parsed.toSigned(roundedUpTo).toString()
                    : "N/A");
            _typeConverterModel.binaryText = text;
          }
        }
        break;
      case ChangedType.OCTAL:
        if (text.contains(" ")) {
          List<BigInt> octal_list = [];
          final splittedBySpace = text.split(" ");
          for (var splittedElement in splittedBySpace) {
            if (splittedElement.isNotEmpty) {
              BigInt? parsed = BigInt.tryParse(splittedElement, radix: 8);
              if (parsed != null) {
                octal_list.add(parsed);
              }
            }
          }
          for (var int_element in octal_list) {
            _typeConverterModel.binaryText +=
                (int_element.toRadixString(2) + " ");
            _typeConverterModel.decimalText +=
                (int_element.toRadixString(10) + " ");
            _typeConverterModel.hexText +=
                (int_element.toRadixString(16) + " ");
            int roundedUpTo =
                TypeConverterModel.roundUp(int_element.bitLength, 8);
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
                ("${int_element.toSigned(roundedUpTo) < BigInt.zero ? int_element.toSigned(roundedUpTo).toString() : "N/A"} ");
          }
          _typeConverterModel.octalText = text;
        } else {
          BigInt? parsed = BigInt.tryParse(text, radix: 8);
          if (parsed != null) {
            _typeConverterModel.binaryText = parsed.toRadixString(2);
            _typeConverterModel.decimalText = parsed.toRadixString(10);
            _typeConverterModel.hexText = parsed.toRadixString(16);
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
            print(roundedUpTo);
            _typeConverterModel.decimal2sComplimentText =
                (parsed.toSigned(roundedUpTo) < BigInt.zero
                    ? parsed.toSigned(roundedUpTo).toString()
                    : "N/A");
            _typeConverterModel.octalText = text;
          }
        }
        break;
    }
    // }
    typeConverterModel = _typeConverterModel;

    _decimalEditingController.text = typeConverterModel.decimalText;
    _decimalEditingController.selection =
        TextSelection.collapsed(offset: typeConverterModel.decimalText.length);
    _hexEditingController.text = typeConverterModel.hexText;
    _hexEditingController.selection =
        TextSelection.collapsed(offset: typeConverterModel.hexText.length);
    _binaryEditingController.text = typeConverterModel.binaryText;
    _binaryEditingController.selection =
        TextSelection.collapsed(offset: typeConverterModel.binaryText.length);
    _octalEditingController.text = typeConverterModel.octalText;
    _octalEditingController.selection =
        TextSelection.collapsed(offset: typeConverterModel.octalText.length);

    notifyListeners();
  }

  TextEditingController get decimalController => _decimalEditingController;
  TextEditingController get binaryController => _binaryEditingController;
  TextEditingController get octalController => _octalEditingController;
  TextEditingController get hexController => _hexEditingController;
}
