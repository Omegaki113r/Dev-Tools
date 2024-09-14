import 'package:animated_tree_view/animated_tree_view.dart';
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
      this.children = const <MyNode>[],
      this.isRoot = false,
      this.type = DataType.eSTRING,
      this.editing = false}) {
    nameEditController.addListener(() {
      title = nameEditController.text;
    });
    stringEditController.addListener(() {
      data = stringEditController.text;
    });

    for (var element in children) {
      element.parent = this;
    }
  }
  final bool isRoot;
  String title = "";
  String data = "";
  bool isChecked = false;
  bool editing;
  DataType type;
  final List<MyNode> children;
  late MyNode parent;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController stringEditController = TextEditingController();
  set setEditing(bool newValue) {
    editing = newValue;
  }
}

class JsonProvider with ChangeNotifier {
  TreeNode<MyNode> sampleTree = TreeNode.root(data: MyNode(title: " { } "))
    ..addAll(
      [
        TreeNode<MyNode>(data: MyNode(title: "device_name"))
        //   ..add(TreeNode<MyNode>(key: "0A1A")),
        // TreeNode<MyNode>(key: "0C")
        //   ..addAll([
        //     TreeNode<MyNode>(key: "0C1A"),
        //     TreeNode<MyNode>(key: "0C1B"),
        //     TreeNode<MyNode>(key: "0C1C")
        //       ..addAll([
        //         TreeNode<MyNode>(key: "0C1C2A")
        //           ..addAll([
        //             TreeNode<MyNode>(key: "0C1C2A3A"),
        //             TreeNode<MyNode>(key: "0C1C2A3B"),
        //             TreeNode<MyNode>(key: "0C1C2A3C"),
        //           ]),
        //       ]),
        //   ]),
        // TreeNode<MyNode>(key: "0D"),
        // TreeNode<MyNode>(key: "0E"),
      ],
    );
  TreeViewController? treeViewController;
  JsonProvider();

  changeType(TreeNode<MyNode> node, DataType newType) {
    if (newType == DataType.eSTRING ||
        newType == DataType.eNUMBER ||
        newType == DataType.eBOOL) {
      node.clear();
    }
    node.data?.type = newType;
    notifyListeners();
  }

  changeEditing(TreeNode<MyNode> node) {
    // print(node.key);
    // print(sampleTree.toString());
    node.data?.editing = !node.data!.editing;
    if (node.data!.title.isEmpty) {
      node.data?.title = "< NAME >";
    }
    notifyListeners();
  }

  delete(TreeNode<MyNode> node) {
    // print(node.key);
    // print(sampleTree.toString());
    node.clear();
    sampleTree.remove(node);
    notifyListeners();
  }

  add(TreeNode<MyNode> node) {
    // print(node.key);
    // print(sampleTree.toString());
    node.add(TreeNode<MyNode>(data: MyNode(title: "data")));
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
          jsonString += "\"";
          jsonString += childNode.data!.title;
          jsonString += "\":\"";
          jsonString += childNode.data!.data;
          jsonString += "\"";
          break;
        case DataType.eNUMBER:
          jsonString += "\"";
          jsonString += childNode.data!.title;
          jsonString += "\":";
          jsonString += childNode.data!.data;
          break;
        case DataType.eBOOL:
          jsonString += "\"";
          jsonString += childNode.data!.title;
          jsonString += "\":";
          jsonString += childNode.data!.isChecked.toString();
          break;
        case DataType.eOBJECT:
          jsonString += "\"";
          jsonString += childNode.data!.title;
          jsonString += "\":{";
          jsonString = generateJSON(node: childNode, jsonString: jsonString);
          jsonString += "}";
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
    if (node.isRoot) print(jsonString);
    return jsonString;
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
    return Consumer<JsonProvider>(
      builder: (context, value, child) {
        return Column(children: [
          Expanded(
            child: TreeView.simple(
              tree: context.watch<JsonProvider>().sampleTree,
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
                if (node.data == null) {
                  print("null");
                  return Container();
                }
                return Padding(
                  padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Row(
                    children: [
                      // if (!node.isRoot) ...[
                      //   IconButton(
                      //     onPressed: () {
                      //       context.read<JsonProvider>().delete(node);
                      //     },
                      //     icon: Icon(Icons.remove),
                      //   ),
                      // ],
                      if (node.data!.type == DataType.eARRAY ||
                          node.data!.type == DataType.eOBJECT ||
                          node.isRoot) ...[
                        SizedBox(
                          width: 50,
                          child: Container(
                            color: Colors.green,
                            child: IconButton(
                              onPressed: () =>
                                  context.read<JsonProvider>().add(node),
                              icon: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        SizedBox(width: 50),
                      ],
                      SizedBox(width: 10),
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
                      if (!node.isRoot) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<JsonProvider>().changeEditing(node),
                          icon: Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<DataType>(
                            value: node.data!.type,
                            items: const [
                              DropdownMenuItem(
                                  value: DataType.eSTRING,
                                  child: Text("String")),
                              DropdownMenuItem(
                                  value: DataType.eNUMBER,
                                  child: Text("Number")),
                              DropdownMenuItem(
                                  value: DataType.eBOOL,
                                  child: Text("Boolean")),
                              DropdownMenuItem(
                                  value: DataType.eOBJECT,
                                  child: Text("Object")),
                              DropdownMenuItem(
                                  value: DataType.eARRAY, child: Text("Array")),
                            ],
                            onChanged: (val) {
                              context
                                  .read<JsonProvider>()
                                  .changeType(node, val!);
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                        IconButton(
                          onPressed: () {
                            context.read<JsonProvider>().delete(node);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ]
                    ],
                  ),
                );
                // return ListTile(
                //   title: Text("Item ${node.level}-${node.key}"),
                //   subtitle: Text('Level ${node.level}'),
                // );
              },
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: TextButton(
              child: Text("Generate"),
              onPressed: () => context.read<JsonProvider>().generateJSON(),
            ),
          ),
        ]);
      },
    );
  }
}
