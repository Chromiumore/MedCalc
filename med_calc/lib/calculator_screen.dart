import 'package:flutter/material.dart';
import 'package:med_calc/calculator_text_field.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CheckboxListTile(
              title: const Text('Диализ не менее двух раз за последние 7 дней'),
              value: true,
              onChanged: (bool? newValue) => ()
            ),

            CalculatorTextField(label: 'Креатинин, мкмоль/л'),
            CalculatorTextField(label: 'Билирубин, мкмоль/л'),
            CalculatorTextField(label: 'МНО'),
            CalculatorTextField(label: 'Натрий, ммоль/л'),
          ],
        ),
      ),
    );
  }
  
}