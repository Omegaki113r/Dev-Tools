import 'package:dev_tools/models/type_converter_model.dart';
import 'package:flutter/material.dart';

enum ChangedType { HEX, DECIMAL, BINARY }

class TypeConverterProvider with ChangeNotifier {
  TypeConverterModel _typeConverterModel = TypeConverterModel("", "", "", "");
  TypeConverterModel typeConverterModel = TypeConverterModel("", "", "", "");
  void change_text(ChangedType type, String text) {
    switch (type) {
      case ChangedType.HEX:
      final splittedBySpace = text.split(" "); 
        int? parsed = int.tryParse(text, radix: 16);
        if (parsed == null) {
        } else {
          _typeConverterModel.binaryText = parsed.toRadixString(2);
          _typeConverterModel.decimalText = parsed.toString();
          _typeConverterModel.hexText = text;
        }
        break;
      case ChangedType.DECIMAL:
        int? parsed = int.tryParse(text, radix: 10);
        if (parsed == null) {
        } else {
          _typeConverterModel.binaryText = parsed.toRadixString(2);
          _typeConverterModel.hexText = parsed.toRadixString(16);
          _typeConverterModel.decimalText = text;
        }
        break;
      case ChangedType.BINARY:
        int? parsed = int.tryParse(text, radix: 2);
        if (parsed == null) {
        } else {
          _typeConverterModel.decimalText = parsed.toRadixString(10);
          _typeConverterModel.hexText = parsed.toRadixString(16);
          _typeConverterModel.binaryText = text;
        }
        break;
    }
    typeConverterModel = _typeConverterModel;
    notifyListeners();
  }
}
