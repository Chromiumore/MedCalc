import 'dart:math';

class Calculator {
  Calculator({this.creatinine, this.bilirubin, this.inr, this.natrium, this.dialysisLastWeek = false});

  double? creatinine;
  double? bilirubin;
  double? inr;
  double? natrium;
  bool dialysisLastWeek;

  static final double _creatineConversionFactor = 88.4;
  static final double _bilirubinConversionFactor = 17.104;

  static double _calculateOriginalMELD(
    double creatinine,
    double bilirubin,
    double inr,
  ) {
    return (0.957 * log(creatinine / _creatineConversionFactor) + 0.378 * log(bilirubin / _bilirubinConversionFactor) + 1.12 * log(inr) + 0.643) * 10;
  }

  int calculateMELD() {
    double originalMELD = _calculateOriginalMELD(creatinine!, (dialysisLastWeek) ? 353.6 : bilirubin!, inr!);
    double meld = originalMELD + 1.32 * (137 - natrium!) - 0.033 * originalMELD * (137 - natrium!);
    return meld.round();
  }

  static double mortalityFromScore(int score) {
    return 19.6;
  }
}