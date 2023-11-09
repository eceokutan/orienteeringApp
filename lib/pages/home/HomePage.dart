import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/_shared/runs_list_view.dart';
import 'package:check_point/pages/social/SocialPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        ),
        body: const Center(
            child: Column(
          children: [Expanded(child: RunsListView())],
        )),
        bottomNavigationBar: const CustomNavbar());
  }
}
