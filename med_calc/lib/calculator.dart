import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), 
              ],
              decoration: InputDecoration(
                labelText: 'Креатинин, мкмоль/л',
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), 
              ],
              decoration: InputDecoration(
                labelText: 'Билирубин, мкмоль/л',
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), 
              ],
              decoration: InputDecoration(
                labelText: 'МНО',
                border: OutlineInputBorder(),
              ),
            ),

            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), 
              ],
              decoration: InputDecoration(
                labelText: 'Натрий, ммоль/л',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}