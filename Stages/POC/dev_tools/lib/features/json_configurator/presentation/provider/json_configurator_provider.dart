/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_provider.dart
 * File Created: Wednesday, 18th September 2024 7:00:36 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Thursday, 19th September 2024 12:58:28 pm
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
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/features/json_configurator/domain/entities/json_configurator_entity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JSONConfiguratorProvider with ChangeNotifier {
  TreeNode<JSONConfiguratorEntity> jsonTree = TreeNode.root(
      data: JSONConfiguratorEntity(JSONDataType.eROOT, title: " { } "));
  late TreeViewController treeViewController;

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
          title: "data",
        )));
      } else {
        node.add(TreeNode<JSONConfiguratorEntity>(
            data: JSONConfiguratorEntity(JSONDataType.eSTRING, title: "data")));
      }
    } else {
      node.add(TreeNode<JSONConfiguratorEntity>(
          data: JSONConfiguratorEntity(JSONDataType.eSTRING, title: "data")));
    }
    notifyListeners();
  }

  delete(TreeNode<JSONConfiguratorEntity> node) {
    // node.data!.nameEditController.dispose();
    // node.data!.stringEditController.dispose();
    node.data!.dispose();
    node.clear();
    node.delete();
    notifyListeners();
  }

  changeEditing(TreeNode<JSONConfiguratorEntity> node) {
    if (kDebugMode) print(jsonTree.childrenAsList.length);
    node.data?.editing = !node.data!.editing;
    if (node.data!.title != null && node.data!.title!.isEmpty) {
      node.data?.title = "< NAME >";
    }
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
    notifyListeners();
  }

  changeBool(TreeNode<JSONConfiguratorEntity> node, bool newValue) {
    node.data!.boolValue = newValue;
    notifyListeners();
  }

  loadJSON() {
    FilePicker.platform.pickFiles().then((value) {
      if (kDebugMode) print("loaded");
      if (value != null) {
        File file = File(value.files.single.path!);
        file.readAsString().then((value) {
          String s = value;
          Map<String, dynamic> data = jsonDecode(s);
          jsonTree.clear();
          jsonTree = generateTreeWithMap(data, node: jsonTree);
          notifyListeners();
        });
      }
    });
  }

  String generateJSON(
      {TreeNode<JSONConfiguratorEntity>? node, String jsonString = ""}) {
    node ??= jsonTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) return jsonString;
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
          jsonString += childNode.data!.stringValue;
          jsonString += "\"";
          break;
        case JSONDataType.eNUMBER:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\":";
          }
          jsonString += childNode.data!.numberValue.toString();
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
    if (node.isRoot) if (kDebugMode) print(jsonString);
    return jsonString;
  }

  String generateCString(
      {TreeNode<JSONConfiguratorEntity>? node, String jsonString = ""}) {
    node ??= jsonTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) return jsonString;
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
          jsonString += childNode.data!.stringValue;
          jsonString += "\\\"";
          break;
        case JSONDataType.eNUMBER:
          if (node.data!.dataType != JSONDataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title ?? "";
            jsonString += "\\\":";
          }
          jsonString += childNode.data!.numberValue.toString();
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
    if (node.isRoot) if (kDebugMode) print(jsonString);
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
          val.stringValue = element;
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
          val.stringValue = value;
          val.stringEditController.text = value;
          node.add(TreeNode<JSONConfiguratorEntity>(data: val));
          break;
        case int:
          if (kDebugMode) print("int");
          var val = JSONConfiguratorEntity(JSONDataType.eNUMBER, title: key);
          val.numberValue = value;
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
