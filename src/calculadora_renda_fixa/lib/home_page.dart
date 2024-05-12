import 'package:calculadora_renda_fixa/body_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  
  late void Function() createInvestment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Calculadora Reda Fixa',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true),
      body: Center(
        child: BodySection(builder: (context, methodFromChild) {
            createInvestment = methodFromChild;
          }
        )
      )      
      ,
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createInvestment.call();
        },
        tooltip: 'Increment',
        child: Icon(Icons.assignment_add, color: Colors.white),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}