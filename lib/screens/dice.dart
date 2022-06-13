import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> with TickerProviderStateMixin {
  int diceNo = 1;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextButton(
                child: RotationTransition(
                  child: Image.asset('assets/dice_images/dice$diceNo.png'),
                  turns: animation,
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  animationController.reset();
                  animationController.forward().whenComplete(() {
                    setState(() {
                      diceNo = Random().nextInt(6) + 1;
                    });
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
