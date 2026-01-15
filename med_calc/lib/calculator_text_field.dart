import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_calc/calculator.dart';

class CalculatorTextField extends StatelessWidget{
  CalculatorTextField({super.key, required this.label, this.controller, required Calculator calculator, this.onSubmitted});
  
  static List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  String label;
  final TextEditingController? controller;
  Function(double value)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => onSubmitted != null ? onSubmitted!(double.parse(value)) : () {},
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