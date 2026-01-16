import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_calc/calculator.dart';

class CalculatorTextField extends StatelessWidget{
  CalculatorTextField({super.key, required this.label, this.controller, required Calculator calculator, this.onChanged});
  
  static List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  String label;
  final TextEditingController? controller;
  Function(double value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged != null ? onChanged!(double.parse(value)) : () {},
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}