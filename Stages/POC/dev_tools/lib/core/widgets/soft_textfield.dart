/*
 * Project: Xtronic Dev Tools
 * File Name: soft_textfield.dart
 * File Created: Friday, 12th January 2024 1:30:55 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:30:37 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class SoftTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final double? width;
  final double? height;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  final String? label;
  final bool? readOnly;
  const SoftTextField({
    super.key,
    this.height,
    this.width,
    this.inputFormatter,
    this.textInputType,
    this.label,
    this.readOnly,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
  });

  @override
  State<SoftTextField> createState() => _SoftTextFieldState();
}

class _SoftTextFieldState extends State<SoftTextField> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        color: color6,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, -10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF312C5E),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            spreadRadius: -10,
            color: Color(0xFF050227),
            inset: true,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label ?? ""),
            const Gap(10),
            TextField(
                decoration: const InputDecoration(
                  isDense: true,
                  // contentPadding: EdgeInsets.all(0),
                ),
                keyboardType: widget.textInputType,
                focusNode: focusNode,
                readOnly: widget.readOnly ?? false,
                controller: widget.controller,
                inputFormatters: widget.inputFormatter,
                onSubmitted: (String value) {
                  if (widget.onSubmitted != null) widget.onSubmitted!(value);
                  focusNode.requestFocus();
                },
                onEditingComplete: () {
                  if (widget.onEditingComplete != null) {
                    widget.onEditingComplete!();
                  }
                },
                onChanged: (String value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                }),
          ],
        ),
      ),
    );
  }
}
