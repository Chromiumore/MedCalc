import 'package:med_calc/domain/calculator.dart';

class CalculationData {
  const CalculationData({this.creatinine, required this.bilirubin, required this.inr, required this.sodium, required this.dialysisLastWeek, required this.createdAt, required this.score, required this.mortality});

  final double? creatinine;
  final double bilirubin;
  final double inr;
  final double sodium;
  final bool dialysisLastWeek;
  final DateTime createdAt;
  final int score;
  final double mortality;

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
      creatinine: json['creatinine'] as double?,
      bilirubin: json['bilirubin'] as double,
      inr: json['inr'] as double,
      sodium: json['sodium'] as double,
      dialysisLastWeek: (json['dialysis']) == 1,
      createdAt:  DateTime.parse(json['createdAt']),
      score: json['score'] as int,
      mortality: json['mortality'] as double
    );
  }
}