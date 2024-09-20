import 'dart:convert';
import 'dart:io';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum DataType { eSTRING, eNUMBER, eBOOL, eOBJECT, eARRAY }

// Create a class to hold your hierarchical data (optional, could be a Map or
// any other data structure that's capable of representing hierarchical data).
class MyNode {
  MyNode(
      {required this.title,
      this.isRoot = false,
      this.type = DataType.eSTRING,
      this.editing = false}) {
    nameEditController.addListener(() {
      title = nameEditController.text;
    });
    stringEditController.addListener(() {
      data = stringEditController.text;
    });
  }
  final bool isRoot;
  String title = "";
  String data = "";
  bool isChecked = false;
  bool editing;
  DataType type;
  late MyNode parent;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController stringEditController = TextEditingController();
  set setEditing(bool newValue) {
    editing = newValue;
  }
}

class JsonProvider with ChangeNotifier {
  TreeNode<MyNode> sampleTree = TreeNode.root(data: MyNode(title: " { } "));
  TreeViewController? treeViewController;

  changeType(TreeNode<MyNode> node, DataType newType) {
    if (newType == DataType.eSTRING ||
        newType == DataType.eNUMBER ||
        newType == DataType.eBOOL) {
      node.clear();
    }
    node.data?.type = newType;
    TreeNode<MyNode> parentNode = node.parent as TreeNode<MyNode>;
    if (parentNode.data!.type == DataType.eARRAY) {
      print("parent is array");
      for (var e in parentNode.childrenAsList) {
        TreeNode<MyNode> element = e as TreeNode<MyNode>;
        element.data!.type = newType;
      }
    }
    notifyListeners();
  }

  changeEditing(TreeNode<MyNode> node) {
    if (kDebugMode) print(sampleTree.childrenAsList.length);
    node.data?.editing = !node.data!.editing;
    if (node.data!.title.isEmpty) {
      node.data?.title = "< NAME >";
    }
    notifyListeners();
  }

  delete(TreeNode<MyNode> node) {
    // node.data!.nameEditController.dispose();
    // node.data!.stringEditController.dispose();
    // sampleTree.remove(node);
    node.delete();
    // sampleTree.remove(node);
    notifyListeners();
  }

  add(TreeNode<MyNode> node) {
    if (node.data!.type == DataType.eARRAY) {
      print("node is array");
      print(node.children.length);
      if (node.children.isNotEmpty) {
        node.add(TreeNode<MyNode>(
            data: MyNode(
                title: "data",
                type: (node.childrenAsList.first as TreeNode<MyNode>)
                    .data!
                    .type)));
      } else {
        node.add(TreeNode<MyNode>(data: MyNode(title: "data")));
      }
    } else {
      node.add(TreeNode<MyNode>(data: MyNode(title: "data")));
    }
    notifyListeners();
  }

  changeBool(TreeNode<MyNode> node, bool newValue) {
    node.data!.isChecked = newValue;
    notifyListeners();
  }

