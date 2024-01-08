import 'package:dev_tools/const/app_colors.dart';
import 'package:dev_tools/models/type_converter_model.dart';
import 'package:dev_tools/providers/app_provider.dart';
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
  final TextEditingController _octalEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.watch<TypeConverterProvider>().addListener(
      () {
        TypeConverterModel model =
            context.read<TypeConverterProvider>().typeConverterModel;
        _decimalEditingController.text = model.decimalText;
        _decimalEditingController.selection =
            TextSelection.collapsed(offset: model.decimalText.length);
        _hexEditingController.text = model.hexText;
        _hexEditingController.selection =
            TextSelection.collapsed(offset: model.hexText.length);
        _binaryEditingController.text = model.binaryText;
        _binaryEditingController.selection =
            TextSelection.collapsed(offset: model.binaryText.length);
        _octalEditingController.text = model.octalText;
        _octalEditingController.selection =
            TextSelection.collapsed(offset: model.octalText.length);
      },
    );
    return Container(
      padding: EdgeInsets.all(1),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color1,
        boxShadow: [
          BoxShadow(
            offset: Offset(-10, 0),
            blurRadius: 20,
            color: Colors.black,
          ),
        ],
        gradient: LinearGradient(colors: [
          Color.fromRGBO(255, 255, 255, 0.2),
          Color.fromRGBO(255, 255, 255, 0),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: color6,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
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
                      // color: Colors.white54,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<TypeConverterProvider>(
                          builder: (context, value, child) {
                            return Text(value
                                .typeConverterModel.decimal2sComplimentText);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Card(
                  // color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _binaryEditingController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      onChanged: (value) {
                        context
                            .read<TypeConverterProvider>()
                            .change_text(ChangedType.BINARY, value);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  // color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _octalEditingController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      onChanged: (value) {
                        context
                            .read<TypeConverterProvider>()
                            .change_text(ChangedType.OCTAL, value);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  // color: Colors.white54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _hexEditingController,
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        context
                            .read<TypeConverterProvider>()
                            .change_text(ChangedType.HEX, value);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
