import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class NavigationBar extends StatefulWidget {
  final Icon icon1, icon2, icon3, icon4, icon5, icon6;
  NavigationBar(
      {this.icon1, this.icon2, this.icon3, this.icon4, this.icon5, this.icon6});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  Color color;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(CustomIconData(AppIcon.homeFill))
                : widget.icon1,
            title: SizedBox(
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(CustomIconData(AppIcon.searchFill))
                : widget.icon2,
            title: SizedBox(
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(CustomIconData(AppIcon.notificationFill))
                : widget.icon3,
            title: SizedBox(
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(CustomIconData(AppIcon.messageFill))
                : widget.icon4,
            title: SizedBox(
              height: 20.0,
            )),
      ],
      currentIndex: _selectedIndex,
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
      _selectedIndex = index;
      color = Colors.blue;
    });
  }
}
