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
  final List _selectedFoods = [];
  int currentIndex = 0;
  int _selectedPageIndex = 1;
  PageController pageController = PageController();

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

  void showSelectedFoods() {
    setState(() {
      _selectedPageIndex = 2;
    });
    pageController.jumpToPage(2);
  }

  void showNextFood() {
    if (currentIndex < _foods.length - 1) {
      currentIndex++;
      setState(() {});
    } else {
      showSelectedFoods();
    }
  }

  Widget foodSelectingPage() {
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
                    color: Colors.transparent,
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
                        primary: Colors.black,
                        onPrimary: Colors.red,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        _selectedFoods.add(_foods[currentIndex]["url"]);
                        showNextFood();
                      },
                      child: const Icon(Icons.check, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        primary: Colors.black,
                        onPrimary: Colors.red,
                      )),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _selectedFoods.isNotEmpty ? showSelectedFoods() : () {};
                  },
                  child: const Icon(Icons.remove_red_eye, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: Colors.black,
                    onPrimary: Colors.red,
                  )),
            ],
          );
        });
  }

  Widget selectedFoodsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Text("You choosed these foods."),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _selectedFoods.length,
              itemBuilder: (context, position) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: NetworkImage(_selectedFoods[position]),
                              fit: BoxFit.fill)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: [foodSelectingPage(), selectedFoodsPage()],
    );
  }
}
