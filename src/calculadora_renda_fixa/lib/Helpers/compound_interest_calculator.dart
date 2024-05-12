import 'dart:math';

class CompoundInterestCalculator {
  double CalculateCompoundInterest(
      double value, DateTime expirationDate, double annualFee) {
    final difference = expirationDate.difference(DateTime.now()).inDays;
    final months = (difference / 30).truncate();
    final years = (months / 12);

    return double.parse((value * pow((1 + (annualFee/100)), years)).toStringAsFixed(2));
  }
}
