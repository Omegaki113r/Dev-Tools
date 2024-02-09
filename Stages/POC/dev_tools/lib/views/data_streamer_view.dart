import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/providers/data_streamer/mqtt_streamer_provider.dart';
import 'package:dev_tools/providers/data_streamer/serial_streamer_provider.dart';
import 'package:dev_tools/providers/data_streamer/streamer_provider.dart';
import 'package:dev_tools/providers/data_streamer/websocket_provider.dart';
import 'package:dev_tools/widgets/soft_button.dart';
import 'package:dev_tools/widgets/soft_checkbox.dart';
import 'package:dev_tools/widgets/soft_dropdown_button.dart';
import 'package:dev_tools/widgets/soft_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

enum StreamerType { SERIAL, WEBSOCKET, MQTT }

class DataStreamerView extends StatefulWidget {
  const DataStreamerView({super.key});

  @override
  State<DataStreamerView> createState() => _DataStreamerViewState();
}

class _DataStreamerViewState extends State<DataStreamerView> {
  StreamerType currentStreamer = StreamerType.SERIAL;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 500),
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: color2,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {
              setState(() {
                switch (value) {
                  case 0:
                    currentStreamer = StreamerType.SERIAL;
                    break;
                  case 1:
                    currentStreamer = StreamerType.WEBSOCKET;
                    break;
                  case 2:
                    currentStreamer = StreamerType.MQTT;
                    break;
                }
              });
            },
            tabs: [
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: currentStreamer == StreamerType.SERIAL
                      ? SoftText.titleFlat(
                          "Serial",
                          key: UniqueKey(),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "Serial",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: currentStreamer == StreamerType.WEBSOCKET
                      ? SoftText.titleFlat(
                          "Web Socket",
                          key: ValueKey(1),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "Web Socket",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: currentStreamer == StreamerType.MQTT
                      ? SoftText.titleFlat(
                          "MQTT",
                          key: ValueKey(1),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color2),
                        )
                      : SoftText.title(
                          "MQTT",
                          key: ValueKey(2),
                          width: double.infinity,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color1),
                        ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ChangeNotifierProvider(
                  create: (context) => SerialStreamerProvider(),
                  child: SerialTabView(),
                ),
                ChangeNotifierProvider(
                  create: (context) => WebSocketStreamerProvider(),
                  child: WebSocketTabView(),
                ),
                ChangeNotifierProvider(
                  create: (context) => MQTTStreamerProvider(),
                  child: MQTTTabView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                      ? LBL_CONNECT
                      : provider.port!.isOpen
                          ? LBL_DISCONNECT
                          : LBL_CONNECT,
                  ButtonType.FLAT,
                  width: 150,
                  height: 45,
                  onPressed: () {
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
                            itemList: baudList
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
                              print(value);
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
                            itemList: dataBits
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
                              print(value);
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
                            itemList: stopBits
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
                              print(value);
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
                              print(value);
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
                        labelStyle: TextStyle(fontSize: 12.0),
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
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Bin",
                            onChanged: (checked) =>
                                provider.binary = checked ?? false,
                            value: provider.binary,
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Decimal",
                            onChanged: (checked) =>
                                provider.decimal = checked ?? false,
                            value: provider.decimal,
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          SoftCheckbox(
                            "Hex",
                            onChanged: (checked) =>
                                provider.hex = checked ?? false,
                            value: provider.hex,
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          Spacer(),
                          Consumer<SerialStreamerProvider>(
                              builder: (context, provider, child) {
                            return SoftCheckbox(LBL_AUTOSCROLL,
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
                      // itemCount: provider.ascii_list.length,
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

class WebSocketTabView extends StatelessWidget {
  const WebSocketTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Web Socket"),
    );
  }
}

class MQTTTabView extends StatelessWidget {
  const MQTTTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("MQTT"),
    );
  }
}
