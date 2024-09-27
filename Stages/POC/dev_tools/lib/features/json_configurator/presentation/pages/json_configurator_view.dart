/* 
 * Project: Xtronic Dev Tools
 * File Name: json_configurator_view.dart
 * File Created: Wednesday, 18th September 2024 6:57:14 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Sunday, 22nd September 2024 5:28:03 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:dev_tools/features/json_configurator/presentation/provider/json_configurator_provider.dart';
import 'package:dev_tools/features/json_configurator/presentation/widgets/json_node_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class JSONConfiguratorView extends StatelessWidget {
  const JSONConfiguratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JSONConfiguratorProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Tooltip(
                  message: msgLoadJSONFromFile,
                  waitDuration: tooltipWaitDuration,
                  child: SoftButton(ButtonType.flat,
                      label: lblLoad,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.folder_open_sharp,
                        color: color1,
                      ), onPressed: () {
                    provider.loadJSON();
                  }),
                ),
                const Gap(20),
                Tooltip(
                  message: msgCopyToClipboard,
                  waitDuration: tooltipWaitDuration,
                  child: SoftButton(ButtonType.flat,
                      label: lblCopy,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.copy,
                        color: color1,
                      ), onPressed: () {
                    provider.copyJSON();
                    toastification.show(
                        context: context,
                        type: ToastificationType.info,
                        style: ToastificationStyle.flat,
                        alignment: Alignment.bottomCenter,
                        autoCloseDuration: const Duration(seconds: 2),
                        backgroundColor: color6,
                        showProgressBar: false,
                        showIcon: false,
                        borderSide: const BorderSide(color: color1, width: 0.5),
                        description: const Text(
                          lblCopiedToClipboard,
                          style: TextStyle(color: color2),
                        ));
                  }),
                ),
                const Gap(20),
                Expanded(
                  child: SoftText(
                      provider.currentType == JSONStringType.eJSON
                          ? provider.jsonString
                          : provider.jsonCString,
                      label: provider.currentType == JSONStringType.eJSON
                          ? lblJSONString
                          : lblCJSONString,
                      maxLines: 1,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 15),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20)),
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            lblJSONString,
                            style: TextStyle(color: color2, fontSize: 12),
                          ),
                          leading: Radio<JSONStringType>(
                            value: JSONStringType.eJSON,
                            groupValue: provider.currentType,
                            onChanged: (jsonType) {
                              provider.changeJSONStringType(jsonType!);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            lblCJSONString,
                            style: TextStyle(color: color2, fontSize: 12),
                          ),
                          leading: Radio<JSONStringType>(
                              value: JSONStringType.eCJSON,
                              groupValue: provider.currentType,
                              onChanged: (jsonType) {
                                provider.changeJSONStringType(jsonType!);
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white54,
          ),
          Expanded(
            child: TreeView.simple(
              tree: provider.jsonTree,
              expansionBehavior: ExpansionBehavior.scrollToLastChild,
              expansionIndicatorBuilder: (context, node) =>
                  NoExpansionIndicator(tree: node),
              indentation: const Indentation(style: IndentStyle.squareJoint),
              onTreeReady: (controller) =>
                  provider.treeViewController = controller,
              builder: (context, node) {
                return JSONNode(node);
              },
            ),
          )
        ],
      );
    });
  }
}
