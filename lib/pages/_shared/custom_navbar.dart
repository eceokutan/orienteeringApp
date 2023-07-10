import 'dart:developer';

import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:check_point/pages/parkour/ParkoursPage.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({
    super.key,
  });

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  List<Widget> pages = [
    const HomePage(),
    const ParkoursPage(),
    const MyAccountPage()
  ];

  static int currentTabIndex = 0;

  onTapped(int index) {
    if (index == currentTabIndex) {
      return;
    }
    setState(() {
      currentTabIndex = index;
    });
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => pages[currentTabIndex]));
    });
  }

  @override
  Widget build(BuildContext context) {
    log("build navbar ");
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration_outlined),
          label: 'Parkours',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'My Account',
        ),
      ],
      onTap: onTapped,
      currentIndex: currentTabIndex,
    );
  }
}
