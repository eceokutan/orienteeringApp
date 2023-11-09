import 'package:check_point/models/run_model.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/accounts/SocialAccountPage.dart';
import 'package:check_point/pages/async_button.dart';
import 'package:check_point/pages/social/social_service.dart';
import 'package:check_point/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: SocialService().getUsersRuns(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RunModel> myRuns = snapshot.data!.docs
              .map((e) => RunModel().fromMap(e.data()))
              .toList();

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
                            builder: (context) => SocialAccountPage(
                                userId: myRuns[index].userId!)));
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
                          const Spacer(),
                          if (myRuns[index].userId! ==
                              FirebaseAuth.instance.currentUser!.uid)
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context1) {
                                    return AlertDialog(
                                      content:
                                          const Text("Silmek istiyor musunuz?"),
                                      actions: [
                                        AsyncButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("runs")
                                                  .doc(myRuns[index].id!)
                                                  .delete();

                                              Navigator.pop(context);
                                            },
                                            child: const Text("Evet"))
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(CupertinoIcons.delete),
                              color: Colors.redAccent,
                            )
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
                        "Time Taken: ${Utilities.milisecondstotime(myRuns[index].timeTaken ?? 0)}"),
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
                              child: Image.network(
                                  myRuns[index].parkour!.mapImageUrl)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
