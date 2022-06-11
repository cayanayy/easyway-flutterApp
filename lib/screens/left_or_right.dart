import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeftOrRight extends StatefulWidget {
  const LeftOrRight({Key? key}) : super(key: key);

  @override
  State<LeftOrRight> createState() => _LeftOrRightState();
}

class _LeftOrRightState extends State<LeftOrRight> {
  List _foods = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/food_images.json');
    final data = await json.decode(response);
    setState(() {
      _foods = data["images"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 400.0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              child: Image.network(_foods[currentIndex]["url"]),
              onTap: () => {setState(() => currentIndex++)}),
          OutlinedButton(
              onPressed: () {}, child: const Text("Show my choices")),
        ],
      ),
    );
  }
}
