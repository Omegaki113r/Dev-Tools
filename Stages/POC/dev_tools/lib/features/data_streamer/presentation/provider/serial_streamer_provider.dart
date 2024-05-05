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

class SerialStreamerProvider<T> with ChangeNotifier {
  List<String> serialData = [];

  String _selectedBaudrate = "115200";
  String _selectedDataBits = "8";
  String _selectedStopBits = "1";
  String _selectedParity = "None";
  String _selectedtxOnEnter = "None";

  int _rxData = 0;
  int _txData = 0;
  List<StreamDataEntity> rxDataList = [];
  List<StreamDataEntity> txDataList = [];
  ScrollController rxScrollController = ScrollController();
  DragSelectGridViewController rxController = DragSelectGridViewController();
  ScrollController txScrollController = ScrollController();
  DragSelectGridViewController txController = DragSelectGridViewController();

  bool _autoScroll = true;
  bool _ctsFlowControl = false;
  bool _ascii = true;
  bool _binary = false;
  bool _decimal = false;
  bool _hex = false;

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
    if (_serialService.connect()) {
      _serialService.setBaudrate(_selectedBaudrate);
      _serialService.setDatabits(_selectedDataBits);
      _serialService.setParity(_selectedParity);
      _serialService.setStopbits(_selectedStopBits);
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
    // _serialService.setParity(value);
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
    _rxData = 0;
    rxDataList.clear();
    notifyListeners();
  }

  void resetTXData() {
    _txData = 0;
    txDataList.clear();
    notifyListeners();
  }

  T get port => _serialService.port;
  Map<String, dynamic> get portList => _serialService.portList;
  String? get selectedBaudRate => _selectedBaudrate;
  String? get selectedDataBits => _selectedDataBits;
  String? get selectedStopBits => _selectedStopBits;
  String? get selectedParity => _selectedParity;
  String? get selectedtxOnEnter => _selectedtxOnEnter;

  bool get autoScroll => _autoScroll;

  set autoScroll(bool value) {
    _autoScroll = value;
    notifyListeners();
  }

  bool get ctsFlowControl => _ctsFlowControl;
  set ctsFlowControl(value) {
    _ctsFlowControl = value;
    notifyListeners();
  }

  bool get ascii => _ascii;
  set ascii(bool value) {
    if (!_binary && !_decimal && !_hex && !value) {
      return;
    }
    _ascii = value;
    notifyListeners();
  }

  bool get binary => _binary;
  set binary(bool value) {
    if (!_ascii && !_decimal && !_hex && !value) {
      return;
    }
    _binary = value;
    notifyListeners();
  }

  bool get decimal => _decimal;

  set decimal(bool value) {
    if (!_binary && !_ascii && !_hex && !value) {
      return;
    }
    _decimal = value;
    notifyListeners();
  }

  bool get hex => _hex;
  set hex(bool value) {
    if (!_binary && !_decimal && !_ascii && !value) {
      return;
    }
    _hex = value;
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
  List<String> get txOnEnterList => _serialService.txOnEnterList;
  int get rxData => _rxData;
  int get txData => _txData;
}
