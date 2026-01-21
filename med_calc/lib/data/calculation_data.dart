class CalculationData {
  const CalculationData({this.creatinine, required this.bilirubin, required this.inr, required this.sodium, required this.dialysisLastWeek, required this.createdAt});

  final double? creatinine;
  final double bilirubin;
  final double inr;
  final double sodium;
  final bool dialysisLastWeek;
  final DateTime createdAt;

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
      creatinine: json['creatinine'] as double?,
      bilirubin: json['bilirubin'] as double,
      inr: json['inr'] as double,
      sodium: json['sodium'] as double,
      dialysisLastWeek: (json['dialysis']) == 1,
      createdAt:  DateTime.parse(json['createdAt']),
    );
  }
}