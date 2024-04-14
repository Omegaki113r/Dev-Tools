/*
 * Project: Xtronic Dev Tools
 * File Name: soft_checkbox.dart
 * File Created: Sunday, 28th January 2024 10:00:12 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:25 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SoftCheckbox extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final double? iconSize;
  final Function(bool?) onChanged;
  final bool value;
  const SoftCheckbox(
    this.label, {
    super.key,
    required this.onChanged,
    required this.value,
    this.labelStyle,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          splashRadius: 0,
          side: BorderSide(color: const Color(0xFFFFFFFF).withOpacity(0.08)),
        ),
        Center(
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
      ],
    );
  }
}
