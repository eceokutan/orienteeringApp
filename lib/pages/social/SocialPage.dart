import 'package:check_point/pages/home/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});
  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  TextEditingController searchController = TextEditingController();

  List<String> results = [];
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
        ElevatedButton(
            onPressed: () async {
              //
              var snapshot = await FirebaseFirestore.instance
                  .collection("users")
                  .where("userName", isEqualTo: searchController.text)
                  .get();

              results = [];

              for (var element in snapshot.docs) {
                results.add(element.data()["userName"]);
              }

              setState(() {});
            },
            child: const Text("Search blabla")),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Text(results[index]);
            },
          ),
        )
      ]),
    );
  }
}
