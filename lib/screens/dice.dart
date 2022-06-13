import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int diceNo = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextButton(
                child: Image.asset('assets/dice_images/dice$diceNo.png'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () => {
                  setState(
                    () => diceNo = Random().nextInt(6) + 1,
                  )
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
