import 'package:flutter/material.dart';
import 'package:med_calc/calculator.dart';
import 'package:med_calc/calculator_text_field.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final Calculator _calculator;
  int? score;

  @override
  void initState() {
    super.initState();
    _calculator = Calculator();
  }

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

            CalculatorTextField(
              label: 'Креатинин, мкмоль/л',
              calculator: _calculator,
              onChanged: (value) => _calculator.creatinine = value,
            ),
            CalculatorTextField(
              label: 'Билирубин, мкмоль/л',
              calculator: _calculator,
              onChanged: (value) => _calculator.bilirubin = value,
            ),
            CalculatorTextField(
              label: 'МНО',
              calculator: _calculator,
              onChanged: (value) => _calculator.inr = value,
            ),
            CalculatorTextField(
              label: 'Натрий, ммоль/л',
              calculator: _calculator,
              onChanged: (value) => _calculator.natrium = value,
            ),

            ElevatedButton(
              onPressed: () => setState(() {
                score = _calculator.calculateMELD();
              }),
              child: const Text('Рассчитать')
            ),

            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: score == null ? null : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text('${score.toString()}\nбаллов', textAlign: TextAlign.center,)
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        color: Colors.lightBlueAccent,
                        alignment: Alignment.center,
                        child: Text('6%\n3-х месячная летальность', textAlign: TextAlign.center,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}