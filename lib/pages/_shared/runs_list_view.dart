import 'package:check_point/models/run_model.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:check_point/pages/social/social_service.dart';
import 'package:check_point/utilities.dart';
import 'package:flutter/material.dart';

import '../parkour/parkour_detail_page.dart';

class RunsListView extends StatefulWidget {
  final String? userId;
  const RunsListView({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  State<RunsListView> createState() => _RunsListViewState();
}

class _RunsListViewState extends State<RunsListView> {
  List<RunModel> myRuns = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      myRuns = await SocialService().getUsersRuns(widget.userId);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      itemCount: myRuns.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SocialAccountPage(userId: myRuns[index].userId!)));
                },
                child: Row(
                  children: [
                    UserPhotoWidget(
                      userId: myRuns[index].userId!,
                      radius: 26,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("@${myRuns[index].userName!}"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // parkour name

              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ParkourDetailPage(
                            parkour: myRuns[index].parkour!)));
                  },
                  child: Text(myRuns[index].parkour!.name)),

              Text(
                  "Time Taken: ${Utilities.milisecondstotime(myRuns[index].timeTaken!)}"),
              const SizedBox(
                height: 10,
              ),

              Text(
                "Start Date:${Utilities.dateTimeFromIsoString(myRuns[index].startDateTime!)}",
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // show full image

                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: Image.network(
                                  myRuns[index].parkour!.mapImageUrl),
                            );
                          });
                    },
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                        ),
                        child:
                            Image.network(myRuns[index].parkour!.mapImageUrl)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
