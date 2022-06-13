import 'package:flutter/material.dart';
import 'dart:math';

class FlipCoin extends StatefulWidget {
  const FlipCoin({Key? key}) : super(key: key);

  @override
  State<FlipCoin> createState() => _FlipCoinState();
}

class _FlipCoinState extends State<FlipCoin> with TickerProviderStateMixin {
  int flipSide = 1;
  late AnimationController animationController;
  bool showFront = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
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
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: TextButton(
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.rotationX(
                        (animationController.value) * flipSide * pi * 300 / 2),
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 130,
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: showFront
                          ? Image.asset('assets/coin_images/coin1.png')
                          : Image.asset('assets/coin_images/coin2.png'),
                    ),
                  );
                },
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                animationController.reset();
                animationController.forward().whenComplete(() {
                  setState(() {
                    flipSide = Random().nextInt(2) + 1;
                    if (flipSide == 2) {
                      showFront = !showFront;
                    }
                  });
                });
              },
            ),
          ),
        )
      ]),
    );
  }
}
