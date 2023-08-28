import 'package:check_point/models/leaderboard_item.dart';
import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/models/run_model.dart';
import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/run/run_page.dart';
import 'package:check_point/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class ParkourDetailPage extends StatelessWidget {
  const ParkourDetailPage({super.key, required this.parkour});
  final ParkourModel parkour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parkour.name)),
      body: ListView(
        children: [
          Image.network(parkour.mapImageUrl),
          ElevatedButton(
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
              child: const Text("Run")),
          LeaderBoardListView(myleaderboard: parkour.leaderBoard),
        ],
      ),
    );
  }
}

class LeaderBoardListView extends StatefulWidget {
  const LeaderBoardListView({Key? key, required this.myleaderboard})
      : super(key: key);
  final List<LeaderboardItem> myleaderboard;
  @override
  State<LeaderBoardListView> createState() => _LeaderBoardListViewState();
}

class _LeaderBoardListViewState extends State<LeaderBoardListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.myleaderboard.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              UserPhotoWidget(
                userId: widget.myleaderboard[index].userId ?? " ",
                radius: 20,
              ),
              const SizedBox(width: 10),
              Text("@${widget.myleaderboard[index].userName}"),
            ],
          ),
          subtitle: Text(Utilities.milisecondstotime(
              widget.myleaderboard[index].timeTaken)),
          trailing: Text("${index + 1}",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SocialAccountPage(
                      key: const ValueKey("socialAccountPageKey"),
                      userId: (widget.myleaderboard[index].userId ?? " ")))),
        );
      },
    );
  }
}
