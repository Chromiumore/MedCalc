import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorTextField extends StatefulWidget{
  const CalculatorTextField({super.key, required this.label, this.onChanged});
  
  final String label;
  static final List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  final Function(double value)? onChanged;

  @override
  State<CalculatorTextField> createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => widget.onChanged != null ? widget.onChanged!(double.parse(value)) : () {},
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: CalculatorTextField.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
    );
  }
}