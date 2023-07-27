import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/auth/auth_manager.dart';
import 'package:check_point/pages/social/SocialPage.dart';
import 'package:check_point/service/gps_service.dart';
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
                  AuthManager().signout(context);
                },
                child: const Text("signout")),
            ElevatedButton(
                onPressed: () {
                  GpsService().getLocation();
                },
                child: const Text("get current location")),
            Text(gpslocationtext),
            const Expanded(child: RunsListView())
          ],
        )),
        bottomNavigationBar: const CustomNavbar());
  }
}
