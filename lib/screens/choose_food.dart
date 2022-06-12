import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChooseFood extends StatefulWidget {
  const ChooseFood({Key? key}) : super(key: key);

  @override
  State<ChooseFood> createState() => _ChooseFoodState();
}

class _ChooseFoodState extends State<ChooseFood> {
  List _foods = [];
  Future<List>? _foodsFuture;
  List _selectedFoods = [];
  int currentIndex = 0;

  Future<List> readJson() async {
    final String response =
        await rootBundle.loadString('assets/food_images.json');
    final data = await json.decode(response);
    return data["images"];
  }

  @override
  void initState() {
    _foodsFuture = readJson();
    super.initState();
  }

  void showSelectedFoods() {}

  void showNextFood() {
    if (currentIndex < _foods.length - 1) {
      currentIndex++;
      setState(() {});
    } else {
      showSelectedFoods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _foodsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }

          _foods = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(_foods[currentIndex]["url"]),
                        fit: BoxFit.fill)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: showNextFood,
                    child:
                        const Icon(Icons.cancel_rounded, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      primary: Colors.black, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectedFoods.add(_foods[currentIndex]["url"]);
                      showNextFood();
                    },
                    child: const Icon(Icons.check, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      primary: Colors.black, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showSelectedFoods();
                },
                child: const Icon(Icons.remove_red_eye, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  primary: Colors.black, // <-- Button color
                  onPrimary: Colors.red, // <-- Splash color
                ),
              )
            ],
          );
        });
  }
}
