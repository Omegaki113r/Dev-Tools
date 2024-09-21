/*
 * Project: Xtronic Dev Tools
 * File Name: serial_streamer_provider.dart
 * File Created: Sunday, 28th January 2024 7:09:06 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Sunday, 3rd March 2024 3:39:52 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'dart:async';
import 'dart:isolate';
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_convert_usecase.dart';
import 'package:dev_tools/features/data_streamer/domain/entities/stream_data_entitiy.dart';
import 'package:dev_tools/features/data_streamer/domain/usecases/serial_convert_usecase.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:typed_data/typed_buffers.dart';

enum TXDataType { ascii, hex, decimal, binary }

enum TxOnEnter { none, cr, lf, crlf, space, stxetx, nul }

Map<TxOnEnter, List<int>> txEnterList = {
  TxOnEnter.none: [],
  TxOnEnter.cr: [13],
  TxOnEnter.lf: [10],
  TxOnEnter.crlf: [13, 10],
  TxOnEnter.space: [32],
  TxOnEnter.stxetx: [2, 3],
  TxOnEnter.nul: [0],
};

Map<TxOnEnter, String> txEnterStringList = {
  TxOnEnter.none: "None",
  TxOnEnter.cr: "CR",
  TxOnEnter.lf: "LF",
  TxOnEnter.crlf: "CR/LF",
  TxOnEnter.space: "Space",
  TxOnEnter.stxetx: "STX/ETX",
  TxOnEnter.nul: "NULL",
};

class SerialStreamerProvider<T> with ChangeNotifier {
  List<String> serialData = [];

  String _selectedBaudrate = "115200";
  String _selectedDataBits = "8";
  String _selectedStopBits = "1";
  String _selectedParity = "None";
  TxOnEnter _selectedtxOnEnter = TxOnEnter.none;

  int _rxData = 0;
  int _txData = 0;
  List<StreamDataEntity> rxDataList = [];
  List<StreamDataEntity> txDataList = [];
  ScrollController rxScrollController = ScrollController();
  ScrollController txScrollController = ScrollController();
  DragSelectGridViewController rxGridViewController =
      DragSelectGridViewController();
  DragSelectGridViewController txGridViewController =
      DragSelectGridViewController();

  String previousTransmitString = "";
  final TextEditingController _txEditingController = TextEditingController();
  TXDataType _txDataType = TXDataType.ascii;

  bool _txAutoScroll = true;
  bool _ctsFlowControl = false;
  bool _txAscii = true;
  bool _txBinary = false;
  bool _txDecimal = false;
  bool _txHex = false;

  bool _rxAutoScroll = true;
  bool _rxAscii = true;
  bool _rxBinary = false;
  bool _rxDecimal = false;
  bool _rxHex = false;

  late Timer _serialSearchTimer;

  final SerialService _serialService;
  final SerialConvert _convertUsecase = SerialConvert();

  SerialStreamerProvider(this._serialService) {
    if (!kIsWeb) {
      _serialSearchTimer = Timer.periodic(
        const Duration(seconds: 1),
        _serialSearchTimerCallback,
      );
    }
    // _txEditingController.addListener(txEditingListener);
    rxGridViewController.addListener(rxListener);
    txGridViewController.addListener(txListener);
  }

  void rxListener() {
    if (kDebugMode) {
      print(rxGridViewController.value);
    }
    notifyListeners();
  }

  void txListener() {
    if (kDebugMode) {
      print(txGridViewController.value);
    }
    notifyListeners();
  }

  void txEditingListener(String newValue) {
    int currentPosition = _txEditingController.selection.base.offset;
    bool cursorAtEnd = (newValue.length == currentPosition);
    switch (_txDataType) {
      case TXDataType.ascii:
        break;
      case TXDataType.hex:
        if (newValue.length < previousTransmitString.length) {
          previousTransmitString = _txEditingController.text;
          return;
        }
        if (!isHexadecimal(newValue.characters.last) &&
            newValue.characters.last != " ") {
          _txEditingController.text =
              newValue.substring(0, newValue.length - 1);
          _txEditingController.selection =
              TextSelection.collapsed(offset: _txEditingController.text.length);
          return;
        }
        String formattedString = "";
        List<String> splittedStringList = newValue.split(" ");
        if (newValue.characters.last == " ") {
          splittedStringList.last += " ";
        }
        for (int idx = 0; idx < splittedStringList.length; ++idx) {
          if (splittedStringList[idx].isEmpty) continue;
          if (splittedStringList[idx].length > 2 &&
              idx + 1 < splittedStringList.length) {
            splittedStringList[idx + 1] = splittedStringList[idx].substring(2) +
                splittedStringList[idx + 1];
            splittedStringList[idx] =
                splittedStringList[idx].replaceRange(2, null, "");
          } else if (splittedStringList[idx].length > 2) {
            splittedStringList.add(splittedStringList[idx].substring(2));
          }
        }
        for (int idx = 0; idx < splittedStringList.length; ++idx) {
          if (splittedStringList[idx].isEmpty) continue;
          if (splittedStringList[idx].length < 2) {
            if (idx < splittedStringList.length - 1) {
              formattedString += "${splittedStringList[idx].toUpperCase()} ";
            } else {
              formattedString += splittedStringList[idx].toUpperCase();
            }
          } else {
            formattedString += "${splittedStringList[idx].toUpperCase()} ";
          }
        }
        _txEditingController.text = formattedString;
        break;
      case TXDataType.decimal:
        break;
      case TXDataType.binary:
        if (newValue.length < previousTransmitString.length) {
          previousTransmitString = _txEditingController.text;
          return;
        }
        if (newValue.characters.last != "1" &&
            newValue.characters.last != "0" &&
            newValue.characters.last != " ") {
          _txEditingController.text =
              newValue.substring(0, newValue.length - 1);
          _txEditingController.selection =
              TextSelection.collapsed(offset: _txEditingController.text.length);
          return;
        }
        String formattedString = "";
        List<String> splittedStringList = newValue.split(" ");
        if (newValue.characters.last == " ") {
          splittedStringList.last += " ";
        }
        for (int idx = 0; idx < splittedStringList.length; ++idx) {
          if (splittedStringList[idx].isEmpty) continue;
          if (splittedStringList[idx].length > 8 &&
              idx + 1 < splittedStringList.length) {
            splittedStringList[idx + 1] = splittedStringList[idx].substring(8) +
                splittedStringList[idx + 1];
            splittedStringList[idx] =
                splittedStringList[idx].replaceRange(8, null, "");
          } else if (splittedStringList[idx].length > 8) {
            splittedStringList.add(splittedStringList[idx].substring(8));
          }
        }
        for (int idx = 0; idx < splittedStringList.length; ++idx) {
          if (splittedStringList[idx].isEmpty) continue;
          if (splittedStringList[idx].length < 8) {
            if (idx < splittedStringList.length - 1) {
              formattedString += "${splittedStringList[idx].toUpperCase()} ";
            } else {
              formattedString += splittedStringList[idx].toUpperCase();
            }
          } else {
            formattedString += "${splittedStringList[idx].toUpperCase()} ";
          }
        }
        _txEditingController.text = formattedString;
        break;
    }
    _txEditingController.selection = TextSelection.collapsed(
        offset:
            cursorAtEnd ? _txEditingController.text.length : currentPosition);
    previousTransmitString = _txEditingController.text;
    notifyListeners();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _serialSearchTimer.cancel();
    }
    _serialService.dispose();
    rxGridViewController.removeListener(rxListener);
    txGridViewController.removeListener(txListener);
    rxGridViewController.dispose();
    txGridViewController.dispose();
    _txEditingController.dispose();
    super.dispose();
  }

  void _serialSearchTimerCallback(Timer timer) {
    if (_serialService.fetchPortList()) {
      notifyListeners();
    }
  }

  void serialPortConnect() {
    if (_serialService.connect(_selectedBaudrate, _selectedDataBits,
        _selectedParity, _selectedStopBits, _ctsFlowControl)) {
      _serialService.reader?.listen((data) {
        _serialDataReceivedHandler(data);
      });
      notifyListeners();
    }
  }

  void _serialDataReceivedHandler(Uint8List incomingBytes) async {
    _rxData += incomingBytes.length;
    _convertUsecase.convertCharacter(incomingBytes).listen(
      (event) {
        rxDataList.add(event);
        if (_rxAutoScroll && rxScrollController.hasClients) {
          rxScrollController
              .jumpTo(rxScrollController.position.maxScrollExtent);
        }
      },
      onDone: () => notifyListeners(),
    );
    // notifyListeners();
  }

  void serialDataTransmitHandler(String transmittableString) {
    List<int> dataToWrite = [];
    switch (_txDataType) {
      case TXDataType.ascii:
        _convertUsecase
            .convertCharacter(transmittableString.codeUnits)
            .listen((event) {
          txDataList.add(event);
          if (_txAutoScroll && txScrollController.hasClients) {
            txScrollController
                .jumpTo(txScrollController.position.maxScrollExtent);
          }
          notifyListeners();
        }).onDone(() {
          dataToWrite = transmittableString.codeUnits.toList();
          switch (_selectedtxOnEnter) {
            case TxOnEnter.none:
              break;
            case TxOnEnter.stxetx:
              List<int> arr = txEnterList[_selectedtxOnEnter]!;
              BitwiseConvert converter = BitwiseConvert();
              BitwiseConverterEntity convertedEntity =
                  converter.convertFromDecimal(arr.first.toRadixString(10));
              txDataList.insert(
                  0,
                  StreamDataEntity(
                      convertedEntity.ascii,
                      convertedEntity.binary,
                      convertedEntity.decimal,
                      convertedEntity.hex));
              dataToWrite.insert(0, arr.first);
              convertedEntity =
                  converter.convertFromDecimal(arr.last.toRadixString(10));
              txDataList.add(StreamDataEntity(
                  convertedEntity.ascii,
                  convertedEntity.binary,
                  convertedEntity.decimal,
                  convertedEntity.hex));
              dataToWrite.add(arr.last);
              break;
            default:
              for (var element in txEnterList[_selectedtxOnEnter]!) {
                BitwiseConvert converter = BitwiseConvert();
                BitwiseConverterEntity convertedEntity =
                    converter.convertFromDecimal(element.toRadixString(10));
                String asciiValue = "";
                switch (int.parse(convertedEntity.hex, radix: 16)) {
                  case 0x0A:
                    asciiValue = "\\n";
                    break;
                  case 0x0D:
                    asciiValue = "\\r";
                    break;
                  case 0x00:
                    asciiValue = "\\0";
                    break;
                  default:
                    asciiValue = convertedEntity.ascii;
                    break;
                }
                txDataList.add(StreamDataEntity(
                    asciiValue,
                    convertedEntity.binary,
                    convertedEntity.decimal,
                    convertedEntity.hex));
              }
              _txData += txDataList.length;
              dataToWrite.addAll(txEnterList[_selectedtxOnEnter]!);
              break;
          }
          _serialService.write(Uint8List.fromList(dataToWrite));
        });
        break;
      case TXDataType.binary:
        List<String> splittedStringList = transmittableString.split(" ");
        _txData += splittedStringList.length;
        splittedStringList.forEach((element) {
          if (element.isNotEmpty) {
            dataToWrite.add(int.parse(element, radix: 2));
            BitwiseConvert converter = BitwiseConvert();
            BitwiseConverterEntity convertedEntity =
                converter.convertFromBinary(element);
            txDataList.add(StreamDataEntity(
                convertedEntity.ascii,
                convertedEntity.binary,
                convertedEntity.decimal,
                convertedEntity.hex));
            if (_txAutoScroll && txScrollController.hasClients) {
              txScrollController
                  .jumpTo(txScrollController.position.maxScrollExtent);
            }
          }
        });
        switch (_selectedtxOnEnter) {
          case TxOnEnter.none:
            break;
          case TxOnEnter.stxetx:
            List<int> arr = txEnterList[_selectedtxOnEnter]!;
            BitwiseConvert converter = BitwiseConvert();
            BitwiseConverterEntity convertedEntity =
                converter.convertFromDecimal(arr.first.toRadixString(10));
            txDataList.insert(
                0,
                StreamDataEntity(convertedEntity.ascii, convertedEntity.binary,
                    convertedEntity.decimal, convertedEntity.hex));
            dataToWrite.insert(0, arr.first);
            convertedEntity =
                converter.convertFromDecimal(arr.last.toRadixString(10));
            txDataList.add(StreamDataEntity(
                convertedEntity.ascii,
                convertedEntity.binary,
                convertedEntity.decimal,
                convertedEntity.hex));
            dataToWrite.add(arr.last);
            break;
          default:
            for (var element in txEnterList[_selectedtxOnEnter]!) {
              BitwiseConvert converter = BitwiseConvert();
              BitwiseConverterEntity convertedEntity =
                  converter.convertFromBinary(element.toRadixString(2));
              String asciiValue = "";
              switch (int.parse(convertedEntity.hex, radix: 16)) {
                case 0x0A:
                  asciiValue = "\\n";
                  break;
                case 0x0D:
                  asciiValue = "\\r";
                  break;
                case 0x00:
                  asciiValue = "\\0";
                  break;
                default:
                  asciiValue = convertedEntity.ascii;
                  break;
              }
              txDataList.add(StreamDataEntity(
                  asciiValue,
                  convertedEntity.binary,
                  convertedEntity.decimal,
                  convertedEntity.hex));
            }
            _txData += txDataList.length;
            dataToWrite.addAll(txEnterList[_selectedtxOnEnter]!);
            break;
        }
        _serialService.write(Uint8List.fromList(dataToWrite));
        break;
      case TXDataType.hex:
        List<String> splittedStringList = transmittableString.split(" ");

        splittedStringList.forEach((element) {
          if (element.isNotEmpty) {
            dataToWrite.add(int.parse(element, radix: 16));
            BitwiseConvert converter = BitwiseConvert();
            BitwiseConverterEntity convertedEntity =
                converter.convertFromHex(element);
            txDataList.add(StreamDataEntity(
                convertedEntity.ascii,
                convertedEntity.binary,
                convertedEntity.decimal,
                convertedEntity.hex));
            if (_txAutoScroll && txScrollController.hasClients) {
              txScrollController
                  .jumpTo(txScrollController.position.maxScrollExtent);
            }
          }
        });
        switch (_selectedtxOnEnter) {
          case TxOnEnter.none:
            break;
          case TxOnEnter.stxetx:
            List<int> arr = txEnterList[_selectedtxOnEnter]!;
            BitwiseConvert converter = BitwiseConvert();
            BitwiseConverterEntity convertedEntity =
                converter.convertFromDecimal(arr.first.toRadixString(10));
            txDataList.insert(
                0,
                StreamDataEntity(convertedEntity.ascii, convertedEntity.binary,
                    convertedEntity.decimal, convertedEntity.hex));
            dataToWrite.insert(0, arr.first);
            convertedEntity =
                converter.convertFromDecimal(arr.last.toRadixString(10));
            txDataList.add(StreamDataEntity(
                convertedEntity.ascii,
                convertedEntity.binary,
                convertedEntity.decimal,
                convertedEntity.hex));
            dataToWrite.add(arr.last);
            break;
          default:
            for (var element in txEnterList[_selectedtxOnEnter]!) {
              BitwiseConvert converter = BitwiseConvert();
              BitwiseConverterEntity convertedEntity =
                  converter.convertFromHex(element.toRadixString(16));
              String asciiValue = "";
              switch (int.parse(convertedEntity.hex, radix: 16)) {
                case 0x0A:
                  asciiValue = "\\n";
                  break;
                case 0x0D:
                  asciiValue = "\\r";
                  break;
                case 0x00:
                  asciiValue = "\\0";
                  break;
                default:
                  asciiValue = convertedEntity.ascii;
                  break;
              }
              txDataList.add(StreamDataEntity(
                  asciiValue,
                  convertedEntity.binary,
                  convertedEntity.decimal,
                  convertedEntity.hex));
            }
            _txData += txDataList.length;
            dataToWrite.addAll(txEnterList[_selectedtxOnEnter]!);
            break;
        }
        _serialService.write(Uint8List.fromList(dataToWrite));
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void serialPortDisconnect() {
    if (_serialService.disconnect()) {
      notifyListeners();
    }
  }

  void selectedSerialPortChanged(value) {
    _serialService.port = value;
    notifyListeners();
  }

  void selectedBaudRateChanged(value) {
    _selectedBaudrate = value;
    _serialService.setBaudrate(value);
    notifyListeners();
  }

  void selectedDataBitsChanged(value) {
    _selectedDataBits = value;
    _serialService.setDatabits(value);
    notifyListeners();
  }

  void selectedStopBitsChanged(value) {
    _selectedStopBits = value;
    _serialService.setStopbits(value);
    notifyListeners();
  }

  void selectedParityChanged(value) {
    _selectedParity = value;
    _serialService.setParity(value);
    notifyListeners();
  }

  void selectedTXonEnterChanged(value) {
    _selectedtxOnEnter = value;
    notifyListeners();
  }

  void resetRXCounter() {
    _rxData = 0;
    notifyListeners();
  }

  void resetTXCounter() {
    _txData = 0;
    notifyListeners();
  }

  void resetRXData() {
    // _rxData = 0;
    rxGridViewController.clear();
    rxDataList.clear();
    notifyListeners();
  }

  void resetTXData() {
    // _txData = 0;
    txGridViewController.clear();
    txDataList.clear();
    notifyListeners();
  }

  T get port => _serialService.port;
  Map<String, dynamic> get portList => _serialService.portList;
  String? get selectedBaudRate => _selectedBaudrate;
  String? get selectedDataBits => _selectedDataBits;
  String? get selectedStopBits => _selectedStopBits;
  String? get selectedParity => _selectedParity;
  TxOnEnter get selectedtxOnEnter => _selectedtxOnEnter;

  TXDataType get txDataType => _txDataType;
  set txDataType(TXDataType newType) {
    _txDataType = newType;
    previousTransmitString = "";
    _txEditingController.clear();
    notifyListeners();
  }

  bool get txAutoScroll => _txAutoScroll;
  set txAutoScroll(bool value) {
    _txAutoScroll = value;
    notifyListeners();
  }

  bool get ctsFlowControl => _ctsFlowControl;
  set ctsFlowControl(value) {
    _ctsFlowControl = value;
    if (_serialService.isConnected) {
      do {
        serialPortDisconnect();
      } while (_serialService.isConnected);
      do {
        serialPortConnect();
      } while (!_serialService.isConnected);
    }
    notifyListeners();
  }

  bool get txAscii => _txAscii;
  set txAscii(bool value) {
    if (!_txBinary && !_txDecimal && !_txHex && !value) {
      return;
    }
    _txAscii = value;
    notifyListeners();
  }

  bool get txBinary => _txBinary;
  set txBinary(bool value) {
    if (!_txAscii && !_txDecimal && !_txHex && !value) {
      return;
    }
    _txBinary = value;
    notifyListeners();
  }

  bool get txDecimal => _txDecimal;
  set txDecimal(bool value) {
    if (!_txBinary && !_txAscii && !_txHex && !value) {
      return;
    }
    _txDecimal = value;
    notifyListeners();
  }

  bool get txHex => _txHex;
  set txHex(bool value) {
    if (!_txBinary && !_txDecimal && !_txAscii && !value) {
      return;
    }
    _txHex = value;
    notifyListeners();
  }

  bool get rxAutoScroll => _rxAutoScroll;
  set rxAutoScroll(bool value) {
    _rxAutoScroll = value;
    notifyListeners();
  }

  bool get rxAscii => _rxAscii;
  set rxAscii(bool value) {
    if (!_rxBinary && !_rxDecimal && !_rxHex && !value) {
      return;
    }
    _rxAscii = value;
    notifyListeners();
  }

  bool get rxBinary => _rxBinary;
  set rxBinary(bool value) {
    if (!_rxAscii && !_rxDecimal && !_rxHex && !value) {
      return;
    }
    _rxBinary = value;
    notifyListeners();
  }

  bool get rxDecimal => _rxDecimal;
  set rxDecimal(bool value) {
    if (!_rxBinary && !_rxAscii && !_rxHex && !value) {
      return;
    }
    _rxDecimal = value;
    notifyListeners();
  }

  bool get rxHex => _rxHex;
  set rxHex(bool value) {
    if (!_rxBinary && !_rxDecimal && !_rxAscii && !value) {
      return;
    }
    _rxHex = value;
    notifyListeners();
  }

  bool isOpen() {
    if (!kIsWeb) {
      return _serialService.port.isOpen;
    }
    return false;
  }

  List<String> get baudrateList => _serialService.baudrateList;
  List<String> get dataBitList => _serialService.dataBitList;
  List<String> get stopBitList => _serialService.stopBitList;
  List<String> get parityList => _serialService.parityList;
  List<TxOnEnter> get txOnEnterList => txEnterList.keys.toList();
  int get rxData => _rxData;
  int get txData => _txData;

  TextEditingController get txEditingController => _txEditingController;
}
