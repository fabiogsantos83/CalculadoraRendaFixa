import 'package:calculadora_renda_fixa/Enitties/content_investiment_entity.dart';
import 'package:calculadora_renda_fixa/Enitties/income_tax.dart';
import 'package:calculadora_renda_fixa/Enitties/iof.dart';
import 'package:calculadora_renda_fixa/Enumerators/enum_fixed_income_title.dart';
import 'package:calculadora_renda_fixa/Enumerators/enum_indexer.dart';
import 'package:calculadora_renda_fixa/Helpers/compound_interest_calculator.dart';

class ContentInvestimentService {
  ContentInvestimentEntity Calculate(
      EnumFixedIncomeTitle enumFixedIncomeTitle,
      DateTime expirationDate,
      EnumIndexer indexer,
      String typeIndexerSelected,
      double annualQuote,
      double flatRate,
      double appliedValue) {
    double discounts;
    double tax;
    double fees;
    double finalValue;

    if (typeIndexerSelected == '%') {
      tax = (annualQuote * flatRate) / 100;
    } else if (typeIndexerSelected == '+') {
      tax = annualQuote + flatRate;
    } else {
      tax = flatRate;
    }

    double grossValue =
        CalculateCompoundInterest(appliedValue, expirationDate, tax);

    fees = grossValue - appliedValue;

    switch (enumFixedIncomeTitle) {
      case EnumFixedIncomeTitle.LCA:
      case EnumFixedIncomeTitle.LCI:
      case EnumFixedIncomeTitle.CRA:
      case EnumFixedIncomeTitle.CRI:
        discounts = 0;
        break;
      default:
        discounts = IncomeTax().CalculateIncomeTax(fees, expirationDate);
        break;
    }

    discounts += IOF().CalculateIOF(fees, expirationDate);
    finalValue = grossValue - discounts;

    return ContentInvestimentEntity(
        appliedValue, fees, discounts, finalValue);
  }
}
