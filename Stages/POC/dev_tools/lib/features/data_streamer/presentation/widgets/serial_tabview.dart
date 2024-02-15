import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/services/data_streamer/serial_service.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_checkbox.dart';
import 'package:dev_tools/core/widgets/soft_dropdown_button.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/serial_streamer_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SerialTabView extends StatelessWidget {
  const SerialTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Gap(40),
                        Consumer<SerialStreamerProvider>(
                            builder: (context, provider, child) {
                          return SoftDropDownButton.flat(
                            "",
                            "Baud",
                            selectedValue: provider.selectedBaudRate,
                            itemList: baudList.keys
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
                            itemList: dataBits.keys
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
                            itemList: stopBits.keys
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
                            itemList: parity
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
                        const Spacer(),
                      ],
                    ),
                    const Gap(15),
                    Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                      return SoftCheckbox(
                        "CTS Flow Control",
                        onChanged: (checked) =>
                            provider.ctsFlowControl = checked,
                        value: provider.ctsFlowControl,
                        labelStyle: const TextStyle(fontSize: 12.0),
                      );
                    }),
                    Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SoftCheckbox(
                            "ASCII",
                            onChanged: (checked) =>
                                provider.ascii = checked ?? true,
                            value: provider.ascii,
                            labelStyle: const TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Bin",
                            onChanged: (checked) =>
                                provider.binary = checked ?? false,
                            value: provider.binary,
                            labelStyle: const TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Decimal",
                            onChanged: (checked) =>
                                provider.decimal = checked ?? false,
                            value: provider.decimal,
                            labelStyle: const TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Hex",
                            onChanged: (checked) =>
                                provider.hex = checked ?? false,
                            value: provider.hex,
                            labelStyle: const TextStyle(fontSize: 12.0),
                          ),
                          const Spacer(),
                          Consumer<SerialStreamerProvider>(
                              builder: (context, provider, child) {
                            return SoftCheckbox(lblAutoScroll,
                                onChanged: (checked) =>
                                    provider.autoScroll = checked ?? false,
                                value: provider.autoScroll);
                          }),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
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
                  return ListView.builder(
                      controller: provider.scrollController,
                      // itemCount: provider.asciiList.length,
                      itemCount: provider.dataList.length,
                      itemBuilder: (context, position) {
                        if (provider.autoScroll) {
                          provider.scrollController.jumpTo(provider
                              .scrollController.position.maxScrollExtent);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 40.0,
                          ),
                          child: Text(provider.dataList[position],
                              style: Theme.of(context).textTheme.bodyLarge),
                        );
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
