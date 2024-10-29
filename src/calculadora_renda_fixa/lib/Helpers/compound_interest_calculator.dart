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

String DoubleToString(double? value) {
  final List<Locale> systemLocales = WidgetsBinding.instance.platformDispatcher
      .locales; // Returns the list of locales that user defined in the system settings.
  var defaultLocale = systemLocales.first;

  final format = NumberFormat.decimalPattern("pt_BR");
  final String formattedNumber = format.format(value);
  return formattedNumber;
}

double StringToDouble(String value) {
  return double.parse(value.replaceAll('.', '').replaceAll(',', '.'));
}

bool isDate(String value) {
  if (value.length != 10) {
    return false;
  }

  final dateSplit = value.split('/');

  if (dateSplit.length < 3) {
    return false;
  }

  final day = int.parse(dateSplit[0]);
  final month = int.parse(dateSplit[1]);
  final year = int.parse(dateSplit[2]);

  var dateTemp = DateTime(year, month, day);

  if (dateTemp.day == day && dateTemp.month == month && dateTemp.year == year) {
    return true;
  }
  return false;
}
