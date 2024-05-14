import 'package:calculadora_renda_fixa/content_investiment.dart';
import 'package:flutter/material.dart';
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

  List<String> items = [];

  void createInvestment()
  {
    setState(() {
      items.add('Item $items');   
    });
  }

  @override
  Widget build(BuildContext context) {

    widget.builder.call(context, createInvestment);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder:(context, index){
        final item = items[index];
        return Dismissible(
           key: Key(item),
           onDismissed: (direction){
             setState(() {
               items.removeAt(index);
             });
           },
           child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Container(              
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 36, 36),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    spreadRadius:2,
                    blurRadius: 5,                  
                    offset: Offset(0, 0) // changes position of shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child:  ContentInvestiment()
              ),
            )
          )
        );
      }
    );
  }
}