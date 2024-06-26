/*
 * Project: Xtronic Dev Tools
 * File Name: application_view.dart
 * File Created: Wednesday, 3rd January 2024 8:26:32 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:35 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/pages/main_view.dart';
import 'package:dev_tools/core/pages/sidebar_view.dart';
import 'package:flutter/material.dart';

class ApplicationView extends StatelessWidget {
  final Widget child;
  const ApplicationView(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            children: [
              MainView(
                borderBottom: true,
                child: child,
              ),
              SidebarView(Axis.horizontal, color6.withOpacity(0.9),
                  height: 100),
            ],
          );
        }
        return Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: SidebarView(
                Axis.vertical,
                color6.withOpacity(0.9),
                width: constraints.maxWidth * 0.3,
              ),
            ),
            MainView(
              borderBottom: false,
              child: child,
            ),
          ],
        );
      }),
    );
  }
}
