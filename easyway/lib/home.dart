import 'package:easyway/screens/dice.dart';
import 'package:easyway/screens/wheel.dart';
import 'package:easyway/screens/flip_coin.dart';
import 'package:easyway/screens/left_or_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Dice(),
          Wheel(),
          FlipCoin(),
          LeftOrRight(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/dice.svg', width: 20),
              label: 'Dice'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/wheel.svg', width: 20),
              label: 'Wheel'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/coin.svg', width: 20),
              label: 'Flip Coin'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/leftright.svg', width: 20),
              label: 'Left or Right'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: onTapped,
      ),
    );
  }
}
