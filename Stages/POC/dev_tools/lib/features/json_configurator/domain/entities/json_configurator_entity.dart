/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_entity.dart
 * File Created: Wednesday, 18th September 2024 7:27:59 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Saturday, 21st September 2024 2:06:53 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';
import 'package:flutter/material.dart';

enum JSONNumberType { eDecimal, eHex, eBinary, eOctal }

class JSONConfiguratorEntity {
  JSONDataType dataType;
  String title;
  JSONNumberType numberType;
  BitwiseConverterEntity? numberValue;
  String dataValue;
  bool boolValue;
  bool editing = false;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController stringEditController = TextEditingController();
  JSONConfiguratorEntity(this.dataType,
      {this.title = "",
      this.dataValue = "",
      this.numberValue,
      this.numberType = JSONNumberType.eDecimal,
      this.boolValue = false}) {
    nameEditController.text = title;
  }

  dispose() {
    nameEditController.dispose();
    stringEditController.dispose();
  }
}
