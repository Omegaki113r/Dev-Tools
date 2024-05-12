/*
 * Project: Xtronic Dev Tools
 * File Name: main_view.dart
 * File Created: Friday, 12th January 2024 2:37:59 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:38 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.child,
    required this.borderBottom,
  });

  final bool borderBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(-10, 0),
              blurRadius: 20,
              color: Colors.black,
            ),
          ],
          gradient: LinearGradient(
            colors: const [
              Color.fromRGBO(255, 255, 255, 0.8),
              Color.fromRGBO(255, 255, 255, 0),
            ],
            stops: const [
              0.1,
              0.3,
            ],
            begin: borderBottom ? Alignment.bottomLeft : Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderBottom
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color6,
                  borderRadius: borderBottom
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
