import 'package:dev_tools/models/type_converter_model.dart';
import 'package:dev_tools/providers/type_converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeConverterView extends StatefulWidget {
  const TypeConverterView({super.key});

  @override
  State<TypeConverterView> createState() => _TypeConverterViewState();
}

class _TypeConverterViewState extends State<TypeConverterView> {
  final TextEditingController _hexEditingController = TextEditingController();
  final TextEditingController _decimalEditingController =
      TextEditingController();
  final TextEditingController _binaryEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.watch<TypeConverterProvider>().addListener(
      () {
        TypeConverterModel model =
            context.read<TypeConverterProvider>().typeConverterModel;
        _hexEditingController.text = model.hexText;
        _decimalEditingController.text = model.decimalText;
        _binaryEditingController.text = model.binaryText;
      },
    );
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _decimalEditingController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      onChanged: (value) {
                        context
                            .read<TypeConverterProvider>()
                            .change_text(ChangedType.DECIMAL, value);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<TypeConverterProvider>(
                      builder: (context, value, child) {
                        return Text(
                            value.typeConverterModel.decimal2sComplimentText);
                      },
                    ),
                    // TextField(
                    //   controller: _decimal2sComplimentEditingController,
                    //   autocorrect: false,
                    //   enableSuggestions: false,
                    //   autofocus: false,
                    //   onChanged: (value) {
                    //     context.read<TypeConverterProvider>().change_text(
                    //         ChangedType.DECIMAL_2S_COMPLIMENT, value);
                    //   },
                    // ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Card(
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    context
                        .read<TypeConverterProvider>()
                        .change_text(ChangedType.HEX, value);
                  },
                  controller: _hexEditingController,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _decimalEditingController,
                  onChanged: (value) {
                    context
                        .read<TypeConverterProvider>()
                        .change_text(ChangedType.DECIMAL, value);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _binaryEditingController,
                  onChanged: (value) {
                    context
                        .read<TypeConverterProvider>()
                        .change_text(ChangedType.BINARY, value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hexEditingController.dispose();
    _decimalEditingController.dispose();
    _binaryEditingController.dispose();
    super.dispose();
  }
}
