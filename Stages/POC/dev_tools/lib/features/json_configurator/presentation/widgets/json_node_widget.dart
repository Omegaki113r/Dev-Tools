/* 
 * Project: Xtronic Dev Tools
 * File Name: json_node_widget.dart
 * File Created: Friday, 20th September 2024 1:44:22 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Friday, 20th September 2024 10:44:34 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_checkbox.dart';
import 'package:dev_tools/core/widgets/soft_dropdown_button.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/json_configurator/domain/entities/json_configurator_entity.dart';
import 'package:dev_tools/features/json_configurator/presentation/provider/json_configurator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class JSONNode extends StatelessWidget {
  final TreeNode<JSONConfiguratorEntity> node;
  const JSONNode(this.node, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JSONConfiguratorProvider>(
        builder: (context, provider, child) {
      return Container(
        padding: const EdgeInsets.only(left: 10),
        height: 75,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white54, width: 0.25),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (node.data!.dataType == JSONDataType.eARRAY ||
                node.data!.dataType == JSONDataType.eOBJECT) ...[
              SizedBox(
                width: 50,
                height: 50,
                child: SoftButton(ButtonType.convex,
                    child: Icon(
                      node.isExpanded
                          ? Icons.arrow_upward
                          : Icons.arrow_forward,
                      color: color1,
                    ),
                    onPressed: () => provider.toggleExpansion(node)),
              ),
              const SizedBox(width: 10),
            ],
            if (node.data!.dataType == JSONDataType.eARRAY ||
                node.data!.dataType == JSONDataType.eOBJECT ||
                node.isRoot) ...[
              SizedBox(
                width: 50,
                height: 50,
                child: SoftButton(ButtonType.emboss,
                    child: const Icon(Icons.add, color: color1),
                    onPressed: () => provider.add(node)),
              ),
            ] else ...[
              const SizedBox(
                width: 50,
                height: 50,
              ),
            ],
            if (!node.isRoot &&
                (node.parent as TreeNode<JSONConfiguratorEntity>)
                        .data!
                        .dataType !=
                    JSONDataType.eARRAY) ...[
              const SizedBox(width: 10),
              SizedBox(
                  width: 200,
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: node.data!.editing
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Text(node.data!.title),
                    secondChild: SoftTextField(
                        label: lblName,
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
              const Gap(20),
              SoftDropDownButton.flat(
                "",
                lblType,
                width: 200,
                height: 50,
                selectedValue: node.data!.dataType,
                itemList: [
                  const DropdownMenuItem(
                    value: JSONDataType.eSTRING,
                    child: Row(
                      children: [
                        Spacer(),
                        Expanded(child: Text(lblString)),
                      ],
                    ),
                  ),
                  const DropdownMenuItem(
                    value: JSONDataType.eNUMBER,
                    child: Row(
                      children: [
                        Spacer(),
                        Expanded(child: Text(lblNumber)),
                      ],
                    ),
                  ),
                  const DropdownMenuItem(
                    value: JSONDataType.eBOOL,
                    child: Row(
                      children: [
                        Spacer(),
                        Expanded(child: Text(lblBoolean)),
                      ],
                    ),
                  ),
                  const DropdownMenuItem(
                    value: JSONDataType.eOBJECT,
                    child: Row(
                      children: [
                        Spacer(),
                        Expanded(child: Text(lblObject)),
                      ],
                    ),
                  ),
                  if ((node.parent as TreeNode<JSONConfiguratorEntity>)
                          .data!
                          .dataType !=
                      JSONDataType.eARRAY) ...[
                    const DropdownMenuItem(
                      value: JSONDataType.eARRAY,
                      child: Row(
                        children: [
                          Spacer(),
                          Expanded(child: Text(lblArray)),
                        ],
                      ),
                    )
                  ]
                ],
                onChanged: (val) {
                  context
                      .read<JSONConfiguratorProvider>()
                      .changeType(node, val!);
                },
              ),
              const Gap(20),
              const Text(lblJSONSeperator),
              const Gap(20),
              if (node.data!.dataType == JSONDataType.eSTRING) ...[
                Expanded(
                  child: SoftTextField(
                    label: lblString,
                    controller: node.data!.stringEditController,
                    onChanged: (string) {
                      provider.dataChanged(node, string);
                    },
                  ),
                ),
              ] else if (node.data!.dataType == JSONDataType.eNUMBER) ...[
                Expanded(
                    child: SoftTextField(
                  label: lblNumber,
                  controller: node.data!.stringEditController,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatter: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
                  ],
                  onChanged: (string) {
                    provider.dataChanged(node, string);
                  },
                )),
              ] else if (node.data!.dataType == JSONDataType.eBOOL) ...[
                SoftCheckbox("",
                    onChanged: (value) => provider.changeBool(node, value!),
                    value: node.data!.boolValue),
                Expanded(child: Container()),
              ] else if (node.data!.dataType == JSONDataType.eOBJECT) ...[
                Expanded(child: Container())
              ] else if (node.data!.dataType == JSONDataType.eARRAY) ...[
                Expanded(child: Container())
              ],
              const Gap(20),
              SoftButton(ButtonType.convex,
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                provider.delete(node);
              }),
              const Gap(20),
            ],
          ],
        ),
      );
    });
  }
}
