import 'package:dev_tools/core/const/app_colors.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class SoftText extends StatelessWidget {
  final String? label;
  final String text;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool isTitleBox;
  final bool isFlatTitleBox;
  final TextStyle? labelStyle;
  const SoftText(this.text,
      {super.key,
      this.label,
      this.height,
      this.width,
      this.isTitleBox = false,
      this.isFlatTitleBox = false,
      this.labelStyle,
      this.maxLines});

  const SoftText.title(this.text,
      {super.key,
      this.label,
      this.height,
      this.width,
      this.labelStyle,
      this.maxLines})
      : isTitleBox = true,
        isFlatTitleBox = false;

  const SoftText.titleFlat(this.text,
      {super.key,
      this.label,
      this.height,
      this.width,
      this.labelStyle,
      this.maxLines})
      : isTitleBox = true,
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label ?? "",
                maxLines: 1,
              ),
              const Gap(10),
              SelectableText(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: maxLines,
              ),
            ],
          ),
        ),
      );
    }
  }
}
