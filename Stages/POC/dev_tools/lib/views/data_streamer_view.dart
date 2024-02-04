import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/providers/data_streamer/streamer_provider.dart';
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
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 500),
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
          SizedBox(
            height: 125,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<StreamerProvider>(
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
                      Consumer<StreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDownButton(
                          "No COM Port",
                          "Port",
                          width: 170,
                          height: 45,
                          selectedValue: provider.port,
                          itemList: provider.portList.entries
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            child: Text(
                                          e.key,
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                                  ))
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
                      }),
                      const Gap(40),
                      Consumer<StreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDownButton(
                          "",
                          "Baud",
                          selectedValue: provider.selectedBaudRate,
                          itemList: provider.baudList
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
                          width: 160,
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
                      const Gap(40),
                      Consumer<StreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDownButton(
                          "",
                          "Data bits",
                          selectedValue: provider.selectedDataBits,
                          itemList: provider.dataBits
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
                          width: 160,
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
                      const Gap(40),
                      Consumer<StreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDownButton(
                          "",
                          "Stop bits",
                          selectedValue: provider.selectedStopBits,
                          itemList: provider.stopBits
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
                          width: 160,
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
                      const Gap(40),
                      Consumer<StreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDownButton(
                          "",
                          "Parity",
                          selectedValue: provider.selectedParity,
                          itemList: provider.parity
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
                          width: 160,
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
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                child: Consumer<StreamerProvider>(
                    builder: (context, provider, child) {
                  return ListView.builder(
                      controller: scrollController,
                      itemCount: provider.ascii_list.length,
                      itemBuilder: (context, position) {
                        if (provider.autoScroll) {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 40.0,
                          ),
                          child: Text(
                              context
                                  .read<StreamerProvider>()
                                  .ascii_list[position],
                              style: Theme.of(context).textTheme.bodyLarge),
                        );
                      });
                }),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child:
                Consumer<StreamerProvider>(builder: (context, provider, child) {
              return SoftCheckbox(LBL_AUTOSCROLL,
                  onChanged: (checked) =>
                      provider.autoScroll = checked ?? false,
                  value: provider.autoScroll);
            }),
          ),
        ],
      ),
    );
  }
}
