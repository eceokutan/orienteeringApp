import 'package:check_point/models/leaderboard_item.dart';
import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/run/run_manager.dart';
import 'package:check_point/utilities.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:flutter/material.dart';

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
                await RunManager().createRun(parkour, context);
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
