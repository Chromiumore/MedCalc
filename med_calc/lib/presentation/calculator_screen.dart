import 'package:flutter/material.dart';
import 'package:med_calc/data/database_helper.dart';
import 'package:med_calc/domain/calculator.dart';
import 'package:med_calc/presentation/calculator_text_field.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Calculator _calculator = Calculator();
  final DatabaseHelper _db = DatabaseHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? score;
  bool isDialysisChecked = false;

  @override
  void initState() {
    super.initState();
    _db.open();
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
                value: isDialysisChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isDialysisChecked = !isDialysisChecked;
                    _calculator.dialysisLastWeek = isDialysisChecked;
                  });
                  }
              ),
          
              CalculatorTextField(
                label: 'Креатинин, мкмоль/л',
                onChanged: (value) => _calculator.creatinine = value,
                enabled: !isDialysisChecked,
              ),
              CalculatorTextField(
                label: 'Билирубин, мкмоль/л',
                onChanged: (value) => _calculator.bilirubin = value,
              ),
              CalculatorTextField(
                label: 'МНО',
                onChanged: (value) => _calculator.inr = value,
              ),
              CalculatorTextField(
                label: 'Натрий, ммоль/л',
                onChanged: (value) => _calculator.sodium = value,
              ),
          
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      score = _calculator.calculateMELD();
                      _db.addToHistory(
                        creatinine: _calculator.creatinine,
                        bilirubin: _calculator.bilirubin,
                        inr: _calculator.inr,
                        sodium: _calculator.sodium,
                        dialysisLastWeek: isDialysisChecked
                      );
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

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }
}