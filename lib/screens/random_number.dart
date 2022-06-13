import 'package:flutter/material.dart';
import 'dart:math';

class RandomNumber extends StatefulWidget {
  const RandomNumber({Key? key}) : super(key: key);

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  int min = 1;
  int max = 1000;
  int randomNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Enter Min'),
                onSubmitted: (thisIsTheMinValueJustSubmitted) {
                  min = int.parse(thisIsTheMinValueJustSubmitted);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Max (<=1000)'),
                onSubmitted: (thisIsTheMaxValueJustSubmitted) {
                  max = int.parse(thisIsTheMaxValueJustSubmitted);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      randomNumber = Random().nextInt(max - min) + min;
                    });
                  },
                  child: const Text('Generate Number')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                title: const Center(child: Text('Random number is:')),
                content: Center(child: Text(randomNumber.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
