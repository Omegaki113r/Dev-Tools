import 'package:dev_tools/core/const/app_strings.dart';
import 'package:dev_tools/core/widgets/soft_text.dart';
import 'package:dev_tools/features/bitwise_calculator/presentation/provider/type_converter_provider.dart';
import 'package:dev_tools/core/widgets/soft_card.dart';
import 'package:dev_tools/core/widgets/soft_divider.dart';
import 'package:dev_tools/core/widgets/soft_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeConverterView extends StatelessWidget {
  const TypeConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SoftTextField(
                        label: lblDecimal,
                        controller: context
                            .read<TypeConverterProvider>()
                            .decimalController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .changeText(ChangedType.decimal, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: value.decimalResult.isNotEmpty ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.decimalResult,
                            label: "Expression Result",
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Consumer<TypeConverterProvider>(
                          builder: (context, value, child) {
                        return SoftText(
                          value.typeConverterModel.decimal2sComplimentText,
                          label: lbl2sCompliment,
                          maxLines: 1,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SoftTextField(
                        label: lblBinary,
                        // width: 500,
                        controller: context
                            .read<TypeConverterProvider>()
                            .binaryController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .changeText(ChangedType.binary, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: value.binaryResult.isNotEmpty ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.binaryResult,
                            label: "Expression Result",
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SoftTextField(
                        label: lblOctal,
                        // width: 500,
                        controller: context
                            .read<TypeConverterProvider>()
                            .octalController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .changeText(ChangedType.octal, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: value.octalResult.isNotEmpty ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.octalResult,
                            label: "Expression Result",
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SoftTextField(
                        label: lblHex,
                        // width: 500,
                        controller:
                            context.read<TypeConverterProvider>().hexController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .changeText(ChangedType.hex, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: value.hexResult.isNotEmpty ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.hexResult,
                            label: "Expression Result",
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
