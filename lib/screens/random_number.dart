import 'package:flutter/material.dart';
import 'dart:math';

class RandomNumber extends StatelessWidget {
  const RandomNumber({Key? key}) : super(key: key);

  static const String _title = 'Random Number';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  
  int min = 1;
  int max = 1000;
  int randomNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Container(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView( child: TextField(
            decoration: const InputDecoration(labelText: 'Enter Min'),
            onSubmitted: (thisIsTheMinValueJustSubmitted) {
              min = int.parse(thisIsTheMinValueJustSubmitted);
            },
          ),
        ),
      ),      
          Container(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(child: TextField(
            decoration: const InputDecoration(labelText: 'Enter Max (<=1000)'),
            onSubmitted: (thisIsTheMaxValueJustSubmitted) {
              max = int.parse(thisIsTheMaxValueJustSubmitted);
            },
          ),
        ),   
      ),
          
          Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(child:ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
              onPressed: () {
                setState(() {
                  randomNumber = Random().nextInt(max - min) + min;
                });
              },   
              child: const Text('Generate Number')),),
            ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(child: AlertDialog(
          title: const Text('Random Number is:'),
          content: Text(randomNumber.toString()),
           ),
          ), 
         ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}