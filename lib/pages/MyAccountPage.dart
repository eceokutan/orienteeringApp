import 'package:check_point/pages/HomePage.dart';
import 'package:check_point/pages/ParkoursPage.dart';
import 'package:check_point/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  //code for bottom nav
  int currentTabIndex = 2;
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

  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    AuthService()
        .getUserInfo(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      userInfo = UserInfo().fromMap(value!);

      setState(() {});
    });

    super.initState();
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
            decoration: const BoxDecoration(
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                      backgroundColor: Color.fromARGB(245, 255, 255, 255),
                      minRadius: 55.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue,
                      )),
                  Column(
                    children: [
                      Text(
                        userInfo.userName ?? "",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                userInfo.followers.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
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

class UserInfo {
  String? email;
  String? userName;
  List<dynamic>? followers;
  List<dynamic>? following;

  UserInfo({this.email, this.userName, this.followers, this.following});

  UserInfo fromMap(Map<String, dynamic> map) {
    return UserInfo(
        email: map["email"],
        userName: map["userName"],
        followers: map["followers"],
        following: map["following"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "userName": userName,
      "followers": followers,
      "following": following
    };
  }
}
