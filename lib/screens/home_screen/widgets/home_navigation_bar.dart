import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/colors.dart';

class NavigationBar extends StatefulWidget {
  final Icon icon1, icon2, icon3, icon4, icon5, icon6;
  NavigationBar(
      {this.icon1, this.icon2, this.icon3, this.icon4, this.icon5, this.icon6});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int selectedIndex = 0;
  Color color;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: widget.icon1, title:SizedBox.shrink()),
        BottomNavigationBarItem(
            icon: widget.icon2, title:SizedBox.shrink()),
        BottomNavigationBarItem(
            icon: widget.icon3, title:SizedBox.shrink()),
        BottomNavigationBarItem(
            icon: widget.icon4, title:SizedBox.shrink()),
      ],
      currentIndex: selectedIndex,
      fixedColor: AppColors.logoBlue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      elevation: 10.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      color = Colors.blue;
    });
  }
}