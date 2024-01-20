import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/const/app_constants.dart';
import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/providers/data_streamer_provider.dart';
import 'package:dev_tools/widgets/soft_button.dart';
import 'package:dev_tools/widgets/soft_card.dart';
import 'package:dev_tools/widgets/soft_divider.dart';
import 'package:dev_tools/widgets/soft_dropdown.dart';
import 'package:dev_tools/widgets/soft_text.dart';
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
  StreamerType _currentStreamer = StreamerType.SERIAL;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print(timeStamp);
    //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
    //       duration: Duration(milliseconds: 500), curve: Curves.linear);
    // });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                    _currentStreamer = StreamerType.SERIAL;
                    break;
                  case 1:
                    _currentStreamer = StreamerType.WEBSOCKET;
                    break;
                  case 2:
                    _currentStreamer = StreamerType.MQTT;
                    break;
                }
              });
            },
            tabs: [
              Tab(
                height: 75,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: _currentStreamer == StreamerType.SERIAL
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
                  child: _currentStreamer == StreamerType.WEBSOCKET
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
                  child: _currentStreamer == StreamerType.MQTT
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
                      Consumer<DataStreamerProvider>(
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
                      Consumer<DataStreamerProvider>(
                          builder: (context, provider, child) {
                        return SoftDropDown(
                            width: 185,
                            height: 45,
                            itemList: provider.portList.keys.toList(),
                            onChanged: (value) {
                              provider.selectedSerialPortChanged(value);
                            });
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 40,
                    ),
                    child: Consumer<DataStreamerProvider>(
                        builder: (context, provider, child) {
                      // _scrollController.animateTo(
                      //     provider.serialData.length < 5
                      //         ? _scrollController.position.maxScrollExtent
                      //         : 0,
                      //     duration: const Duration(milliseconds: 50),
                      // curve: Curves.bounceIn);
                      return SelectableText(
                        provider.serialData,
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
