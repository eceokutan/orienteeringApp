import 'package:check_point/models/run_model.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:flutter/material.dart';

class RunsListView extends StatefulWidget {
  const RunsListView({Key? key, required this.myleaderboard}) : super(key: key);
  final List<RunModel> myleaderboard;
  @override
  State<RunsListView> createState() => _RunsListViewState();
}

class _RunsListViewState extends State<RunsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.myleaderboard.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.myleaderboard[index].userName!),
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
