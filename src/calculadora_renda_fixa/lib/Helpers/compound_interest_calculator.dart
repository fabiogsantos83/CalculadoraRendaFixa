import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

double CalculateCompoundInterest(
    double value, DateTime expirationDate, double annualFee) {
  final difference = expirationDate.difference(DateTime.now()).inDays;
  final months = (difference / 30).truncate();
  final years = (months / 12);

  return roundDouble((value * pow((1 + (annualFee / 100)), years)), 2);
}

double roundDouble(double value, int places) {
  final mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

String DoubleToString(double value) {
  final List<Locale> systemLocales = WidgetsBinding.instance.platformDispatcher
      .locales; // Returns the list of locales that user defined in the system settings.
  var defaultLocale = systemLocales.first;

  final format = NumberFormat.decimalPattern("pt_BR");
  final String formattedNumber = format.format(value);
  return formattedNumber;
}

double StringToDouble(String value) { 
  return double.parse(value.replaceAll('.','').replaceAll(',','.'));
}
