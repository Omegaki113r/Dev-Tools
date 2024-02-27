/*
 * Project: Xtronic Dev Tools
 * File Name: soft_dropdown_button.dart
 * File Created: Saturday, 13th January 2024 10:33:08 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:30 pm
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

class SoftDropDownButton<T> extends StatelessWidget {
  final String noItemText;
  final TextStyle? noItemTextStyle;
  final String label;
  final TextStyle? labelTextStyle;
  final List<DropdownMenuItem<T>> itemList;
  final TextStyle? itemStyle;
  final double? width;
  final double? height;
  final T? selectedValue;
  final Function? onChanged;
  final bool isFlat;

  const SoftDropDownButton(
    this.noItemText,
    this.label, {
    super.key,
    this.height,
    this.width,
    this.selectedValue,
    required this.itemList,
    this.onChanged,
    this.noItemTextStyle,
    this.labelTextStyle,
    this.itemStyle,
  }) : isFlat = false;

  const SoftDropDownButton.flat(
    this.noItemText,
    this.label, {
    super.key,
    this.height,
    this.width,
    this.selectedValue,
    required this.itemList,
    this.onChanged,
    this.noItemTextStyle,
    this.labelTextStyle,
    this.itemStyle,
  }) : isFlat = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // color: Color(0xFF1D1A39),
        gradient: LinearGradient(colors: [
          if (isFlat) ...[
            const Color(0xFF1D1A39),
            const Color(0xFF1D1A39)
          ] else ...[
            const Color(0xFF0F0B2F),
            const Color(0xFF2C2754),
          ]
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-5, -5),
            blurRadius: 10,
            color: Color(0xFF312C5E),
          ),
          BoxShadow(
            offset: Offset(5, 5),
            blurRadius: 10,
            color: Color(0xFF050227),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: itemList.isEmpty
            ? Center(
                child: Text(
                noItemText,
                style: noItemTextStyle,
              ))
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButton(
                      elevation: 4,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      iconEnabledColor: color2,
                      value: selectedValue,
                      isExpanded: true,
                      underline: Container(),
                      items: itemList,
                      style: itemStyle,
                      onChanged: ((value) {
                        if (onChanged != null && value != null) {
                          onChanged!(value);
                        }
                      }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        label,
                        style: labelTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
