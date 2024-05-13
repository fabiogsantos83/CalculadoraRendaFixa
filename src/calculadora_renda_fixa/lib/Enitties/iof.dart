import 'package:calculadora_renda_fixa/Enitties/iof_regressive_table.dart';
import 'package:calculadora_renda_fixa/Helpers/compound_interest_calculator.dart';

class IOF {
  List<IOFRegressiveTable> iOFRegressiveTable = [];

  IOF() {
    createRegressiveTable();
  }

  List<IOFRegressiveTable> createRegressiveTable() {
    
    iOFRegressiveTable.add(IOFRegressiveTable(1, 96));
    iOFRegressiveTable.add(IOFRegressiveTable(2, 93));
    iOFRegressiveTable.add(IOFRegressiveTable(3, 90));
    iOFRegressiveTable.add(IOFRegressiveTable(4, 86));
    iOFRegressiveTable.add(IOFRegressiveTable(5, 83));
    iOFRegressiveTable.add(IOFRegressiveTable(6, 80));
    iOFRegressiveTable.add(IOFRegressiveTable(7, 76));
    iOFRegressiveTable.add(IOFRegressiveTable(8, 73));
    iOFRegressiveTable.add(IOFRegressiveTable(9, 70));
    iOFRegressiveTable.add(IOFRegressiveTable(10, 66));
    iOFRegressiveTable.add(IOFRegressiveTable(11, 63));
    iOFRegressiveTable.add(IOFRegressiveTable(12, 60));
    iOFRegressiveTable.add(IOFRegressiveTable(13, 56));
    iOFRegressiveTable.add(IOFRegressiveTable(14, 53));
    iOFRegressiveTable.add(IOFRegressiveTable(15, 50));
    iOFRegressiveTable.add(IOFRegressiveTable(16, 46));
    iOFRegressiveTable.add(IOFRegressiveTable(17, 43));
    iOFRegressiveTable.add(IOFRegressiveTable(18, 40));
    iOFRegressiveTable.add(IOFRegressiveTable(19, 36));
    iOFRegressiveTable.add(IOFRegressiveTable(20, 33));
    iOFRegressiveTable.add(IOFRegressiveTable(21, 30));
    iOFRegressiveTable.add(IOFRegressiveTable(22, 26));
    iOFRegressiveTable.add(IOFRegressiveTable(23, 23));
    iOFRegressiveTable.add(IOFRegressiveTable(24, 20));
    iOFRegressiveTable.add(IOFRegressiveTable(25, 16));
    iOFRegressiveTable.add(IOFRegressiveTable(26, 13));
    iOFRegressiveTable.add(IOFRegressiveTable(27, 10));
    iOFRegressiveTable.add(IOFRegressiveTable(28, 6));
    iOFRegressiveTable.add(IOFRegressiveTable(29, 3));
    iOFRegressiveTable.add(IOFRegressiveTable(30, 0));

    return iOFRegressiveTable;
  }

  double CalculateIOF(double value, DateTime expirationDate) {

    final difference = expirationDate.difference(DateTime.now()).inDays;
    final tax = iOFRegressiveTable.firstWhere((x) => x.numberDays == difference, orElse: ()=> IOFRegressiveTable(difference,0));

    return roundDouble((value*tax.tax)/100, 2);
  }
}
