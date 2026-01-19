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
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
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
                onChanged: (value) => _calculator.creatinine = value,
                min: 62,
                max: 115,
              ),
              CalculatorTextField(
                label: 'Билирубин, мкмоль/л',
                onChanged: (value) => _calculator.bilirubin = value,
                min: 5.13,
                max: 32.49,
              ),
              CalculatorTextField(
                label: 'МНО',
                onChanged: (value) => _calculator.inr = value,
                min: 0.8,
                max: 1.2,
              ),
              CalculatorTextField(
                label: 'Натрий, ммоль/л',
                onChanged: (value) => _calculator.natrium = value,
                min: 136,
                max: 145,
              ),
          
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      score = _calculator.calculateMELD();
                    });
                  }
                },
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
      ),
    );
  }
}