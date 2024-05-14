
import 'package:calculadora_renda_fixa/Enitties/content_investiment_entity.dart';
import 'package:calculadora_renda_fixa/Enumerators/enum_fixed_income_title.dart';
import 'package:calculadora_renda_fixa/Enumerators/enum_indexer.dart';
import 'package:calculadora_renda_fixa/Helpers/compound_interest_calculator.dart';
import 'package:calculadora_renda_fixa/Services/content_investiment_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mask/mask.dart';

class ContentInvestiment extends StatefulWidget {
  const ContentInvestiment({super.key});

  @override
  State<ContentInvestiment> createState() {
    return ContentInvestimentState();
  }

}

class ContentInvestimentState extends State<ContentInvestiment> {

  final _formKey = GlobalKey<FormState>();
  String investmentSelected = 'CDB';
  String indexerSelected = 'CDI';
  String typeIndexerSelected = '%';
  String flatRate = '';
  String expirationDate = '';
  String appliedValue = '';
  String finalValue = '';
  String annualQuote = '';
  
    var maskPercent = MaskTextInputFormatter(
    mask: 'R\$ ################################', 
    filter: { "#": RegExp(r'[\d,]+$') },
    type: MaskAutoCompletionType.lazy
  );
  
  String replacePrefix(String value){
    return value.replaceAll('R\$', '').replaceAll('%', "").replaceAll(' ', '');
  } 

  String? validateDate(value){
    if (value == null || value.isEmpty) {
      return '* Campo obrigatório';
    }
 
    if (!isDate(value)) {
      return '* Data Inválida';
    }

    var dateFormated = DateFormat('dd/MM/yyyy').parse(value); 

    if (dateFormated.difference(DateTime.now()).inHours <=0) {
      return '* Data Inválida';
    }

    return null;
  }

   String? validateValue(value){
    if (value == null || value.isEmpty) {
      return '* Campo obrigatório';
    }
    return null;
  }
  
  void calculate()
  {

    if (_formKey.currentState!.validate()) {
        
      setState(() {

        ContentInvestimentService contentInvestimentService = ContentInvestimentService();

        EnumFixedIncomeTitle enumFixedIncomeTitle = EnumFixedIncomeTitle.values.firstWhere((e) => e.toString() == ('EnumFixedIncomeTitle.$investmentSelected'));
        EnumIndexer enumIndexer = EnumIndexer.values.firstWhere((e) => e.toString() == ('EnumIndexer.$indexerSelected'));

        ContentInvestimentEntity contentInvestimentEntity = contentInvestimentService.Calculate(
          enumFixedIncomeTitle, 
          DateFormat('dd/MM/yyyy').parse(expirationDate), 
          enumIndexer, 
          typeIndexerSelected, 
          StringToDouble(replacePrefix(annualQuote)),
          StringToDouble(replacePrefix(flatRate)), 
          StringToDouble(replacePrefix(appliedValue)));

        finalValue = DoubleToString(contentInvestimentEntity.finalValue);   
      });
     
    }
  }

  String hintQuote(){
    if (typeIndexerSelected == '%')
    {
      return '$typeIndexerSelected do $indexerSelected';
    }else if (typeIndexerSelected == '+'){
      return '$indexerSelected + ?';
    }
    return "Taxa Pré-Fixada";
  } 

  @override
  Widget build(Object context) {
    return Form(
      key: _formKey,
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
                      value: 'CDB',
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
                      value: 'TESOURO_SELIC',
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
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [Mask.date()],
                  maxLength: 10,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(                    
                    hintText: 'Data Vencimento',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onChanged: (String value){
                    setState(() {
                      expirationDate = value;
                    });
                  },
                  validator:(value) => validateDate(value),
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
                  inputFormatters: [Mask.money(moneySymbol: '%')],                  
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(                
                    hintText: 'Cotação Anual',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onChanged: (String value){
                    setState(() {
                      annualQuote = value;
                    });
                  },
                  validator:(value) => validateValue(value),
                )
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [Mask.money(moneySymbol: '%')],
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: hintQuote(),
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onChanged: (String value){
                    setState(() {
                      flatRate = value;
                    });
                  },
                  validator:(value) => validateValue(value),
                )
              ),                
            ]
          ),
          Row(
            children: [
               Expanded(
                flex: 1,
                child: TextFormField(
                  inputFormatters: [Mask.money()],
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Valor Investido R\$',
                    hintStyle: TextStyle( color: Colors.white.withOpacity(0.2)),
                    counterText: ""
                  ),
                  onChanged: (String value){
                    setState(() {
                      appliedValue = value;
                    });
                  },
                  validator:(value) => validateValue(value)
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
          Visibility(
            visible: finalValue.isNotEmpty ? true: false,
            child: const SizedBox(height: 20.0),
          ),
          Visibility(
            visible: finalValue.isNotEmpty ? true: false,
            child: 
              Row(            
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Valor Final - R\$ ' + finalValue, style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center)
                  ),
                ],
              )
          )
        ],
      )
    );
  }
}
