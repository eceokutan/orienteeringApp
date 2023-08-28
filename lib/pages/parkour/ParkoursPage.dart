import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/parkour/components/parkour_list_view.dart';
import 'package:check_point/pages/parkour/create_parkour_page.dart';
import 'package:check_point/pages/parkour/parkour_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParkoursPage extends StatefulWidget {
  const ParkoursPage({super.key});

  @override
  State<ParkoursPage> createState() => _ParkoursPageState();
}

class _ParkoursPageState extends State<ParkoursPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await ParkourViewModel().getParkours();
      setState(() {});
    });
    super.initState();
  }

  //code for bottom nav

  //end of code for bottom nav

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Parkour Count:${ParkourViewModel().parkours.length}"),
          actions: const [],
        ),
        floatingActionButton: const CreateParkourButton(),
        body: Column(children: [
          Expanded(
            child: ParkoursListView(
              parkours: ParkourViewModel().parkours,
            ),
          )
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}

class CreateParkourButton extends StatefulWidget {
  const CreateParkourButton({
    super.key,
  });

  @override
  State<CreateParkourButton> createState() => _CreateParkourButtonState();
}

class _CreateParkourButtonState extends State<CreateParkourButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data()!['isAdmin']) {
              return FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  ParkourViewModel().parkourImages.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CreateParkourPage();
                      },
                    ),
                  );
                },
              );
            }
          }
          return const SizedBox();
        });
  }
}
