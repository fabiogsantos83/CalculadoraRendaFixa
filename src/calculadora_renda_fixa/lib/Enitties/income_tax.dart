import 'package:calculadora_renda_fixa/Enitties/income_tax_regressive_table.dart';
import 'package:calculadora_renda_fixa/Helpers/compound_interest_calculator.dart';

class IncomeTax {
  List<IncomeTaxRegressiveTable> incomeTaxRegressiveTable = [];

  IncomeTax() {
    createRegressiveTable();
  }

  List<IncomeTaxRegressiveTable> createRegressiveTable() {
    incomeTaxRegressiveTable.add(IncomeTaxRegressiveTable(0, 180, 22.5));
    incomeTaxRegressiveTable.add(IncomeTaxRegressiveTable(181, 360, 20));
    incomeTaxRegressiveTable.add(IncomeTaxRegressiveTable(361, 720, 17.5));
    incomeTaxRegressiveTable.add(IncomeTaxRegressiveTable(721, null, 17.5));
    return incomeTaxRegressiveTable;
  }

  double CalculateIncomeTax(double value, DateTime expirationDate) {

    final difference = expirationDate.difference(DateTime.now()).inDays;
    final regressiveTable = incomeTaxRegressiveTable.firstWhere((element) => element.numberDaysStart <= difference && (element.numberDaysEnd == null || element.numberDaysEnd! >= difference));

    return roundDouble((value*regressiveTable.tax)/100, 2);
  }
}
