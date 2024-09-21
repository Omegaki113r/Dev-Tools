/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_provider.dart
 * File Created: Wednesday, 18th September 2024 7:00:36 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Saturday, 21st September 2024 4:22:51 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'dart:convert';
import 'dart:io';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/entities/bitwise_converter_entity.dart';
import 'package:dev_tools/features/bitwise_calculator/domain/usecases/bitwise_convert_usecase.dart';
import 'package:dev_tools/features/json_configurator/domain/entities/json_configurator_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toastification/toastification.dart';

enum JSONStringType { eJSON, eCJSON }

class JSONConfiguratorProvider with ChangeNotifier {
  TreeNode<JSONConfiguratorEntity> jsonTree = TreeNode.root(
      data: JSONConfiguratorEntity(JSONDataType.eROOT, title: lblJSONRoot));
  late TreeViewController treeViewController;
  JSONStringType currentType = JSONStringType.eJSON;
  String jsonString = "";
  String jsonCString = "";

  add(TreeNode<JSONConfiguratorEntity> node) {
    if (node.data!.dataType == JSONDataType.eARRAY) {
      if (kDebugMode) {
        print("node is array");
        print(node.children.length);
      }
      if (node.children.isNotEmpty) {
        node.add(TreeNode<JSONConfiguratorEntity>(
            data: JSONConfiguratorEntity(
          (node.childrenAsList.first as TreeNode<JSONConfiguratorEntity>)
              .data!
              .dataType,
          title: lblData,
        )));
      } else {
        node.add(TreeNode<JSONConfiguratorEntity>(
            data:
                JSONConfiguratorEntity(JSONDataType.eSTRING, title: lblData)));
      }
    } else {
      node.add(TreeNode<JSONConfiguratorEntity>(
          data: JSONConfiguratorEntity(JSONDataType.eSTRING, title: lblData)));
    }
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  delete(TreeNode<JSONConfiguratorEntity> node) {
    // node.data!.nameEditController.dispose();
    // node.data!.stringEditController.dispose();
    node.data!.dispose();
    node.clear();
    if (!node.isRoot) {
      node.delete();
    }
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  changeEditing(TreeNode<JSONConfiguratorEntity> node) {
    if (kDebugMode) print(jsonTree.childrenAsList.length);
    node.data?.editing = !node.data!.editing;
    if (node.data!.title != null && node.data!.title!.isEmpty) {
      node.data?.title = lblData;
    }
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  changeType(TreeNode<JSONConfiguratorEntity> node, JSONDataType newType) {
    if (newType == JSONDataType.eSTRING ||
        newType == JSONDataType.eNUMBER ||
        newType == JSONDataType.eBOOL) {
      node.clear();
    }
    node.data?.dataType = newType;
    TreeNode<JSONConfiguratorEntity> parentNode =
        node.parent as TreeNode<JSONConfiguratorEntity>;
    if (parentNode.data!.dataType == JSONDataType.eARRAY) {
      print("parent is array");
      for (var e in parentNode.childrenAsList) {
        TreeNode<JSONConfiguratorEntity> element =
            e as TreeNode<JSONConfiguratorEntity>;
        element.data!.dataType = newType;
      }
    }
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  changeBool(TreeNode<JSONConfiguratorEntity> node, bool newValue) {
    node.data!.boolValue = newValue;
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  onTitleChanged(TreeNode<JSONConfiguratorEntity> node, String newData) {
    node.data!.title = newData;
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  onDataChanged(TreeNode<JSONConfiguratorEntity> node, String newData) {
    if (newData.contains(".")) {
      toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 2),
          backgroundColor: color6,
          showProgressBar: false,
          showIcon: false,
          borderSide: const BorderSide(color: color1, width: 0.5),
          description: const Text(
            lblFloatingPointsNotYetSupported,
            style: TextStyle(color: color2),
          ));
    }
    if (node.data!.dataType == JSONDataType.eNUMBER) {
      BitwiseConvert converter = BitwiseConvert();
      if (newData.isEmpty) {
        newData = node.data!.dataValue;
      }
      switch (node.data!.numberType) {
        case JSONNumberType.eBinary:
          node.data!.numberValue = converter.convertFromBinary(newData);
          node.data!.stringEditController.text = node.data!.numberValue!.binary;
          break;
        case JSONNumberType.eOctal:
          node.data!.numberValue = converter.convertFromOctal(newData);
          node.data!.stringEditController.text = node.data!.numberValue!.octal;
          break;
        case JSONNumberType.eDecimal:
          node.data!.numberValue = converter.convertFromDecimal(newData);
          node.data!.stringEditController.text =
              node.data!.numberValue!.decimal;
          break;
        case JSONNumberType.eHex:
          node.data!.numberValue = converter.convertFromHex(newData);
          node.data!.stringEditController.text = node.data!.numberValue!.hex;
          break;
      }
    } else {
      node.data!.dataValue = newData;
    }
    jsonString = generateJSON();
    jsonCString = generateCString();
    notifyListeners();
  }

  changeJSONStringType(JSONStringType type) {
    currentType = type;
    notifyListeners();
  }

  numberTypeChanged(
      TreeNode<JSONConfiguratorEntity> node, JSONNumberType type) {
    node.data!.numberType = type;
    BitwiseConvert converter = BitwiseConvert();
    switch (node.data!.numberType) {
      case JSONNumberType.eBinary:
        node.data!.numberValue = converter
            .convertFromDecimal(node.data!.numberValue?.decimal ?? "0");
        node.data!.stringEditController.text = node.data!.numberValue!.binary;
        break;
      case JSONNumberType.eOctal:
        node.data!.numberValue = converter
            .convertFromDecimal(node.data!.numberValue?.decimal ?? "0");
        node.data!.stringEditController.text = node.data!.numberValue!.octal;
        break;
      case JSONNumberType.eDecimal:
        node.data!.numberValue = converter
            .convertFromDecimal(node.data!.numberValue?.decimal ?? "0");
        node.data!.stringEditController.text = node.data!.numberValue!.decimal;
        break;
      case JSONNumberType.eHex:
        node.data!.numberValue = converter
            .convertFromDecimal(node.data!.numberValue?.decimal ?? "0");
        node.data!.stringEditController.text = node.data!.numberValue!.hex;
        break;
    }
    // node.data!.stringValue = node.data!.stringEditController.text;

    notifyListeners();
  }

  toggleExpansion(TreeNode<JSONConfiguratorEntity> node) {
    treeViewController.toggleExpansion(node);
    notifyListeners();
  }

  loadJSON() {
    FilePicker.platform.pickFiles().then((value) {
      if (kDebugMode) print("loaded");
      if (value != null) {
        String dataRead = "";
        if (kIsWeb) {
          dataRead = String.fromCharCodes(value.files.single.bytes!);
        } else {
          File file = File(value.files.single.path!);
          dataRead = file.readAsStringSync();
        }
        Map<String, dynamic> data = jsonDecode(dataRead);
        jsonTree.clear();
        jsonTree = generateTreeWithMap(data, node: jsonTree);
        jsonString = generateJSON();
        jsonCString = generateCString();
        notifyListeners();
      }
    });
  }

  saveJSON() {}

  copyJSON() async {
    await Clipboard.setData(ClipboardData(
        text: currentType == JSONStringType.eJSON ? jsonString : jsonCString));
  }

  String generateJSON(
      {TreeNode<JSONConfiguratorEntity>? node, String jsonString = ""}) {
    node ??= jsonTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) {
      if (node.isRoot) {
        jsonString += "}";
      }
      return jsonString;
    }
    for (var element in node.childrenAsList) {
      TreeNode<JSONConfiguratorEntity> childNode =
          element as TreeNode<JSONConfiguratorEntity>;
      switch (childNode.data!.dataType) {
        case JSONDataType.eSTRING:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\":";
          }
          jsonString += "\"";
          jsonString += childNode.data!.dataValue;
          jsonString += "\"";
          break;
        case JSONDataType.eNUMBER:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\":";
          }
          jsonString += childNode.data!.numberValue?.decimal ?? "0";
          break;
        case JSONDataType.eBOOL:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\":";
          }
          jsonString += childNode.data!.boolValue.toString();
          break;
        case JSONDataType.eOBJECT:
          if (node.data!.dataType == JSONDataType.eARRAY) {
            jsonString += "{";
          } else {
            jsonString += "\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\":{";
          }
          jsonString = generateJSON(node: childNode, jsonString: jsonString);
          if (node.data!.dataType != JSONDataType.eARRAY) jsonString += "}";
          if (node.data!.dataType == JSONDataType.eARRAY) jsonString += "}";

          break;
        case JSONDataType.eARRAY:
          jsonString += "\"";
          jsonString += childNode.data!.title ?? "";
          jsonString += "\":[";
          jsonString = generateJSON(node: childNode, jsonString: jsonString);
          jsonString += "]";
          break;
        default:
          print("default");
          break;
      }
      jsonString += ",";
    }
    jsonString = jsonString.substring(0, jsonString.length - 1);
    if (node.isRoot) jsonString += "}";
    return jsonString;
  }

