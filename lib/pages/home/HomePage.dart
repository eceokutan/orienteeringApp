import 'dart:developer';

import 'package:check_point/pages/auth/LogInPage.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/parkour/ParkoursPage.dart';
import 'package:check_point/pages/social/SocialPage.dart';
import 'package:check_point/service/gps_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //code for bottom nav

  //end of code for bottom nav
  String gpslocationtext = "gps text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SocialPage()));
              },
              child: const Icon(
                Icons.people, // add custom icons also
              )),
          title: const Text("Home"),
          actions: const [],
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return const LogInPage();
                        },
                      ), (route) => false));
                },
                child: const Text("signout")),
            ElevatedButton(
                onPressed: () {
                  GpsService().getLocation();

                  setState(() {
                    gpslocationtext = GpsService.lat;
                  });
                  print(gpslocationtext);
                },
                child: const Text("get current location")),
            Text(gpslocationtext),
          ],
        )),
        bottomNavigationBar: const CustomNavbar());
  }
}

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
