class CalculationData {
  const CalculationData({required this.creatiline, required this.bilirubin, required this.inr, required this.sodium, required this.dialysisLastWeek, required this.createdAt});

  final double creatiline;
  final double bilirubin;
  final double inr;
  final double sodium;
  final bool dialysisLastWeek;
  final DateTime createdAt;

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
      creatiline: json['creatiline'] as double,
      bilirubin: json['bilirubin'] as double,
      inr: json['inr'] as double,
      sodium: json['sodium'] as double,
      dialysisLastWeek: json['dialysisLastWeek'] as bool,
      createdAt: json['createdAt'] as DateTime,
    );
  }
}