  String generateCString(
      {TreeNode<JSONConfiguratorEntity>? node, String jsonString = ""}) {
    node ??= jsonTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) {
      if (node.isRoot) {
        jsonString += "}";
      }
      return jsonString;
    }
    for (var element in node.childrenAsList) {
      TreeNode<JSONConfiguratorEntity> childNode =
          element as TreeNode<JSONConfiguratorEntity>;
      switch (childNode.data!.dataType) {
        case JSONDataType.eSTRING:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\\\":";
          }
          jsonString += "\\\"";
          jsonString += childNode.data!.dataValue;
          jsonString += "\\\"";
          break;
        case JSONDataType.eNUMBER:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\\\":";
          }
          jsonString += childNode.data!.numberValue?.decimal ?? "";
          break;
        case JSONDataType.eBOOL:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\\\":";
          }
          jsonString += childNode.data!.boolValue.toString();
          break;
        case JSONDataType.eOBJECT:
          if (node.data!.dataType == JSONDataType.eARRAY) {
            jsonString += "{";
          } else {
            jsonString += "\\\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\\\":{";
          }
          jsonString = generateCString(node: childNode, jsonString: jsonString);
          if (node.data!.dataType != JSONDataType.eARRAY) jsonString += "}";
          if (node.data!.dataType == JSONDataType.eARRAY) jsonString += "}";
          break;
        case JSONDataType.eARRAY:
          jsonString += "\\\"";
          jsonString += childNode.data!.title ?? "";
          jsonString += "\\\":[";
          jsonString = generateCString(node: childNode, jsonString: jsonString);
          jsonString += "]";
          break;
        default:
          print("default");
          break;
      }
      jsonString += ",";
    }
    jsonString = jsonString.substring(0, jsonString.length - 1);
    if (node.isRoot) jsonString += "}";
    return jsonString;
  }

  TreeNode<JSONConfiguratorEntity> generateTreeWithList(List<dynamic> data,
      {required TreeNode<JSONConfiguratorEntity> node}) {
    for (var element in data) {
      switch (element.runtimeType) {
        case int:
          if (kDebugMode) print("int");
          var val = JSONConfiguratorEntity(JSONDataType.eNUMBER);
          val.numberValue = element;
          val.stringEditController.text = element.toString();
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case bool:
          if (kDebugMode) print("bool");
          var val = JSONConfiguratorEntity(JSONDataType.eBOOL);
          val.boolValue = element;
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case String:
          if (kDebugMode) print("string");
          var val = JSONConfiguratorEntity(JSONDataType.eSTRING);
          val.dataValue = element;
          val.stringEditController.text = element;
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        default:
          if (kDebugMode) print("maybe map");
          TreeNode<JSONConfiguratorEntity> childNode =
              TreeNode(data: JSONConfiguratorEntity(JSONDataType.eOBJECT));
          Map<String, dynamic> childMap = element as Map<String, dynamic>;
          childNode = generateTreeWithMap(childMap, node: childNode);
          node.add(childNode);
          break;
      }
    }
    return node;
  }

  TreeNode<JSONConfiguratorEntity> generateTreeWithMap(
      Map<String, dynamic> data,
      {required TreeNode<JSONConfiguratorEntity> node}) {
    data.forEach((key, value) {
      switch (value.runtimeType) {
        case String:
          if (kDebugMode) print("string");
          var val = JSONConfiguratorEntity(JSONDataType.eSTRING, title: key);
          val.dataValue = value;
          val.stringEditController.text = value;
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case int:
          if (kDebugMode) print("int");
          var val = JSONConfiguratorEntity(JSONDataType.eNUMBER, title: key);
          BitwiseConvert convert = BitwiseConvert();
          val.numberValue = convert.convertFromDecimal(value.toString());
          // val.numberValue = value;
          val.stringEditController.text = value.toString();
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case bool:
          if (kDebugMode) print("bool");
          var val = JSONConfiguratorEntity(JSONDataType.eBOOL, title: key);
          val.boolValue = value;
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case List:
          if (kDebugMode) print("List found");
          TreeNode<JSONConfiguratorEntity> childNode = TreeNode(
              data: JSONConfiguratorEntity(JSONDataType.eARRAY, title: key));
          List<dynamic> childMap = value as List<dynamic>;
          childNode = generateTreeWithList(childMap, node: childNode);
          node.add(childNode);
          break;
        default:
          if (kDebugMode) print("maybe map");
          TreeNode<JSONConfiguratorEntity> childNode = TreeNode(
              data: JSONConfiguratorEntity(JSONDataType.eOBJECT, title: key));
          Map<String, dynamic> childMap = value as Map<String, dynamic>;
          childNode = generateTreeWithMap(childMap, node: childNode);
          node.add(childNode);
          break;
      }
    });
    return node;
  }
}
