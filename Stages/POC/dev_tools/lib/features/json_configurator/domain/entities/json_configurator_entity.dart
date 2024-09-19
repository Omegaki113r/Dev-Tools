/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_entity.dart
 * File Created: Wednesday, 18th September 2024 7:27:59 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Thursday, 19th September 2024 11:39:54 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class JSONConfiguratorEntity {
  JSONDataType dataType;
  String title;
  String stringValue;
  int numberValue;
  bool boolValue;
  bool editing = false;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController stringEditController = TextEditingController();
  JSONConfiguratorEntity(this.dataType,
      {this.title = "",
      this.stringValue = "",
      this.numberValue = 0,
      this.boolValue = false}) {
    nameEditController.text = title;
    nameEditController.addListener(nameEditControllerListenHandler);
    stringEditController.addListener(stringEditControllerListenHandler);
  }

  nameEditControllerListenHandler() {
    title = nameEditController.text;
  }

  stringEditControllerListenHandler() {
    if (dataType == JSONDataType.eSTRING)
      stringValue = stringEditController.text;
    if (dataType == JSONDataType.eNUMBER)
      numberValue = int.tryParse(stringEditController.text) ?? 0;
  }

  dispose() {
    nameEditController.removeListener(nameEditControllerListenHandler);
    stringEditController.removeListener(stringEditControllerListenHandler);
    nameEditController.dispose();
    stringEditController.dispose();
  }
}
