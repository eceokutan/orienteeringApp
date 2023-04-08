import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/models/run_model.dart';
import 'package:check_point/pages/run/run_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParkourDetailPage extends StatelessWidget {
  const ParkourDetailPage({super.key, required this.parkour});
  final ParkourModel parkour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parkour.name)),
      body: Column(
        children: [
          Image.network(parkour.mapImageUrl),
          TextButton(
              onPressed: () async {
                var runModelRef =
                    FirebaseFirestore.instance.collection("runs").doc();

                RunModel runModel = RunModel(
                  id: runModelRef.id,
                  parkour: parkour,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  startDateTime: DateTime.now(),
                );

                await runModelRef.set(runModel.toMap());

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RunPage(runModel: runModel);
                    },
                  ),
                );
              },
              child: const Text("Başla"))
        ],
      ),
    );
  }
}
