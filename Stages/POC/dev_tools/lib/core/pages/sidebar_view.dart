/*
 * Project: Xtronic Dev Tools
 * File Name: sidebar_view.dart
 * File Created: Wednesday, 10th January 2024 5:46:43 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:40 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
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
import 'package:dev_tools/core/widgets/soft_divider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SidebarView extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Axis axis;
  const SidebarView(
    this.axis,
    this.backgroundColor, {
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<SidebarView> createState() => _SidebarState();
}

class _SidebarState extends State<SidebarView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
          ),
          if (widget.axis == Axis.horizontal) ...[
            ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SoftButton(
                  lblBitwiseCalculator,
                  ButtonType.flat,
                  height: 60,
                  width: 150,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 30.0,
                  ),
                  onPressed: () {
                    GoRouter.of(context).go(bitwiseCalculatorRoute);
                  },
                ),
                const SoftDivider(),
                SoftButton(
                  lblDataStreamer,
                  ButtonType.flat,
                  height: 60,
                  width: 150,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 30.0,
                  ),
                  onPressed: () {
                    GoRouter.of(context).go(dataStreamerRoute);
                  },
                ),
                SoftButton(
                  "About",
                  ButtonType.flat,
                  height: 60,
                  width: 150,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 30.0,
                  ),
                  onPressed: () {
                    // GoRouter.of(context).go(dataStreamerRoute);
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('About'),
                          content: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Developed By: 0m3g4ki113r",
                              ),
                              Gap(10),
                              Text(
                                "Version: 0.0.1-alpha",
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ] else ...[
            Column(
              children: [
                SoftButton(
                  lblBitwiseCalculator,
                  ButtonType.flat,
                  height: 60,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 30.0,
                  ),
                  onPressed: () {
                    GoRouter.of(context).go(bitwiseCalculatorRoute);
                  },
                ),
                const SoftDivider(),
                SoftButton(
                  lblDataStreamer,
                  ButtonType.flat,
                  height: 60,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 20.0,
                    right: 30.0,
                  ),
                  onPressed: () {
                    GoRouter.of(context).go(dataStreamerRoute);
                  },
                ),
                const SoftDivider(),
                const Spacer(),
                const Divider(
                  color: color1,
                  indent: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                      left: 20.0,
                      right: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Developed By: 0m3g4ki113r",
                        ),
                        Gap(10),
                        Text(
                          "Version: 0.0.1-alpha",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}
