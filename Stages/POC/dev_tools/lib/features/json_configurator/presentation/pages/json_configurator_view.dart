/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_view.dart
 * File Created: Wednesday, 18th September 2024 6:57:14 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Friday, 20th September 2024 12:03:24 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/json_configurator/domain/entities/json_configurator_entity.dart';
import 'package:dev_tools/features/json_configurator/presentation/provider/json_configurator_provider.dart';
import 'package:flutter/material.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class JSONConfiguratorView extends StatelessWidget {
  const JSONConfiguratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JSONConfiguratorProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          SizedBox(
            height: 85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SoftButton(ButtonType.flat,
                      label: "Load",
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15), onPressed: () {
                    provider.loadJSON();
                  }),
                ),
                Expanded(
                  child: SoftButton(ButtonType.flat,
                      label: "Generate JSON",
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15), onPressed: () {
                    provider.generateJSON();
                  }),
                ),
                Expanded(
                  child: SoftButton(ButtonType.flat,
                      label: "Generate C String",
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15), onPressed: () {
                    provider.generateCString();
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: TreeView.simple(
              tree: provider.jsonTree,
              expansionIndicatorBuilder: (context, node) =>
                  NoExpansionIndicator(tree: node),
              indentation: const Indentation(style: IndentStyle.squareJoint),
              onTreeReady: (controller) =>
                  provider.treeViewController = controller,
              builder: (context, node) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Row(
                    children: [
                      if (node.data!.dataType == JSONDataType.eARRAY ||
                          node.data!.dataType == JSONDataType.eOBJECT ||
                          node.isRoot) ...[
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: SoftButton(ButtonType.emboss,
                              child: const Icon(Icons.add),
                              onPressed: () => provider.add(node)),
                        ),
                      ] else ...[
                        const SizedBox(width: 50, height: 50),
                      ],
                      if (!node.isRoot &&
                          (node.parent as TreeNode<JSONConfiguratorEntity>)
                                  .data!
                                  .dataType !=
                              JSONDataType.eARRAY) ...[
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 150,
                            child: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 200),
                              crossFadeState: node.data!.editing
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Text(node.data!.title),
                              secondChild: SoftTextField(
                                  label: "name",
                                  controller: node.data!.nameEditController,
                                  onEditingComplete: () {
                                    provider.changeEditing(node);
                                  }),
                            )),
                      ],
                      if (!node.isRoot) ...[
                        if ((node.parent as TreeNode<JSONConfiguratorEntity>)
                                .data!
                                .dataType !=
                            JSONDataType.eARRAY) ...[
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () => context
                                .read<JSONConfiguratorProvider>()
                                .changeEditing(node),
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<JSONDataType>(
                            value: node.data!.dataType,
                            items: [
                              const DropdownMenuItem(
                                  value: JSONDataType.eSTRING,
                                  child: Text("String")),
                              const DropdownMenuItem(
                                  value: JSONDataType.eNUMBER,
                                  child: Text("Number")),
                              const DropdownMenuItem(
                                  value: JSONDataType.eBOOL,
                                  child: Text("Boolean")),
                              const DropdownMenuItem(
                                  value: JSONDataType.eOBJECT,
                                  child: Text("Object")),
                              if ((node.parent
                                          as TreeNode<JSONConfiguratorEntity>)
                                      .data!
                                      .dataType !=
                                  JSONDataType.eARRAY) ...[
                                const DropdownMenuItem(
                                    value: JSONDataType.eARRAY,
                                    child: Text("Array"))
                              ]
                            ],
                            onChanged: (val) {
                              context
                                  .read<JSONConfiguratorProvider>()
                                  .changeType(node, val!);
                            }),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(" : "),
                        const SizedBox(
                          width: 20,
                        ),
                        switch (node.data!.dataType) {
                          JSONDataType.eSTRING => Expanded(
                              child: SoftTextField(
                                label: "String",
                                controller: node.data!.stringEditController,
                              ),
                            ),
                          JSONDataType.eNUMBER => Expanded(
                                child: SoftTextField(
                              label: "Number",
                              controller: node.data!.stringEditController,
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+(\.\d*)?')),
                              ],
                            )),
                          JSONDataType.eBOOL => Checkbox(
                              value: node.data!.boolValue,
                              onChanged: (value) =>
                                  provider.changeBool(node, value!)),
                          JSONDataType.eOBJECT => Expanded(child: Container()),
                          JSONDataType.eARRAY => Expanded(child: Container()),
                          JSONDataType.eROOT => Expanded(child: Container()),
                        },
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {
                            provider.delete(node);
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
          )
        ],
      );
    });
  }
}
