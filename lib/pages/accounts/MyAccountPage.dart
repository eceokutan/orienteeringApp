import 'package:check_point/models/file_model.dart';
import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/_shared/runs_list_view.dart';
import 'package:check_point/pages/auth/auth_manager.dart';
import 'package:check_point/pages/auth/auth_service.dart';
import 'package:check_point/pages/parkour/parkour_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          actions: [
            IconButton(
                onPressed: () {
                  AuthManager().signout(context);
                },
                icon: const Icon(Icons.logout))
          ],
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
                  InkWell(
                    onTap: () async {
                      List<FileModel> files =
                          await ParkourService().pickImages();

                      final result = await ParkourService().uploadSingleFile(
                          file: files.first.file,
                          childPath:
                              "profileImages/${FirebaseAuth.instance.currentUser!.uid}/${files.first.fileName}");

                      // set user profile photo
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({"profilePhoto": result});
                    },
                    child: UserPhotoWidget(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
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
                                (userInfo.followerCount ?? 0).toString(),
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
                                (userInfo.followingCount ?? 0).toString(),
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
          Expanded(
              child:
                  RunsListView(userId: FirebaseAuth.instance.currentUser!.uid))
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({
    super.key,
    required this.userId,
    this.radius = 50,
  });

  final String userId;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (((snapshot.data!.data() as Map)["profilePhoto"] != null) &&
                ((snapshot.data!.data() as Map)["profilePhoto"] != "")) {
              return CircleAvatar(
                backgroundImage: NetworkImage(
                    (snapshot.data!.data() as Map)["profilePhoto"]),
                radius: radius,
              );
            }

            return Center(
                child: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: radius,
              child: Text(
                (snapshot.data!.data() as Map)["userName"][0]
                    .toString()
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
