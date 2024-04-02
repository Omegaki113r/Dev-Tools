/*
 * Project: Xtronic Dev Tools
 * File Name: stream_data_cell.dart
 * File Created: Wednesday, 21st February 2024 6:35:17 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Monday, 26th February 2024 5:49:25 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';

class StreamDataCell extends StatelessWidget {
  final String? ascii;
  final String? binary;
  final String? decimal;
  final String? hex;
  final bool isFlat;
  const StreamDataCell(
      {super.key, this.ascii, this.binary, this.decimal, this.hex})
      : isFlat = false;

  const StreamDataCell.flat(
      {super.key, this.ascii, this.binary, this.decimal, this.hex})
      : isFlat = true;

  @override
  Widget build(BuildContext context) {
    return isFlat
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Gap(4),
                Expanded(
                  child: Text(
                    ascii ?? "",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                if (hex != null) ...[
                  const Divider(
                    indent: 30,
                  ),
                  Expanded(
                    child: Text(
                      hex ?? "",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                const Divider(
                  indent: 30,
                ),
                Expanded(
                  child: Text(
                    decimal ?? "",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const Divider(
                  indent: 30,
                ),
                Expanded(
                  child: Text(
                    binary ?? "",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const Gap(4),
              ],
            ),
          )
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                color6,
                color6,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Gap(4),
                Text(
                  ascii ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.end,
                ),
                if (hex != null) ...[
                  // const Divider(
                  //   indent: 30,
                  // ),
                  Text(
                    hex ?? "",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
                if (decimal != null) ...[
                  // const Divider(
                  //   indent: 30,
                  // ),
                  Text(
                    decimal ?? "",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
                if (binary != null) ...[
                  // const Divider(
                  //   indent: 30,
                  // ),
                  Text(
                    binary ?? "",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
                // const Gap(4),
              ],
            ),
          );
  }
}
