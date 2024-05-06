/*
 * Project: Xtronic Dev Tools
 * File Name: soft_card.dart
 * File Created: Friday, 12th January 2024 12:14:23 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:22 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:flutter/material.dart';

class SoftCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double? cornerRadius;
  final BoxBorder? border;
  const SoftCard(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.cornerRadius,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        gradient: const LinearGradient(colors: [
          Color(0xFF2C2754),
          Color(0xFF0F0B2F),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: cornerRadius != null
            ? BorderRadius.all(Radius.circular(cornerRadius!))
            : null,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: child,
    );
  }
}
