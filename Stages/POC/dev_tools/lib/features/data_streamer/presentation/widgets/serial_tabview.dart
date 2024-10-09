/* 
 * Project: Xtronic Dev Tools
 * File Name: serial_tabview.dart
 * File Created: Friday, 10th May 2024 12:58:32 am
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Monday, 7th October 2024 10:18:21 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

/*
 * Project: Xtronic Dev Tools
 * File Name: serial_tabview.dart
 * File Created: Sunday, 11th February 2024 11:00:45 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Sunday, 3rd March 2024 3:40:37 am
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 */

import 'package:dev_tools/core/constants/app_colors.dart';
import 'package:dev_tools/core/constants/app_constants.dart';
import 'package:dev_tools/core/constants/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_button.dart';
import 'package:dev_tools/core/widgets/soft_checkbox.dart';
import 'package:dev_tools/core/widgets/soft_dropdown_button.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:dev_tools/features/data_streamer/presentation/provider/serial_streamer_provider.dart';
import 'package:dev_tools/features/data_streamer/presentation/widgets/stream_data_view.dart';
import 'package:docking/docking.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SerialTabView extends StatefulWidget {
  const SerialTabView({super.key});

  @override
  State<SerialTabView> createState() => _SerialTabViewState();
}

class _SerialTabViewState extends State<SerialTabView> {
  final ScrollController scrollController = ScrollController();
  late DockingLayout _layout;
  @override
  void initState() {
    _layout = DockingLayout(root: generateDock());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _layout.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, bottom: 15, top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          children: [
                            Consumer<SerialStreamerProvider>(
                                builder: (context, provider, child) {
                              return SoftButton(
                                ButtonType.flat,
                                label: provider.port == null
                                    ? lblConnect
                                    : provider.isOpen()
                                        ? lblDisconnect
                                        : lblConnect,
                                width: 150,
                                height: 45,
                                onPressed: () {
                                  if (!kIsWeb) {
                                    if (provider.port == null) {
                                      return;
                                    }
                                    if (provider.port!.isOpen) {
                                      provider.serialPortDisconnect();
                                    } else {
                                      provider.serialPortConnect();
                                    }
                                  } else {
                                    if (provider.isOpen()) {
                                      provider.serialPortDisconnect();
                                    } else {
                                      provider.serialPortConnect();
                                    }
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return const AlertDialog(
                                    //         title: Text(lblNotSupportedYet),
                                    //         content: Padding(
                                    //           padding: EdgeInsets.all(30.0),
                                    //           child: Text(lblWEBAPINotice),
                                    //         ),
                                    //       );
                                    //     });
                                  }
                                },
                              );
                            }),
                            const Gap(20),
                            if (!kIsWeb) ...[
                              Consumer<SerialStreamerProvider>(
                                builder: (context, provider, child) {
                                  return SoftDropDownButton.flat(
                                    lblNoCOMPORT,
                                    lblPort,
                                    width: 150,
                                    height: 45,
                                    selectedValue: provider.port,
                                    itemList: provider.portList.entries
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.value,
                                            // child: Text(e.key),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                Expanded(
                                                  child: Text(
                                                    e.key,
                                                    textAlign: TextAlign.end,
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
                            ],
                            const Gap(10),
                            const VerticalDivider(
                              color: color1,
                            ),
                            const Gap(10),
                            Consumer<SerialStreamerProvider>(
                                builder: (context, provider, child) {
                              return SoftDropDownButton.flat(
                                "",
                                lblBaud,
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
                                                textAlign: TextAlign.end,
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
                                  if (kIsWeb) {
                                    if (provider.isOpen()) {
                                      toastification.show(
                                          context: context,
                                          type: ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          alignment: Alignment.bottomCenter,
                                          autoCloseDuration:
                                              const Duration(seconds: 5),
                                          backgroundColor: color6,
                                          showProgressBar: false,
                                          showIcon: false,
                                          borderSide: const BorderSide(
                                              color: color1, width: 0.5),
                                          description: const Text(
                                            msgCannotChangeConfigAfterConnect,
                                            style: TextStyle(color: color2),
                                          ));
                                      return;
                                    }
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
                                lblDataBits,
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
                                              textAlign: TextAlign.end,
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
                                  if (kIsWeb) {
                                    if (provider.isOpen()) {
                                      toastification.show(
                                          context: context,
                                          type: ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          alignment: Alignment.bottomCenter,
                                          autoCloseDuration:
                                              const Duration(seconds: 5),
                                          backgroundColor: color6,
                                          showProgressBar: false,
                                          showIcon: false,
                                          borderSide: const BorderSide(
                                              color: color1, width: 0.5),
                                          description: const Text(
                                            msgCannotChangeConfigAfterConnect,
                                            style: TextStyle(color: color2),
                                          ));
                                      return;
                                    }
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
                                lblStopBits,
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
                                              textAlign: TextAlign.end,
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
                                  if (kIsWeb) {
                                    if (provider.isOpen()) {
                                      toastification.show(
                                          context: context,
                                          type: ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          alignment: Alignment.bottomCenter,
                                          autoCloseDuration:
                                              const Duration(seconds: 5),
                                          backgroundColor: color6,
                                          showProgressBar: false,
                                          showIcon: false,
                                          borderSide: const BorderSide(
                                              color: color1, width: 0.5),
                                          description: const Text(
                                            msgCannotChangeConfigAfterConnect,
                                            style: TextStyle(color: color2),
                                          ));
                                      return;
                                    }
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
                                lblParity,
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
                                                textAlign: TextAlign.end,
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
                                  if (kIsWeb) {
                                    if (provider.isOpen()) {
                                      toastification.show(
                                          context: context,
                                          type: ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          alignment: Alignment.bottomCenter,
                                          autoCloseDuration:
                                              const Duration(seconds: 5),
                                          backgroundColor: color6,
                                          showProgressBar: false,
                                          showIcon: false,
                                          borderSide: const BorderSide(
                                              color: color1, width: 0.5),
                                          description: const Text(
                                            msgCannotChangeConfigAfterConnect,
                                            style: TextStyle(color: color2),
                                          ));
                                      return;
                                    }
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
                      ),
                      const Gap(20),
                      Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 20, bottom: 5),
                            child: SoftCheckbox(
                              lblCTSFlowControl,
                              onChanged: (checked) =>
                                  provider.ctsFlowControl = checked,
                              value: provider.ctsFlowControl,
                              labelStyle: const TextStyle(fontSize: 12.0),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -10.0,
                left: 30.0,
                child: Container(
                  color: color6,
                  child: const Text(lblConfiguration),
                ),
              ),
            ],
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SoftTextField(
                    label: lblTX,
                    width: double.infinity,
                    controller: context
                        .watch<SerialStreamerProvider>()
                        .txEditingController,
                    onChanged: (p0) => context
                        .read<SerialStreamerProvider>()
                        .txEditingListener(p0),
                    onSubmitted: (value) {
                      if (!context.read<SerialStreamerProvider>().isOpen()) {
                        return;
                      }
                      context
                          .read<SerialStreamerProvider>()
                          .serialDataTransmitHandler(value);
                      context
                          .read<SerialStreamerProvider>()
                          .txEditingController
                          .text = "";
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 375,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                lblAscii,
                                style: TextStyle(color: color2, fontSize: 12),
                              ),
                              leading: Radio(
                                value: TXDataType.ascii,
                                groupValue: context
                                    .watch<SerialStreamerProvider>()
                                    .txDataType,
                                onChanged: (value) => context
                                    .read<SerialStreamerProvider>()
                                    .txDataType = value!,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                lblHex,
                                style: TextStyle(color: color2, fontSize: 12),
                              ),
                              leading: Radio(
                                value: TXDataType.hex,
                                groupValue: context
                                    .watch<SerialStreamerProvider>()
                                    .txDataType,
                                onChanged: (value) => context
                                    .read<SerialStreamerProvider>()
                                    .txDataType = value!,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                lblBinary,
                                style: TextStyle(color: color2, fontSize: 12),
                              ),
                              leading: Radio(
                                value: TXDataType.binary,
                                groupValue: context
                                    .watch<SerialStreamerProvider>()
                                    .txDataType,
                                onChanged: (value) => context
                                    .read<SerialStreamerProvider>()
                                    .txDataType = value!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(20),
                          SoftDropDownButton.flat(
                            "",
                            lblSendOnEnter,
                            selectedValue: context
                                .watch<SerialStreamerProvider>()
                                .selectedtxOnEnter,
                            itemList: context
                                .read<SerialStreamerProvider>()
                                .txOnEnterList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                            child: Text(
                                          txEnterStringList[e]!,
                                          textAlign: TextAlign.end,
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            width: 200,
                            height: 45,
                            onChanged: (value) {
                              context
                                  .read<SerialStreamerProvider>()
                                  .selectedTXonEnterChanged(value);
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 12.0,
                            ),
                            itemStyle: const TextStyle(
                              fontSize: 12.0,
                              color: color1,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Divider(
            color: Colors.white.withOpacity(0.1),
          ),
          Expanded(child: rxWidget()),
          // Expanded(child: txWidget()),
          // Expanded(child: tabbedWidget()),
        ],
      ),
    );
  }

  Widget rxWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, bottom: 15, top: 20.0),
                child: Consumer<SerialStreamerProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblAscii,
                                  onChanged: (checked) =>
                                      provider.rxAscii = checked ?? true,
                                  value: provider.rxAscii,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblHex,
                                  onChanged: (checked) =>
                                      provider.rxHex = checked ?? false,
                                  value: provider.rxHex,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblDecimal,
                                  onChanged: (checked) =>
                                      provider.rxDecimal = checked ?? false,
                                  value: provider.rxDecimal,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblBinary,
                                  onChanged: (checked) =>
                                      provider.rxBinary = checked ?? false,
                                  value: provider.rxBinary,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblAutoScroll,
                                  onChanged: (checked) =>
                                      provider.rxAutoScroll = checked ?? false,
                                  value: provider.rxAutoScroll,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                              ),
                              SoftText(
                                "${provider.rxData}",
                                label: lblRX,
                                width: 150,
                                height: 50,
                                labelStyle: const TextStyle(fontSize: 12),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 14),
                                textAlign: TextAlign.end,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                              ),
                              const Gap(25),
                              SoftButton(ButtonType.flat,
                                  label: lblReset,
                                  width: 100,
                                  height: 40, onPressed: () {
                                provider.resetRXCounter();
                              }),
                            ],
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: SoftButton(ButtonType.flat,
                              label: lblClearData, onPressed: () {
                            provider.resetRXData();
                          }),
                        ),
                        const Gap(10),
                        Container(
                          height: 400,
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
                          child: StreamDataView(
                            scrollController: provider.rxScrollController,
                            gridController: provider.rxGridViewController,
                            dataList: provider.rxDataList,
                            ascii: provider.rxAscii,
                            binary: provider.rxBinary,
                            hex: provider.rxHex,
                            decimal: provider.rxDecimal,
                            autoScroll: provider.rxAutoScroll,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: -10.0,
              left: 30.0,
              child: Container(
                color: color6,
                child: const Text(lblReceivedData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget txWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, bottom: 15, top: 20.0),
                child: Consumer<SerialStreamerProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblAscii,
                                  onChanged: (checked) =>
                                      provider.txAscii = checked ?? true,
                                  value: provider.txAscii,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblHex,
                                  onChanged: (checked) =>
                                      provider.txHex = checked ?? false,
                                  value: provider.txHex,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblDecimal,
                                  onChanged: (checked) =>
                                      provider.txDecimal = checked ?? false,
                                  value: provider.txDecimal,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblBinary,
                                  onChanged: (checked) =>
                                      provider.txBinary = checked ?? false,
                                  value: provider.txBinary,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                                indent: 15,
                                endIndent: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 20, bottom: 5),
                                child: SoftCheckbox(
                                  lblAutoScroll,
                                  onChanged: (checked) =>
                                      provider.txAutoScroll = checked ?? false,
                                  value: provider.txAutoScroll,
                                  labelStyle: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              const VerticalDivider(
                                color: color1,
                              ),
                              SoftText(
                                "${provider.txData}",
                                label: lblTX,
                                width: 150,
                                height: 50,
                                labelStyle: const TextStyle(fontSize: 12),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 14),
                                textAlign: TextAlign.end,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                              ),
                              const Gap(25),
                              SoftButton(ButtonType.flat,
                                  label: lblReset,
                                  width: 100,
                                  height: 40, onPressed: () {
                                provider.resetTXCounter();
                              }),
                            ],
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: SoftButton(ButtonType.flat,
                              label: lblClearData, onPressed: () {
                            provider.resetTXData();
                          }),
                        ),
                        const Gap(10),
                        Container(
                          height: 400,
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
                            return StreamDataView(
                              scrollController: provider.txScrollController,
                              gridController: provider.txGridViewController,
                              dataList: provider.txDataList,
                              ascii: provider.txAscii,
                              binary: provider.txBinary,
                              hex: provider.txHex,
                              decimal: provider.txDecimal,
                              autoScroll: provider.txAutoScroll,
                            );
                          }),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: -10.0,
              left: 30.0,
              child: Container(
                color: color6,
                child: const Text(lblTransmittedData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabbedWidget() {
    return TabbedViewTheme(
      data: TabbedViewThemeData(
        tabsArea: TabsAreaThemeData(
            border: const Border(bottom: BorderSide(color: Color(0xFF2C2754)))),
        tab: TabThemeData(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          decoration: const BoxDecoration(
            color: color6,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            gradient: LinearGradient(colors: [
              color6,
              color6,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
          selectedStatus: TabStatusThemeData(
              decoration: const BoxDecoration(
            color: color6,
            border: Border(
              top: BorderSide(
                color: Color(0xFF2C2754),
              ),
              left: BorderSide(
                color: Color(0xFF2C2754),
              ),
              right: BorderSide(
                color: Color(0xFF2C2754),
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
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
          )),
        ),
      ),
      child: Docking(
        maximizableTabsArea: false,
        layout: _layout,
      ),
    );
  }

  DockingArea generateDock() {
    return DockingTabs(
      [
        DockingItem(
          name: lblReceived,
          closable: false,
          maximizable: false,
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 15, top: 20.0),
                      child: Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblAscii,
                                        onChanged: (checked) =>
                                            provider.rxAscii = checked ?? true,
                                        value: provider.rxAscii,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblHex,
                                        onChanged: (checked) =>
                                            provider.rxHex = checked ?? false,
                                        value: provider.rxHex,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblDecimal,
                                        onChanged: (checked) => provider
                                            .rxDecimal = checked ?? false,
                                        value: provider.rxDecimal,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblBinary,
                                        onChanged: (checked) => provider
                                            .rxBinary = checked ?? false,
                                        value: provider.rxBinary,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblAutoScroll,
                                        onChanged: (checked) => provider
                                            .rxAutoScroll = checked ?? false,
                                        value: provider.rxAutoScroll,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                    ),
                                    SoftText(
                                      "${provider.rxData}",
                                      label: lblRX,
                                      width: 150,
                                      height: 50,
                                      labelStyle: const TextStyle(fontSize: 12),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                    ),
                                    const Gap(25),
                                    SoftButton(ButtonType.flat,
                                        label: lblReset,
                                        width: 100,
                                        height: 40, onPressed: () {
                                      provider.resetRXCounter();
                                    }),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: SoftButton(ButtonType.flat,
                                    label: lblClearData, onPressed: () {
                                  provider.resetRXData();
                                }),
                              ),
                              const Gap(10),
                              Container(
                                height: 400,
                                decoration: const BoxDecoration(
                                  color: color6,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                child: StreamDataView(
                                  scrollController: provider.rxScrollController,
                                  gridController: provider.rxGridViewController,
                                  dataList: provider.rxDataList,
                                  ascii: provider.rxAscii,
                                  binary: provider.rxBinary,
                                  hex: provider.rxHex,
                                  decimal: provider.rxDecimal,
                                  autoScroll: provider.rxAutoScroll,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10.0,
                    left: 30.0,
                    child: Container(
                      color: color6,
                      child: const Text(lblReceivedData),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        DockingItem(
          name: lblTransmitted,
          closable: false,
          maximizable: false,
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 15, top: 20.0),
                      child: Consumer<SerialStreamerProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblAscii,
                                        onChanged: (checked) =>
                                            provider.txAscii = checked ?? true,
                                        value: provider.txAscii,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblHex,
                                        onChanged: (checked) =>
                                            provider.txHex = checked ?? false,
                                        value: provider.txHex,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblDecimal,
                                        onChanged: (checked) => provider
                                            .txDecimal = checked ?? false,
                                        value: provider.txDecimal,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblBinary,
                                        onChanged: (checked) => provider
                                            .txBinary = checked ?? false,
                                        value: provider.txBinary,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 20, bottom: 5),
                                      child: SoftCheckbox(
                                        lblAutoScroll,
                                        onChanged: (checked) => provider
                                            .txAutoScroll = checked ?? false,
                                        value: provider.txAutoScroll,
                                        labelStyle:
                                            const TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: color1,
                                    ),
                                    SoftText(
                                      "${provider.txData}",
                                      label: lblTX,
                                      width: 150,
                                      height: 50,
                                      labelStyle: const TextStyle(fontSize: 12),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                    ),
                                    const Gap(25),
                                    SoftButton(ButtonType.flat,
                                        label: lblReset,
                                        width: 100,
                                        height: 40, onPressed: () {
                                      provider.resetTXCounter();
                                    }),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: SoftButton(ButtonType.flat,
                                    label: lblClearData, onPressed: () {
                                  provider.resetTXData();
                                }),
                              ),
                              const Gap(10),
                              Container(
                                height: 400,
                                decoration: const BoxDecoration(
                                  color: color6,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                  return StreamDataView(
                                    scrollController:
                                        provider.txScrollController,
                                    gridController:
                                        provider.txGridViewController,
                                    dataList: provider.txDataList,
                                    ascii: provider.txAscii,
                                    binary: provider.txBinary,
                                    hex: provider.txHex,
                                    decimal: provider.txDecimal,
                                    autoScroll: provider.txAutoScroll,
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10.0,
                    left: 30.0,
                    child: Container(
                      color: color6,
                      child: const Text(lblTransmittedData),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
