import 'package:check_point/pages/LogInPage.dart';
import 'package:check_point/pages/ParkoursPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:check_point/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;
  List<Widget> tabs = [HomePage(), ParkoursPage(), LogInPage()];
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => tabs[currentTabIndex]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Column()),
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
