import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_checkbox.dart';
import 'package:dev_tools/core/widgets/soft_dropdown_button.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/serial_streamer_provider.dart';
import 'package:dev_tools/features/data_streamer/presentation/widgets/stream_data_cell.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SerialTabView extends StatefulWidget {
  const SerialTabView({super.key});

  @override
  State<SerialTabView> createState() => _SerialTabViewState();
}

class _SerialTabViewState extends State<SerialTabView> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 5,
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftButton(
                            provider.port == null
                                ? lblConnect
                                : provider.port!.isOpen
                                    ? lblDisconnect
                                    : lblConnect,
                            ButtonType.flat,
                            width: 150,
                            height: 45,
                            onPressed: () {
                              if (provider.port == null) {
                                return;
                              }
                              if (provider.port!.isOpen) {
                                provider.serialPortDisconnect();
                              } else {
                                provider.serialPortConnect();
                              }
                            },
                          );
                        }),
                        const Gap(20),
                        Consumer<SerialStreamerProvider>(
                          builder: (context, provider, child) {
                            return SoftDropDownButton.flat(
                              "No COM Port",
                              "Port",
                              width: 150,
                              height: 45,
                              selectedValue: provider.port,
                              itemList: provider.portList.entries
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.value,
                                      child: Row(
                                        children: [
                                          const Spacer(),
                                          Expanded(
                                            child: Text(
                                              e.key,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                provider.selectedSerialPortChanged(value);
                              },
                              labelTextStyle: const TextStyle(
                                fontSize: 12.0,
                              ),
                              itemStyle: const TextStyle(
                                fontSize: 12.0,
                                color: color1,
                              ),
                            );
                          },
                        ),
                        const Gap(40),
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftDropDownButton.flat(
                            "",
                            "Baud",
                            selectedValue: provider.selectedBaudRate,
                            itemList: provider.baudrateList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            child: Text(
                                          e,
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            width: 150,
                            height: 45,
                            onChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              provider.selectedBaudRateChanged(value);
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 12.0,
                            ),
                            itemStyle: const TextStyle(
                              fontSize: 12.0,
                              color: color1,
                            ),
                          );
                        }),
                        const Gap(20),
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftDropDownButton.flat(
                            "",
                            "Data bits",
                            selectedValue: provider.selectedDataBits,
                            itemList: provider.dataBitList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            width: 150,
                            height: 45,
                            onChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              provider.selectedDataBitsChanged(value);
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 12.0,
                            ),
                            itemStyle: const TextStyle(
                              fontSize: 12.0,
                              color: color1,
                            ),
                          );
                        }),
                        const Gap(20),
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftDropDownButton.flat(
                            "",
                            "Stop bits",
                            selectedValue: provider.selectedStopBits,
                            itemList: provider.stopBitList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            width: 150,
                            height: 45,
                            onChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              provider.selectedStopBitsChanged(value);
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 12.0,
                            ),
                            itemStyle: const TextStyle(
                              fontSize: 12.0,
                              color: color1,
                            ),
                          );
                        }),
                        const Gap(20),
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftDropDownButton.flat(
                            "",
                            "Parity",
                            selectedValue: provider.selectedParity,
                            itemList: provider.parityList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                          child: Text(
                                            e,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            width: 150,
                            height: 45,
                            onChanged: (value) {
                              if (kDebugMode) {
                                print(value);
                              }
                              provider.selectedParityChanged(value);
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 12.0,
                            ),
                            itemStyle: const TextStyle(
                              fontSize: 12.0,
                              color: color1,
                            ),
                          );
                        }),
                      ],
                    ),
                    Consumer<SerialStreamerProvider>(
                      builder: (context, provider, child) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 20, bottom: 5),
                          child: SoftCheckbox(
                            "CTS Flow Control",
                            onChanged: (checked) =>
                                provider.ctsFlowControl = checked,
                            value: provider.ctsFlowControl,
                            labelStyle: const TextStyle(fontSize: 12.0),
                          ),
                        );
                      },
                    ),
                    Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              "ASCII",
                              onChanged: (checked) =>
                                  provider.ascii = checked ?? true,
                              value: provider.ascii,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              "Bin",
                              onChanged: (checked) =>
                                  provider.binary = checked ?? false,
                              value: provider.binary,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              "Decimal",
                              onChanged: (checked) =>
                                  provider.decimal = checked ?? false,
                              value: provider.decimal,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              "Hex",
                              onChanged: (checked) =>
                                  provider.hex = checked ?? false,
                              value: provider.hex,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              lblAutoScroll,
                              onChanged: (checked) =>
                                  provider.autoScroll = checked ?? false,
                              value: provider.autoScroll,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                bottom: 15,
              ),
              child: Container(
                width: double.infinity,
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
                child: Consumer<SerialStreamerProvider>(
                    builder: (context, provider, child) {
                  return LayoutBuilder(builder: (context, boxConstraint) {
                    return GridView.builder(
                        controller: provider.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: boxConstraint.biggest.width ~/ 100,
                        ),
                        itemCount: provider.charDataList.length,
                        itemBuilder: (context, index) {
                          if (provider.autoScroll) {
                            provider.scrollController.jumpTo(provider
                                .scrollController.position.maxScrollExtent);
                          }
                          return StreamDataCell(
                            ascii: provider.charDataList[index].ascii,
                            binary: provider.charDataList[index].binary,
                            decimal: provider.charDataList[index].decimal,
                            hex: provider.charDataList[index].hex,
                          );
                        });
                  });
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
