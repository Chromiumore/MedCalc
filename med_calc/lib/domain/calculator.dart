import 'dart:math';

class Calculator {
  Calculator({this.creatinine, this.bilirubin, this.inr, this.sodium, this.dialysisLastWeek = false});

  double? creatinine;
  double? bilirubin;
  double? inr;
  double? sodium;
  bool dialysisLastWeek;

  static final double _creatineConversionFactor = 88.4;
  static final double _bilirubinConversionFactor = 17.104;

  static double _calculateOriginalMELD(
    double creatinine,
    double bilirubin,
    double inr,
  ) {
    double creatinineMgDl = creatinine / _creatineConversionFactor;
    creatinineMgDl = creatinineMgDl.clamp(1.0, 4.0);
    double bilirubinMgDl = bilirubin / _bilirubinConversionFactor;
    bilirubinMgDl = bilirubinMgDl < 1.0 ? 1.0 : bilirubinMgDl;
    double inrValue = inr < 1.0 ? 1.0 : inr;
    return (0.957 * log(creatinineMgDl) + 0.378 * log(bilirubinMgDl) + 1.12 * log(inrValue) + 0.643) * 10;
  }

  int calculateMELD() {
    double originalMELD = _calculateOriginalMELD((dialysisLastWeek) ? 353.6 : creatinine!, bilirubin!, inr!);
    double meld;
    double sodiumValue = sodium!.clamp(125.0, 137.0); 

    if (originalMELD <= 11) {
      meld = originalMELD - sodiumValue - (0.025 * originalMELD * (140 - sodiumValue)) + 140;
    } else {
      meld = originalMELD + 1.32 * (137 - sodiumValue) - 0.033 * originalMELD * (137 - sodiumValue);
    }
    return meld.round();
  }

  static double mortalityFromScore(int score) {
    return 19.6;
  }
}