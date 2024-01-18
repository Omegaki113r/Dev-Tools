import 'package:dev_tools/const/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class SoftText extends StatelessWidget {
  final String? label;
  final String text;
  final double? height;
  final double? width;
  bool isTitleBox = false;
  SoftText(this.text,
      {super.key,
      this.label,
      this.height,
      this.width,
      this.isTitleBox = false});

  @override
  Widget build(BuildContext context) {
    if (isTitleBox) {
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label ?? "",
                maxLines: 1,
              ),
              Gap(10),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
              ),
            ],
          ),
        ),
      );
    }
  }
}
