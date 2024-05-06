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
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:dev_tools/features/data_streamer/domain/entities/stream_data_entitiy.dart';
import 'package:dev_tools/features/data_streamer/domain/usecases/serial_convert_usecase.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  DragSelectGridViewController rxController = DragSelectGridViewController();
  ScrollController txScrollController = ScrollController();
  DragSelectGridViewController txController = DragSelectGridViewController();

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
    rxController.addListener(rxListener);
    txController.addListener(txListener);
  }

  void rxListener() {
    if (kDebugMode) {
      print(rxController.value);
    }
    notifyListeners();
  }

  void txListener() {
    if (kDebugMode) {
      print(txController.value);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _serialSearchTimer.cancel();
    _serialService.dispose();
    rxController.removeListener(rxListener);
    txController.removeListener(txListener);
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

  void _serialDataReceivedHandler(Uint8List incomingBytes) {
    _rxData += incomingBytes.length;
    _convertUsecase.convertCharacter(incomingBytes).listen((event) {
      rxDataList.add(event);
      notifyListeners();
    });
  }

  void serialDataTransmitHandler(String transmittableString) {
    _txData += transmittableString.length;
    _convertUsecase
        .convertCharacter(transmittableString.codeUnits)
        .listen((event) {
      txDataList.add(event);
      notifyListeners();
    });
    List<int> dataToWrite = transmittableString.codeUnits.toList();
    switch (_selectedtxOnEnter) {
      case TxOnEnter.none:
        break;
      case TxOnEnter.stxetx:
        List<int> arr = txEnterList[_selectedtxOnEnter]!;
        dataToWrite.insert(0, arr.first);
        dataToWrite.add(arr.last);
        break;
      default:
        dataToWrite.addAll(txEnterList[_selectedtxOnEnter]!);
        break;
    }
    _serialService.write(Uint8List.fromList(dataToWrite));
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
    rxDataList.clear();
    notifyListeners();
  }

  void resetTXData() {
    // _txData = 0;
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

  bool get txAutoScroll => _txAutoScroll;
  set txAutoScroll(bool value) {
    _txAutoScroll = value;
    notifyListeners();
  }

  bool get ctsFlowControl => _ctsFlowControl;
  set ctsFlowControl(value) {
    _ctsFlowControl = value;
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
}
