/*
 * Project: Xtronic Dev Tools
 * File Name: stream_data_view.dart
 * File Created: Sunday, 3rd March 2024 2:52:06 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Sunday, 3rd March 2024 3:01:21 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */
import 'package:dev_tools/features/data_streamer/presentation/widgets/stream_data_cell.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class StreamDataView extends StatelessWidget {
  final ScrollController scrollController;
  final DragSelectGridViewController gridController;
  final List<dynamic> dataList;
  final bool ascii;
  final bool binary;
  final bool hex;
  final bool decimal;
  final bool autoScroll;
  const StreamDataView({
    super.key,
    required this.scrollController,
    required this.gridController,
    required this.dataList,
    required this.ascii,
    required this.binary,
    required this.hex,
    required this.decimal,
    required this.autoScroll,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraint) {
        double divisableWidth = 20;
        if (binary) {
          divisableWidth = 60;
        } else if (decimal) {
          divisableWidth = 26;
        } else if (hex) {
          divisableWidth = 20;
        } else {
          divisableWidth = 12;
        }
        double mainAxisHeight = 70;
        int enabledCount = (ascii ? 1 : 0) +
            (hex ? 1 : 0) +
            (decimal ? 1 : 0) +
            (binary ? 1 : 0);
        switch (enabledCount) {
          case 1:
            mainAxisHeight = 18;
            break;
          case 2:
            mainAxisHeight = 34;
            break;
          case 3:
            mainAxisHeight = 52;
            break;
          case 4:
            mainAxisHeight = 68;
            break;
        }

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1))),
          child: DragSelectGridView(
            // padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollController: scrollController,
            gridController: gridController,
            itemCount: dataList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: divisableWidth,
              mainAxisSpacing: 4,
              mainAxisExtent: mainAxisHeight,
            ),
            itemBuilder: (context, index, selected) {
              // if (autoScroll) {
              //   scrollController
              //       .jumpTo(scrollController.position.maxScrollExtent);
              // }
              return selected
                  ? StreamDataCell.flat(
                      ascii: ascii && dataList.isNotEmpty
                          ? dataList[index].ascii
                          : null,
                      binary: binary && dataList.isNotEmpty
                          ? dataList[index].binary
                          : null,
                      decimal: decimal && dataList.isNotEmpty
                          ? dataList[index].decimal
                          : null,
                      hex: hex && dataList.isNotEmpty
                          ? dataList[index].hex
                          : null,
                    )
                  : StreamDataCell(
                      ascii: ascii && dataList.isNotEmpty
                          ? dataList[index].ascii
                          : null,
                      binary: binary && dataList.isNotEmpty
                          ? dataList[index].binary
                          : null,
                      decimal: decimal && dataList.isNotEmpty
                          ? dataList[index].decimal
                          : null,
                      hex: hex && dataList.isNotEmpty
                          ? dataList[index].hex
                          : null,
                    );
            },
          ),
        );
      },
    );
  }
}
