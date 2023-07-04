import 'package:check_point/pages/social/social_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/user_model.dart';
import '../../service/auth_service.dart';
import '../home/HomePage.dart';
import '../parkour/parkour_detail_page.dart';

class SocialAccountPage extends StatefulWidget {
  String userId = "";

  SocialAccountPage({required Key key, required this.userId}) : super(key: key);
  //const SocialAccountPage({super.key});
  @override
  State<SocialAccountPage> createState() => _SocialAccountPageState();
}

class _SocialAccountPageState extends State<SocialAccountPage> {
  UserModel userInfo = UserModel();
  bool alreadyFollowing = false;
  bool myaccount = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        AuthService().getUserInfo(widget.userId)
            //.getUserInfo(FirebaseAuth.instance.currentUser!.uid)
            .then((value) {
          userInfo = UserModel().fromMap(value!);

          setState(() {});
        });
        alreadyFollowing = await SocialService().amIFollowing(widget.userId);
        myaccount =
            widget.userId == await FirebaseAuth.instance.currentUser!.uid;
      },
    );

    super.initState();
  }

  //end of code for bottom nav
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("@" + (userInfo.userName ?? "")),
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
                              ),
                            ],
                          ),
                          if (!myaccount)
                            ElevatedButton(
                                onPressed: () => alreadyFollowing
                                    ? SocialService().unfollow(widget.userId)
                                    : SocialService().follow(widget.userId,
                                        userInfo.userName.toString()),
                                child: Text(
                                    alreadyFollowing ? "Unfollow" : "Follow")),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
          Expanded(
            child: RunsListView(
              function: () async {
                return await FirebaseFirestore.instance
                    .collection("runs")
                    .where("userId", isEqualTo: widget.userId.toString())
                    .orderBy("timeTaken")
                    .get();
              },
            ),
          )
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}