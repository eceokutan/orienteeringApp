import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/models/run_model.dart';
import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/run/run_page.dart';
import 'package:check_point/service/parkour_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:flutter/material.dart';

import '../../service/auth_service.dart';

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
                UserModel userInfo = UserModel();
                AuthService()
                    .getUserInfo(FirebaseAuth.instance.currentUser!.uid)
                    .then((value) async {
                  userInfo = UserModel().fromMap(value!);
                  RunModel runModel = RunModel(
                    id: runModelRef.id,
                    parkour: parkour,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    userName: userInfo.userName,
                    startDateTime: DateTime.now().toIso8601String(),
                    parkourId: parkour.id,
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
                });
              },
              child: const Text("Başla")),
          Expanded(
            child: RunsListView(
              function: () async {
                return await FirebaseFirestore.instance
                    .collection("runs")
                    .where("parkourId", isEqualTo: parkour.id)
                    .orderBy("timeTaken")
                    .limit(5)
                    .get();
              },
            ),
          )
        ],
      ),
    );
  }
}

class RunsListView extends StatefulWidget {
  RunsListView({Key? key, required this.function}) : super(key: key);

  Function function;
  @override
  State<RunsListView> createState() => _RunsListViewState();
}

class _RunsListViewState extends State<RunsListView> {
  List<RunModel> runs = [];
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      var results = await widget.function();
      for (var element in results.docs) {
        runs.add(RunModel().fromMap(element.data()));
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: runs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(runs[index].userName.toString() +
              runs[index].timeTaken.toString()),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SocialAccountPage(
                      key: ValueKey("socialAccountPageKey"),
                      userId: (runs[index].userId ?? " ")))),
        );
      },
    );
  }
}