  String generateJSON({TreeNode<MyNode>? node, String jsonString = ""}) {
    node ??= sampleTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) return jsonString;
    for (var element in node.childrenAsList) {
      TreeNode<MyNode> childNode = element as TreeNode<MyNode>;
      switch (childNode.data!.type) {
        case DataType.eSTRING:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title;
            jsonString += "\":";
          }
          jsonString += "\"";
          jsonString += childNode.data!.data;
          jsonString += "\"";
          break;
        case DataType.eNUMBER:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title;
            jsonString += "\":";
          }
          jsonString += childNode.data!.data;
          break;
        case DataType.eBOOL:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\"";
            jsonString += childNode.data!.title;
            jsonString += "\":";
          }
          jsonString += childNode.data!.isChecked.toString();
          break;
        case DataType.eOBJECT:
          if (node.data!.type == DataType.eARRAY) {
            jsonString += "{";
          } else {
            jsonString += "\"";
            jsonString += childNode.data!.title;
            jsonString += "\":{";
          }
          jsonString = generateJSON(node: childNode, jsonString: jsonString);
          if (node.data!.type != DataType.eARRAY) jsonString += "}";
          if (node.data!.type == DataType.eARRAY) jsonString += "}";

          break;
        case DataType.eARRAY:
          jsonString += "\"";
          jsonString += childNode.data!.title;
          jsonString += "\":[";
          jsonString = generateJSON(node: childNode, jsonString: jsonString);
          jsonString += "]";
          break;
      }
      jsonString += ",";
    }
    jsonString = jsonString.substring(0, jsonString.length - 1);
    if (node.isRoot) jsonString += "}";
    if (node.isRoot) if (kDebugMode) print(jsonString);
    return jsonString;
  }

  String generateCString({TreeNode<MyNode>? node, String jsonString = ""}) {
    node ??= sampleTree;
    if (jsonString.isEmpty) jsonString = "{";
    if (node.children.isEmpty) return jsonString;
    for (var element in node.childrenAsList) {
      TreeNode<MyNode> childNode = element as TreeNode<MyNode>;
      switch (childNode.data!.type) {
        case DataType.eSTRING:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title;
            jsonString += "\\\":";
          }
          jsonString += "\\\"";
          jsonString += childNode.data!.data;
          jsonString += "\\\"";
          break;
        case DataType.eNUMBER:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title;
            jsonString += "\\\":";
          }
          jsonString += childNode.data!.data;
          break;
        case DataType.eBOOL:
          if (node.data!.type != DataType.eARRAY) {
            jsonString += "\\\"";
            jsonString += childNode.data!.title;
            jsonString += "\\\":";
          }
          jsonString += childNode.data!.isChecked.toString();
          break;
        case DataType.eOBJECT:
          if (node.data!.type == DataType.eARRAY) {
            jsonString += "{";
          } else {
            jsonString += "\\\"";
            jsonString += childNode.data!.title;
            jsonString += "\\\":{";
          }
          jsonString = generateCString(node: childNode, jsonString: jsonString);
          if (node.data!.type != DataType.eARRAY) jsonString += "}";
          if (node.data!.type == DataType.eARRAY) jsonString += "}";

          break;
        case DataType.eARRAY:
          jsonString += "\\\"";
          jsonString += childNode.data!.title;
          jsonString += "\\\":[";
          jsonString = generateCString(node: childNode, jsonString: jsonString);
          jsonString += "]";
          break;
      }
      jsonString += ",";
    }
    jsonString = jsonString.substring(0, jsonString.length - 1);
    if (node.isRoot) jsonString += "}";
    if (node.isRoot) if (kDebugMode) print(jsonString);
    return jsonString;
  }

  loadJSON() {
    FilePicker.platform.pickFiles().then((value) {
      if (kDebugMode) print("loaded");
      if (value != null) {
        File file = File(value.files.single.path!);
        file.readAsString().then((value) {
          String s = value;
          Map<String, dynamic> data = jsonDecode(s);
          sampleTree.clear();
          TreeNode<MyNode> generatedNodes =
              generateTreeWithMap(data, node: sampleTree);
          sampleTree = generatedNodes;
          notifyListeners();
        });
      }
    });
  }

  TreeNode<MyNode> generateTreeWithList(List<dynamic> data,
      {TreeNode<MyNode>? node}) {
    TreeNode<MyNode> _node =
        node ?? TreeNode.root(data: MyNode(title: " { } "));
    for (var element in data) {
      switch (element.runtimeType) {
        case int:
          if (kDebugMode) print("int");
          var val = MyNode(title: "", type: DataType.eNUMBER);
          val.data = element.toString();
          val.stringEditController.text = element.toString();
          _node.add(TreeNode<MyNode>(data: val));
          break;
        case bool:
          if (kDebugMode) print("bool");
          var val = MyNode(title: "", type: DataType.eBOOL);
          val.isChecked = element;
          _node.add(TreeNode<MyNode>(data: val));
          break;
        case String:
          if (kDebugMode) print("string");
          var val = MyNode(title: "", type: DataType.eSTRING);
          val.data = element;
          val.stringEditController.text = element;
          _node.add(TreeNode<MyNode>(data: val));
          break;
        default:
          if (kDebugMode) print("maybe map");
          TreeNode<MyNode> childNode =
              TreeNode(data: MyNode(title: "", type: DataType.eOBJECT));
          Map<String, dynamic> childMap = element as Map<String, dynamic>;
          childNode = generateTreeWithMap(childMap, node: childNode);
          _node.add(childNode);
          break;
      }
    }
    return _node;
  }

  TreeNode<MyNode> generateTreeWithMap(Map<String, dynamic> data,
      {TreeNode<MyNode>? node}) {
    TreeNode<MyNode> _node =
        node ?? TreeNode.root(data: MyNode(title: " { } "));
    data.forEach((key, value) {
      switch (value.runtimeType) {
        case String:
          if (kDebugMode) print("string");
          var val = MyNode(title: key, type: DataType.eSTRING);
          val.data = value;
          val.stringEditController.text = value;
          _node.add(TreeNode<MyNode>(data: val));
          break;
        case int:
          if (kDebugMode) print("int");
          var val = MyNode(title: key, type: DataType.eNUMBER);
          val.data = value.toString();
          val.stringEditController.text = value.toString();
          _node.add(TreeNode<MyNode>(data: val));
          break;
        case bool:
          if (kDebugMode) print("bool");
          var val = MyNode(title: key, type: DataType.eBOOL);
          val.isChecked = value;
          _node.add(TreeNode<MyNode>(data: val));
          break;
        case List:
          if (kDebugMode) print("List found");
          TreeNode<MyNode> childNode =
              TreeNode(data: MyNode(title: key, type: DataType.eARRAY));
          List<dynamic> childMap = value as List<dynamic>;
          childNode = generateTreeWithList(childMap, node: childNode);
          _node.add(childNode);
          break;
        default:
          if (kDebugMode) print("maybe map");
          TreeNode<MyNode> childNode =
              TreeNode(data: MyNode(title: key, type: DataType.eOBJECT));
          Map<String, dynamic> childMap = value as Map<String, dynamic>;
          childNode = generateTreeWithMap(childMap, node: childNode);
          _node.add(childNode);
          break;
      }
    });
    return _node;
  }
}

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => JsonProvider())
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: MyTreeView(),
          ),
        ),
      ),
    );

