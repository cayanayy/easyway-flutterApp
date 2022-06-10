import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easyway/constants.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback? dice;
  final VoidCallback? wheel;
  final VoidCallback? coin;
  final VoidCallback? rightleft;
  const BottomNavBar({
    Key? key,
    required this.dice,
    required this.wheel,
    required this.coin,
    required this.rightleft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Flip Coin",
            svgScr: "assets/icons/coin.svg",
            press: coin,
          ),
          BottomNavItem(
            title: "Dice",
            svgScr: "assets/icons/dice.svg",
            isActive: true,
            press: dice,
          ),
          BottomNavItem(
            title: "Wheel",
            svgScr: "assets/icons/wheel.svg",
            press: wheel,
          ),
          BottomNavItem(
            title: "Right or Left",
            svgScr: "assets/icons/leftright.svg",
            press: rightleft,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final VoidCallback? press;
  final bool isActive;
  const BottomNavItem({
    Key? key,
    required this.svgScr,
    required this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
