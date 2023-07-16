import 'dart:math';

import 'package:bin_to_dec/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final binaryController = TextEditingController();
  final decimalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            constraints: const BoxConstraints(
              maxWidth: 320,
              maxHeight: 240,
            ),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.purple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(33.0))),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    onChanged: onBinaryChanged,
                    controller: binaryController,
                    label: const Text('Binary'),
                    inputFormatters: [
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) {
                          final regexp = RegExp(r'[^01 ]');
                          final match = regexp.hasMatch(newValue.text);
                          return match ? oldValue : newValue;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextFormField(
                    onChanged: onDecimalChanged,
                    controller: decimalController,
                    label: const Text('Decimal'),
                    inputFormatters: [
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) {
                          final regexp = RegExp(r'[^0-9 ]');
                          final match = regexp.hasMatch(newValue.text);
                          return match ? oldValue : newValue;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBinaryChanged(String value) {
    final binary = value.trim();
    if (binary.isEmpty) {
      _setEmpty();
      return;
    }
    if (binary.contains(' ')) {
      final binaries = binary.split(' ');
      var decimalResult = <String>[];
      for (var index = 0; index < binaries.length; index++) {
        decimalResult.add(_binaryToDecimal(binaries[index])?.toString() ?? 'NaN');
      }
      decimalController.text = decimalResult.join(' ');
      return;
    }
    decimalController.text = _binaryToDecimal(binary)?.toString() ?? 'NaN';
  }

  void onDecimalChanged(String value) {
    final decimalValue = value.trim();
    if (decimalValue.isEmpty) {
      _setEmpty();
      return;
    }
    if (decimalValue.contains(' ')) {
      final decimalList = decimalValue.split(' ');
      var binaryResult = <String>[];
      for (var index = 0; index < decimalList.length; index++) {
        binaryResult.add(_decimalToBinary(num.parse(decimalList[index])));
      }
      binaryController.text = binaryResult.join(' ');
      return;
    }
    binaryController.text = _decimalToBinary(num.parse(decimalValue));
  }

  void _setEmpty() {
    decimalController.text = '';
    binaryController.text = '';
  }

  num? _binaryToDecimal(String binary) {
    if (binary.isEmpty || int.tryParse(binary) == null) {
      return null;
    }

    num decimal = 0;
    int exponent = binary.length;

    for (int count = 0; count < binary.length; count++) {
      exponent--;
      if (int.parse(binary[count]) < 1) {
        continue;
      }
      final powResult = pow(2, exponent);
      decimal += powResult;
    }
    return decimal;
  }

  String _decimalToBinary(num decimal) {
    num computingDecimal = decimal;
    String binary = '';

    while (computingDecimal > 0) {
      final divisionResult = computingDecimal / 2;
      computingDecimal = divisionResult.truncate();
      final binResult = divisionResult.remainder(1) > 0 ? '1' : '0';

      binary = '$binResult$binary';
    }

    return binary;
  }
}
