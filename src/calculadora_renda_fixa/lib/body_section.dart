import 'package:calculadora_renda_fixa/content_investiment.dart';
import 'package:flutter/widgets.dart';

typedef MyBuilder = void Function(BuildContext context, void Function() methodFromChild);

class BodySection extends StatefulWidget {

  final MyBuilder builder;

  const BodySection({super.key, required this.builder});
  
  @override
  State<BodySection> createState() {
    return BodySectionState();
  }
}

class BodySectionState extends State<BodySection> {
  
  int investmentsCount = 0;

  void createInvestment()
  {
    setState(() {
      investmentsCount++;      
    });
  }

  @override
  Widget build(BuildContext context) {

    widget.builder.call(context, createInvestment);

    return ListView.builder(
      itemCount: investmentsCount,
      itemBuilder:(context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Container(
            height: 340,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 36, 36, 36),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                  spreadRadius:2,
                  blurRadius: 5,                  
                  offset: Offset(0, 0) // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child:  ContentInvestiment()
             ),
          )
        );
      }
    );
  }
}