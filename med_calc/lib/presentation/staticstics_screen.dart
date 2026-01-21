import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_calc/data/calculation_data.dart';
import 'package:med_calc/data/database_helper.dart';

class StaticsticsScreen extends StatefulWidget {
  const StaticsticsScreen({super.key});

  @override
  State<StaticsticsScreen> createState() => _StaticsticsScreenState();
}

class _StaticsticsScreenState extends State<StaticsticsScreen> {
  final DatabaseHelper _db = DatabaseHelper();
  Future<List<CalculationData>>? _history;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _db.open();
    _history = getHistory();
  }

  Future<List<CalculationData>> getHistory() async {
    var data = await _db.getFullHistory();
    return data.map((el) => CalculationData.fromJson(el)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _history,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List<CalculationData> history = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        headingRowColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
                        dataTextStyle: TextStyle(fontSize: 20),
                        columns: const [
                          DataColumn(label: Text('Креатинин, мкмоль/л')),
                          DataColumn(label: Text('Билирубин, мкмоль/л')),
                          DataColumn(label: Text('МНО')),
                          DataColumn(label: Text('Натрий, ммоль/л')),
                          DataColumn(label: Text('Диализ не менее двух раз за последние 7 дней')),
                          DataColumn(label: Text('Дата и время')),
                        ],
                        rows: history.map((calc) => DataRow(
                          cells: [
                            DataCell(Text(calc.dialysisLastWeek ? '${353.6} (auto)' : calc.creatinine.toString())),
                            DataCell(Text(calc.bilirubin.toString())),
                            DataCell(Text(calc.inr.toString())),
                            DataCell(Text(calc.sodium.toString())),
                            DataCell(calc.dialysisLastWeek ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.close, color: Colors.red,)),
                            DataCell(Text(DateFormat('yyyy-MM-dd | HH:mm').format(calc.createdAt))),
                          ]
                        )).toList(),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else {
                  return Center(child: Text('Нет данных'),);
                }
              }
            ),
          ),
          ElevatedButton(
              onPressed: () => (setState(() {
                _history = getHistory();
              }
            )),
            child: Text('Обновить')
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }
}