
import 'package:calculadora_renda_fixa/Helpers/compound_interest_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ContentInvestiment extends StatefulWidget {
  const ContentInvestiment({super.key});

  @override
  State<ContentInvestiment> createState() {
    return ContentInvestimentState();
  }

}

class ContentInvestimentState extends State<ContentInvestiment> {

  String investmentSelected = 'CBD';
  String indexerSelected = 'CDI';
  String typeIndexerSelected = '%';
  String flatRate = '';
  String expirationDate = '';
  String mountValue = '';
  String finalValue = '';
  String annualQuote = '';

  void calculate()
  {
    setState(() {
      final calculator = CompoundInterestCalculator();
      double tax;

      if (typeIndexerSelected == '%')
      {
        tax = (double.parse(annualQuote) * double.parse(flatRate))/100;
      } else if (typeIndexerSelected == '+'){
        tax = double.parse(annualQuote) + double.parse(flatRate);
      } else {
        tax = double.parse(flatRate);
      }

      double value = calculator.CalculateCompoundInterest(double.parse(mountValue), DateFormat('dd/MM/yyyy').parse(expirationDate), tax);
      finalValue = value.toString();   
      print(finalValue);
    });
  }

  String hintQuote(){
    if (typeIndexerSelected == '%')
    {
      return typeIndexerSelected + ' do ' + indexerSelected;
    }else if (typeIndexerSelected == '+'){
      return indexerSelected + ' + ?';
    }
    return "Taxa Pré-Fixada";
  } 

  @override
  Widget build(Object context) {
    return Form(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromARGB(255, 31, 31, 31),
                  value: investmentSelected,
                  icon: const Icon(Icons.menu),              
                  items: const [
                    DropdownMenuItem<String> (
                      value: 'CBD',
                      child: Text('CDB'),
                    ),
                    DropdownMenuItem<String> (
                      value: 'LCI',
                      child: Text('LCI'),
                    ),          
                    DropdownMenuItem<String> (
                      value: 'LCA',
                      child: Text('LCA'),
                    ),          
                    DropdownMenuItem<String> (
                      value: 'LF',
                      child: Text('LF'),
                    ),  
                    DropdownMenuItem<String> (
                      value: 'CRI',
                      child: Text('CRI'),
                    )
                    ,  
                    DropdownMenuItem<String> (
                      value: 'CRA',
                      child: Text('CRA'),
                    ),  
                    DropdownMenuItem<String> (
                      value: 'LFT',
                      child: Text('LFT'),
                    ),  
                    DropdownMenuItem<String> (
                      value: 'NTNB',
                      child: Text('NTNB'),
                    ),
                    DropdownMenuItem<String> (
                      value: 'TesouroSelic',
                      child: Text('Tesouro Selic'),
                    )
                  ],
                  onChanged: (value)
                  {
                    setState(() {
                      investmentSelected = value!;                
                    });
                  }
                )
              ),
              SizedBox(width: 20.0), 
              Expanded(
                flex: 1,
                child: TextFormField(
                  maxLength: 10,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Data Vencimento',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onFieldSubmitted: (String value){
                    setState(() {
                      expirationDate = value;
                    });
                  },

                )
              )              
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromARGB(255, 31, 31, 31),
                  value: indexerSelected,
                  icon: const Icon(Icons.menu),     
                               
                  items: const [
                    DropdownMenuItem<String> (
                      value: 'CDI',
                      child: Text('CDI'),
                    ),
                    DropdownMenuItem<String> (
                      value: 'IPCA',
                      child: Text('IPCA'),
                    ),          
                    DropdownMenuItem<String> (
                      value: 'SELIC',
                      child: Text('SELIC'),
                    )                   
                  ],
                  onChanged: (value)
                  {
                    setState(() {
                      indexerSelected = value!;                
                    });
                  }
                )
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromARGB(255, 31, 31, 31),
                  value: typeIndexerSelected,
                  icon: const Icon(Icons.menu),                  
                  items: const [
                    DropdownMenuItem<String> (
                      value: '%',
                      child: Text('%'),
                    ),
                    DropdownMenuItem<String> (
                      value: '+',
                      child: Text('+'),
                    ),
                    DropdownMenuItem<String> (
                      value: 'Pré',
                      child: Text('Pré Fixado'),
                    )
                  ],
                  onChanged: (value)
                  {
                    setState(() {
                      typeIndexerSelected = value!;                
                    });
                  }
                )
              )             
            ]
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  maxLength: 3,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Cotação Anual',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onFieldSubmitted: (String value){
                    setState(() {
                      annualQuote = value;
                    });
                  },
                )
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: TextFormField(
                  maxLength: 3,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: hintQuote(),
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onFieldSubmitted: (String value){
                    setState(() {
                      flatRate = value;
                    });
                  },
                )
              ),                
            ]
          ),
          Row(
            children: [
               Expanded(
                flex: 1,
                child: TextFormField(
                  maxLength: 3,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Valor Investido R\$',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onFieldSubmitted: (String value){
                    setState(() {
                      mountValue = value;
                    });
                  },
                )
              )   
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(   
                  onPressed: calculate,                  
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular', style: TextStyle(color: Colors.white) ),
                  style: const ButtonStyle(
                    alignment: Alignment.center, 
                    backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent),
                    iconColor: MaterialStatePropertyAll(Colors.white)
                  )
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text('Valor Final - R\$ ' + finalValue, style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center)
              ),
            ],
          )
        ],
      )
    );
  }
}
