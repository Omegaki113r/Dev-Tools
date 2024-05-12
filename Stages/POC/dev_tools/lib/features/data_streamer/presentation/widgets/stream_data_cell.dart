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
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

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
    List<Color> backgroundColors = getBackgroundColors();
    return isFlat
        ? Container(
            color: Colors.white.withOpacity(0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (ascii != null) ...[
                  Container(
                    color: color2.withOpacity(0.025),
                    width: double.infinity,
                    child: Text(
                      ascii ?? "",
                      style: TextStyle(
                        color: color2.withOpacity(0.9),
                        fontSize: streamCellFontSize,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                if (hex != null) ...[
                  Container(
                    color: color2.withOpacity(0.05),
                    width: double.infinity,
                    child: Text(
                      hex ?? "",
                      style: TextStyle(
                        color: color2.withOpacity(0.9),
                        fontSize: streamCellFontSize,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                if (decimal != null) ...[
                  Container(
                    color: color2.withOpacity(0.1),
                    width: double.infinity,
                    child: Text(
                      decimal ?? "",
                      style: TextStyle(
                        color: color2.withOpacity(0.9),
                        fontSize: streamCellFontSize,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                if (binary != null) ...[
                  Container(
                    color: color2.withOpacity(0.2),
                    width: double.infinity,
                    child: Text(
                      binary ?? "",
                      style: TextStyle(
                        color: color2.withOpacity(0.9),
                        fontSize: streamCellFontSize,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ],
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (ascii != null) ...[
                Container(
                  color: backgroundColors[0],
                  width: double.infinity,
                  child: Text(
                    ascii ?? "",
                    style: TextStyle(
                      color: color2.withOpacity(0.9),
                      fontSize: streamCellFontSize,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
              if (hex != null) ...[
                Container(
                  color: backgroundColors[1],
                  width: double.infinity,
                  child: Text(
                    hex ?? "",
                    style: TextStyle(
                      color: color2.withOpacity(0.9),
                      fontSize: streamCellFontSize,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
              if (decimal != null) ...[
                Container(
                  color: backgroundColors[2],
                  width: double.infinity,
                  child: Text(
                    decimal ?? "",
                    style: TextStyle(
                      color: color2.withOpacity(0.9),
                      fontSize: streamCellFontSize,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
              if (binary != null) ...[
                Container(
                  color: backgroundColors[3],
                  width: double.infinity,
                  child: Text(
                    binary ?? "",
                    style: TextStyle(
                      color: color2.withOpacity(0.9),
                      fontSize: streamCellFontSize,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ],
          );
  }

  List<Color> getBackgroundColors() {
    const transparent = 0.0;
    const backgroundColor = color2;
    const firstColorOpacity = 0.05;
    const secondColorOpacity = 0.1;
    const thirdColorOpacity = 0.2;
    const fourthColorOpacity = 0.4;
    List<Color> backgroundColors = List.filled(4, Colors.transparent);
    if (ascii != null && hex != null && decimal != null && binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(thirdColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(fourthColorOpacity);
    } else if (ascii != null &&
        hex == null &&
        decimal == null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii != null &&
        hex != null &&
        decimal != null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(thirdColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii != null &&
        hex != null &&
        decimal == null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(thirdColorOpacity);
    } else if (ascii != null &&
        hex == null &&
        decimal != null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(thirdColorOpacity);
    } else if (ascii != null &&
        hex != null &&
        decimal == null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii != null &&
        hex == null &&
        decimal != null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii != null &&
        hex == null &&
        decimal == null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(secondColorOpacity);
    } else if (ascii == null &&
        hex != null &&
        decimal != null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(thirdColorOpacity);
    } else if (ascii == null &&
        hex != null &&
        decimal != null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii == null &&
        hex == null &&
        decimal != null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(secondColorOpacity);
    } else if (ascii == null &&
        hex != null &&
        decimal == null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(secondColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii == null &&
        hex != null &&
        decimal == null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii == null &&
        hex == null &&
        decimal != null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii == null &&
        hex == null &&
        decimal == null &&
        binary != null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(firstColorOpacity);
    } else if (ascii == null &&
        hex == null &&
        decimal != null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(transparent);
      backgroundColors[2] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    } else if (ascii == null &&
        hex != null &&
        decimal == null &&
        binary == null) {
      backgroundColors[0] = backgroundColor.withOpacity(transparent);
      backgroundColors[1] = backgroundColor.withOpacity(firstColorOpacity);
      backgroundColors[2] = backgroundColor.withOpacity(transparent);
      backgroundColors[3] = backgroundColor.withOpacity(transparent);
    }
    return backgroundColors;
  }
}
