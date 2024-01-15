import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:dev_tools/widgets/soft_card.dart';
import 'package:dev_tools/widgets/soft_divider.dart';
import 'package:dev_tools/widgets/soft_text.dart';
import 'package:dev_tools/widgets/soft_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TypeConverterView extends StatefulWidget {
  const TypeConverterView({super.key});

  @override
  State<TypeConverterView> createState() => _TypeConverterViewState();
}

class _TypeConverterViewState extends State<TypeConverterView> {
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
                      padding: const EdgeInsets.all(30.0),
                      child: SoftTextField(
                        label: "Decimal",
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Consumer<TypeConverterProvider>(
                          builder: (context, value, child) {
                        return SoftText(
                          value.typeConverterModel.decimal2sComplimentText,
                          label: "Decimal 2's Compliment",
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: SoftTextField(
                  label: "Binary",
                  // width: 500,
                  controller:
                      context.read<TypeConverterProvider>().binaryController,
                  onChanged: (value) {
                    context
                        .read<TypeConverterProvider>()
                        .change_text(ChangedType.BINARY, value);
                  },
                ),
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: SoftTextField(
                  label: "Octal",
                  // width: 500,
                  controller:
                      context.read<TypeConverterProvider>().octalController,
                  onChanged: (value) {
                    context
                        .read<TypeConverterProvider>()
                        .change_text(ChangedType.OCTAL, value);
                  },
                ),
              ),
            ),
            SoftDivider(),
            SoftCard(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: SoftTextField(
                  label: "Hex",
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
          ],
        ),
      ),
    );
  }
}
