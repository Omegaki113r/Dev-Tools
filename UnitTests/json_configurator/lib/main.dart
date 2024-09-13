import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

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

    for (var element in children) {
      element.parent = this;
    }
  }
  final Key key = GlobalKey();
  final bool isRoot;
  String title;
  bool editing;
  DataType type;
  final List<MyNode> children;
  late MyNode parent;
  TextEditingController nameEditController = TextEditingController();
  set setEditing(bool newValue) {
    editing = newValue;
  }
}

class JsonProvider with ChangeNotifier {
  TreeNode<MyNode> sampleTree = TreeNode.root(data: MyNode(title: " { } "))
    ..addAll(
      [
        TreeNode<MyNode>(key: "0A", data: MyNode(title: "device_name"))
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
    // treeController.breadthFirstSearch(
    //   onTraverse: (node) {
    //     if (node.key == key) {
    //       node.type = newType;
    //     }
    //   },
    // );
    node.data?.type = newType;
    notifyListeners();
  }

  changeEditing(TreeNode<MyNode> node) {
    node.data?.editing = !node.data!.editing;
    if (node.data!.title.isEmpty) {
      node.data?.title = "< NAME >";
    }
    notifyListeners();
  }

  delete(TreeNode<MyNode> node) {
    sampleTree.remove(node);
    notifyListeners();
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
        return TreeView.simple(
          tree: context.watch<JsonProvider>().sampleTree,
          showRootNode: true,
          expansionIndicatorBuilder: (context, node) =>
              ChevronIndicator.rightDown(
            tree: node,
            color: Colors.blue[700],
            padding: const EdgeInsets.all(8),
          ),
          indentation: const Indentation(style: IndentStyle.roundJoint),
          onItemTap: (item) {
            if (kDebugMode) print("Item tapped: ${item.key}");
          },
          onTreeReady: (controller) =>
              context.read<JsonProvider>().treeViewController = controller,
          builder: (context, node) {
            if (node.data == null) {
              print("null");
              return Container();
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
              child: Row(
                children: [
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
                    IconButton(
                      onPressed: () {
                        context.read<JsonProvider>().delete(node);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton<DataType>(
                        value: node.data!.type,
                        items: const [
                          DropdownMenuItem(
                              value: DataType.eSTRING, child: Text("String")),
                          DropdownMenuItem(
                              value: DataType.eNUMBER, child: Text("Number")),
                          DropdownMenuItem(
                              value: DataType.eBOOL, child: Text("Boolean")),
                          DropdownMenuItem(
                              value: DataType.eOBJECT, child: Text("Object")),
                          DropdownMenuItem(
                              value: DataType.eARRAY, child: Text("Array")),
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
                      DataType.eSTRING => Expanded(child: TextField()),
                      DataType.eNUMBER => Expanded(child: TextField()),
                      DataType.eBOOL => Expanded(
                          child: Checkbox(value: true, onChanged: (value) {})),
                      DataType.eOBJECT => Expanded(child: TextField()),
                      DataType.eARRAY => Expanded(child: TextField()),
                    },
                    const SizedBox(
                      width: 20,
                    ),
                  ] else
                    ...[]
                ],
              ),
            );
            // return ListTile(
            //   title: Text("Item ${node.level}-${node.key}"),
            //   subtitle: Text('Level ${node.level}'),
            // );
          },
        );
      },
    );
  }
}
