import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorTextField extends StatefulWidget{
  const CalculatorTextField({super.key, required this.label, this.onChanged, required this.min, required this.max});
  
  final String label;
  static final List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
  final Function(double? value)? onChanged;
  final double min;
  final double max;

  @override
  State<CalculatorTextField> createState() => _CalculatorTextFieldState();
}

class _CalculatorTextFieldState extends State<CalculatorTextField> {
  TextEditingController controller = TextEditingController();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Это поле не может быть пустым";
    }
    if (double.tryParse(value) == null) {
      return "Значения кроме чисел с плавающей точкой не допустимы";
    }
    double parsedValue = double.parse(value);
    if (parsedValue < widget.min || parsedValue > widget.max) {
      return "Допустимы только значения в диапазоне ${widget.min}-${widget.max}";
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
        hintText: '${widget.min}-${widget.max}',
        hintStyle: TextStyle(fontWeight: FontWeight.w300),
        errorMaxLines: 3,
      ),
    );
  }
}