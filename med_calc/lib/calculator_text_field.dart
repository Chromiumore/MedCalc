import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorTextField extends StatefulWidget{
  const CalculatorTextField({super.key, required this.label, this.onChanged, this.enabled = true});
  
  final String label;
  static final List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  final Function(double? value)? onChanged;
  final bool enabled;

  @override
  State<CalculatorTextField> createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField> {
  TextEditingController controller = TextEditingController();

  String? _validator(String? value) {
    if (!widget.enabled) {
      return null;
    }
    if (value == null || value.isEmpty) {
      return "Это поле не может быть пустым";
    }
    if (double.tryParse(value) == null) {
      return "Значения кроме чисел с плавающей точкой не допустимы";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => widget.onChanged != null ? widget.onChanged!(double.tryParse(value)) : () {},
      controller: controller,
      validator: _validator,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: CalculatorTextField.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
        errorMaxLines: 3,
      ),
      enabled: widget.enabled,
    );
  }
}