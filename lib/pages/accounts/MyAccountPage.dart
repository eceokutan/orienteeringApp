import 'package:check_point/models/run_model.dart';
import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/_shared/runs_list_view.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:check_point/pages/parkour/ParkoursPage.dart';
import 'package:check_point/pages/auth/auth_service.dart';
import 'package:check_point/pages/social/social_service.dart';
import 'package:check_point/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:check_point/pages/accounts/EditAccountPage.dart';

import '../parkour/parkour_detail_page.dart';
import 'SocialAccountPage.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  UserModel userInfo = UserModel();

  @override
  void initState() {
    AuthService()
        .getUserInfo(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      userInfo = UserModel().fromMap(value!);

      setState(() {});
    });

    super.initState();
  }

  //end of code for bottom nav
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Account"),
        ),
        body: Column(children: <Widget>[
          Container(
            height: 150,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 222, 123, 24),
                  Color.fromARGB(228, 217, 117, 36)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                //stops: [0.5, 0.9],
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                      backgroundColor: Color.fromARGB(245, 255, 255, 255),
                      minRadius: 55.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue,
                      )),
                  Column(
                    children: [
                      Text(
                        userInfo.userName ?? "",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                (userInfo.followers ?? 0).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Following",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                (userInfo.following ?? 0).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
          ElevatedButton(
              child: const Text("Edit Page"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditAccountPage();
                }));
              }),
          Expanded(
              child: MyRunsListView(
                  userId: FirebaseAuth.instance.currentUser!.uid))
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}

class MyRunsListView extends StatefulWidget {
  final String? userId;
  const MyRunsListView({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  State<MyRunsListView> createState() => _MyRunsListViewState();
}

class _MyRunsListViewState extends State<MyRunsListView> {
  List<RunModel> myRuns = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      myRuns = await SocialService().getUsersRuns(widget.userId!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: myRuns.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("@" + myRuns[index].userName!),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Time Taken: " +
                Utilities.milisecondstotime(myRuns[index].timeTaken!)),
          ]),
          trailing: GestureDetector(
            child: Image.network(myRuns[index].parkour!.mapImageUrl),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ParkourDetailPage(parkour: myRuns[index].parkour!)));
            },
          ),
        );
      },
    );
  }
}
