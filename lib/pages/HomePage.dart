import 'package:check_point/pages/LogInPage.dart';
import 'package:check_point/pages/MyAccountPage.dart';
import 'package:check_point/pages/ParkoursPage.dart';
import 'package:check_point/pages/SocialPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:check_point/service/gps_service.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //code for bottom nav
  int currentTabIndex = 0;
  List<Widget> tabs = [
    const HomePage(),
    const ParkoursPage(),
    const MyAccountPage()
  ];
  onTapped(int index) {
    if (index == currentTabIndex) {
      return;
    }
    setState(() {
      currentTabIndex = index;
    });
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => tabs[currentTabIndex]));
    });
  }
  //end of code for bottom nav

  @override
  Widget build(BuildContext context) {
    String gpslocationtext = "gps text";
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
                  gpslocationtext = GpsService().getGpsLongitude().toString();
                  print(GpsService().getGpsLongitude().toString());
                },
                child: const Text("get current location")),
            Text(gpslocationtext),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
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
        ));
  }
}
