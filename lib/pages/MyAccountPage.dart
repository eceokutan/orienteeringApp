import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:check_point/pages/LogInPage.dart';
import 'package:check_point/pages/HomePage.dart';
import 'package:check_point/pages/ParkoursPage.dart';
import 'package:flutter/material.dart';
import 'package:check_point/main.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  //code for bottom nav
  int currentTabIndex = 2;
  List<Widget> tabs = [HomePage(), ParkoursPage(), MyAccountPage()];
  onTapped(int index) {
    if (index == currentTabIndex) {
      return;
    }
    setState(() {
      currentTabIndex = index;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => tabs[currentTabIndex]));
  }

  //end of code for bottom nav
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Account"),
        ),
        body: ListView(children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 222, 123, 24),
                  Color.fromARGB(228, 217, 117, 36)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                //stops: [0.5, 0.9],
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                      backgroundColor: Color.fromARGB(245, 255, 255, 255),
                      minRadius: 55.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue,
                      )),
                  Column(
                    children: [
                      Text(
                        'USERNAME',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "100",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Following",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "100",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ]),
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
