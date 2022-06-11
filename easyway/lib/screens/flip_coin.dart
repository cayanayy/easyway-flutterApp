import 'package:flutter/material.dart';
import 'dart:math';

class FlipCoin extends StatefulWidget {
  const FlipCoin({Key? key}) : super(key: key);

  @override
  State<FlipCoin> createState() => _FlipCoinState();
}

class _FlipCoinState extends State<FlipCoin> {
  int flipSide = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: TextButton(
            child: Image.asset('assets/coin_images/coin$flipSide.png'),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () => {
              setState(
                () => flipSide = Random().nextInt(2) + 1,
              )
            },
          ),
        ))
      ]),
    );
  }
}
