/*
 * Project: Xtronic Dev Tools
 * File Name: soft_tab.dart
 * File Created: Sunday, 11th February 2024 11:09:13 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:32 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:flutter/material.dart';

class SoftTab<T> extends StatelessWidget {
  final String text;
  final T currentTab;
  final T thisTab;
  const SoftTab(this.text,
      {super.key, required this.thisTab, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 75,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: currentTab == thisTab
            ? SoftText.titleFlat(
                text,
                key: UniqueKey(),
                width: double.infinity,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color2),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              )
            : SoftText.title(
                text,
                key: const ValueKey(2),
                width: double.infinity,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color1),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
      ),
    );
  }
}
