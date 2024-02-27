/*
 * Project: Xtronic Dev Tools
 * File Name: soft_text.dart
 * File Created: Friday, 12th January 2024 3:55:16 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:32:18 pm
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
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class SoftText extends StatelessWidget {
  final String? label;
  final String text;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool isTitleBox;
  final bool isFlatTitleBox;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  const SoftText(
    this.text, {
    super.key,
    this.label,
    this.height,
    this.width,
    this.isTitleBox = false,
    this.isFlatTitleBox = false,
    this.labelStyle,
    this.textStyle,
    this.maxLines,
    this.textAlign,
    this.contentPadding,
  });

  const SoftText.title(
    this.text, {
    super.key,
    this.label,
    this.height,
    this.width,
    this.labelStyle,
    this.textStyle,
    this.maxLines,
    this.textAlign,
    this.contentPadding,
  })  : isTitleBox = true,
        isFlatTitleBox = false;

  const SoftText.titleFlat(
    this.text, {
    super.key,
    this.label,
    this.height,
    this.width,
    this.labelStyle,
    this.textStyle,
    this.maxLines,
    this.textAlign,
    this.contentPadding,
  })  : isTitleBox = true,
        isFlatTitleBox = true;

  @override
  Widget build(BuildContext context) {
    if (isTitleBox) {
      if (isFlatTitleBox) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: color6,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: contentPadding ?? const EdgeInsets.all(0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: labelStyle,
            ),
          ),
        );
      } else {
        return Container(
          width: width,
          height: height,
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
            padding: contentPadding ?? const EdgeInsets.all(0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: labelStyle,
            ),
          ),
        );
      }
    } else {
      return Container(
        width: width,
        height: height,
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
          padding: contentPadding ?? const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label ?? "",
                maxLines: 1,
                style: labelStyle,
              ),
              SelectableText(
                text,
                style: textStyle,
                maxLines: maxLines,
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      );
    }
  }
}
