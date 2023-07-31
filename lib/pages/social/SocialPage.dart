import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/async_button.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../accounts/SocialAccountPage.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});
  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  TextEditingController searchController = TextEditingController();

  List<Map> results = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social"),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
          ),
        ),
        AsyncButton(
            onPressed: () async {
              //
              // asd
              var snapshot = await FirebaseFirestore.instance
                  .collection("users")
                  .where("userName", isEqualTo: searchController.text)
                  .get();

              results = [];

              for (var element in snapshot.docs) {
                results.add(element.data());
              }

              setState(() {});
            },
            child: const Text("Search")),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: UserPhotoWidget(
                    userId: results[index]["id"],
                  ),
                ),
                title: Text(results[index]["userName"]),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SocialAccountPage(
                            key: const ValueKey("socialAccountPageKey"),
                            userId: (results[index]["id"] ?? " ")))),
              );
            },
          ),
        )
      ]),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
