import 'package:dev_tools/const/app_strings.dart';
import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:dev_tools/widgets/soft_card.dart';
import 'package:dev_tools/widgets/soft_divider.dart';
import 'package:dev_tools/widgets/soft_text.dart';
import 'package:dev_tools/widgets/soft_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                        label: LBL_DECIMAL,
                        controller: context
                            .read<TypeConverterProvider>()
                            .decimalController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .change_text(ChangedType.DECIMAL, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        width: value.decimalResult.length > 0 ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(value.decimalResult,
                              label: "Expression Result"),
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
                          label: LBL_2S_COMPLIMENT,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: SoftTextField(
                        label: LBL_BINARY,
                        // width: 500,
                        controller: context
                            .read<TypeConverterProvider>()
                            .binaryController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .change_text(ChangedType.BINARY, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        width: value.binaryResult.length > 0 ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.binaryResult,
                            label: "Expression Result",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: SoftTextField(
                        label: LBL_OCTAL,
                        // width: 500,
                        controller: context
                            .read<TypeConverterProvider>()
                            .octalController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .change_text(ChangedType.OCTAL, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        width: value.octalResult.length > 0 ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.octalResult,
                            label: "Expression Result",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: SoftTextField(
                        label: LBL_HEX,
                        // width: 500,
                        controller:
                            context.read<TypeConverterProvider>().hexController,
                        onChanged: (value) {
                          context
                              .read<TypeConverterProvider>()
                              .change_text(ChangedType.HEX, value);
                        },
                      ),
                    ),
                  ),
                  Consumer<TypeConverterProvider>(
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        width: value.hexResult.length > 0 ? 300 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SoftText(
                            value.hexResult,
                            label: "Expression Result",
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
