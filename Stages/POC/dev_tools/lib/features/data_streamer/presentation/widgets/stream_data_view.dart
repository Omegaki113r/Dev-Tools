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
        int divisableWidth = (ascii ? 35 : 0) +
            (binary ? 35 : 0) +
            (hex ? 35 : 0) +
            (decimal ? 35 : 0);
        divisableWidth = divisableWidth == 0 ? 1 : divisableWidth;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1))),
          child: DragSelectGridView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollController: scrollController,
            gridController: gridController,
            itemCount: dataList.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: boxConstraint.maxWidth ~/ divisableWidth,
              mainAxisExtent: (ascii ? 40 : 0) +
                  (binary ? 40 : 0) +
                  (hex ? 40 : 0) +
                  (decimal ? 40 : 0),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index, selected) {
              if (autoScroll) {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              }
              return selected
                  ? StreamDataCell.flat(
                      ascii: ascii ? dataList[index].ascii : null,
                      binary: binary ? dataList[index].binary : null,
                      decimal: decimal ? dataList[index].decimal : null,
                      hex: hex ? dataList[index].hex : null,
                    )
                  : StreamDataCell(
                      ascii: ascii ? dataList[index].ascii : null,
                      binary: binary ? dataList[index].binary : null,
                      decimal: decimal ? dataList[index].decimal : null,
                      hex: hex ? dataList[index].hex : null,
                    );
            },
          ),
        );
      },
    );
  }
}
