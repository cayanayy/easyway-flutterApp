import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  late TextEditingController controller;
  StreamController<int> selected = StreamController<int>.broadcast();
  int currentColor = 0;

  final fortuneItem = <FortuneItem>[
    const FortuneItem(
        child: Text('Go to dice'),
        style: FortuneItemStyle(color: Colors.black, borderWidth: 4)),
    const FortuneItem(
        child: Text('Pass'),
        style: FortuneItemStyle(color: Colors.grey, borderWidth: 4)),
  ];

  final fortuneItemColors = <Color>[
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    selected.close();

    super.dispose();
  }

  void addFortuneItem() {
    Navigator.of(context).pop(controller.text);
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Add choice'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: addFortuneItem,
              child: const Text('Add'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: GestureDetector(
            onTap: () {
              setState(() {
                selected.add(Random().nextInt(fortuneItem.length));
              });
            },
            child: SafeArea(
                child: FortuneWheel(
              items: fortuneItem,
              selected: selected.stream,
              animateFirst: false,
            ))),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () async {
              final newFortuneItem = await openDialog();
              if (currentColor >= fortuneItemColors.length) currentColor = 0;

              setState(() {
                fortuneItem.add(FortuneItem(
                    child: Text('$newFortuneItem'),
                    style: FortuneItemStyle(
                        color: fortuneItemColors[currentColor++],
                        borderWidth: 4)));
              });
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