class MyTreeView extends StatelessWidget {
  const MyTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JsonProvider>(builder: (context, value, child) {
      return Column(children: [
        Expanded(
          child: TreeView.simple(
            tree: context.read<JsonProvider>().sampleTree,
            // showRootNode: true,
            expansionIndicatorBuilder: (context, node) =>
                NoExpansionIndicator(tree: node),
            //     ChevronIndicator.rightDown(
            //   tree: node,
            //   color: Colors.blue[700],
            //   padding: const EdgeInsets.all(8),
            // ),
            indentation: const Indentation(style: IndentStyle.roundJoint),
            onItemTap: (item) {
              if (kDebugMode) print("Item tapped: ${item.key}");
            },
            onTreeReady: (controller) {
              context.read<JsonProvider>().treeViewController = controller;
              controller.expandAllChildren(controller.tree);
            },
            builder: (context, node) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                child: Row(
                  children: [
                    if (node.data!.type == DataType.eARRAY ||
                        node.data!.type == DataType.eOBJECT ||
                        node.isRoot) ...[
                      SizedBox(
                        width: 50,
                        child: Container(
                          color: Colors.green,
                          child: IconButton(
                            onPressed: () => value.add(node),
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      const SizedBox(width: 50),
                    ],
                    if (!node.isRoot &&
                        (node.parent as TreeNode<MyNode>).data!.type !=
                            DataType.eARRAY) ...[
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: node.data!.editing
                            ? TextField(
                                controller: node.data!.nameEditController,
                                maxLines: 1,
                                onEditingComplete: () => context
                                    .read<JsonProvider>()
                                    .changeEditing(node))
                            : Text(node.data!.title),
                      ),
                    ],
                    if (!node.isRoot) ...[
                      if ((node.parent as TreeNode<MyNode>).data!.type !=
                          DataType.eARRAY) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<JsonProvider>().changeEditing(node),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<DataType>(
                          value: node.data!.type,
                          items: [
                            const DropdownMenuItem(
                                value: DataType.eSTRING, child: Text("String")),
                            const DropdownMenuItem(
                                value: DataType.eNUMBER, child: Text("Number")),
                            const DropdownMenuItem(
                                value: DataType.eBOOL, child: Text("Boolean")),
                            const DropdownMenuItem(
                                value: DataType.eOBJECT, child: Text("Object")),
                            if ((node.parent as TreeNode<MyNode>).data!.type !=
                                DataType.eARRAY) ...[
                              const DropdownMenuItem(
                                  value: DataType.eARRAY, child: Text("Array"))
                            ]
                          ],
                          onChanged: (val) {
                            context.read<JsonProvider>().changeType(node, val!);
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(" : "),
                      const SizedBox(
                        width: 20,
                      ),
                      switch (node.data!.type) {
                        DataType.eSTRING => Expanded(
                              child: TextField(
                            controller: node.data!.stringEditController,
                          )),
                        DataType.eNUMBER => Expanded(
                              child: TextField(
                            controller: node.data!.stringEditController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+(\.\d*)?')),
                            ],
                          )),
                        DataType.eBOOL => Checkbox(
                            value: node.data!.isChecked,
                            onChanged: (value) => context
                                .read<JsonProvider>()
                                .changeBool(node, value!)),
                        DataType.eOBJECT => Expanded(child: Container()),
                        DataType.eARRAY => Expanded(child: Container()),
                      },
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {
                          context.read<JsonProvider>().delete(node);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text("Load"),
                onPressed: () {
                  context.read<JsonProvider>().loadJSON();
                },
              ),
              TextButton(
                child: const Text("Generate JSON"),
                onPressed: () => context.read<JsonProvider>().generateJSON(),
              ),
              TextButton(
                child: const Text("Generate C String"),
                onPressed: () => context.read<JsonProvider>().generateCString(),
              ),
            ],
          ),
        ),
      ]);
    });
  }
}