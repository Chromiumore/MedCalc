import 'package:flutter/material.dart';
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
                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      CalculationData calculationData = history[index]; 
                      return Row(
                        spacing: 5,
                        children: [
                          Text(calculationData.creatinine.toString()),
                          Text(calculationData.bilirubin.toString()),
                          Text(calculationData.inr.toString()),
                          Text(calculationData.dialysisLastWeek.toString()),
                          Text(calculationData.createdAt)
                        ],
                      );
                    }
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