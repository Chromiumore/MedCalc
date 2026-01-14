import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorTextField extends StatelessWidget{
  const CalculatorTextField({super.key, required this.label});
  
  static final List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}