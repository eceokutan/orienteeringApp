import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/parkour/parkour_service.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:check_point/pages/parkour/ParkoursPage.dart';
import 'package:check_point/pages/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'dart:developer';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Account"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /*
              if (userInfo.profilePhoto!.isNotEmpty)
                Image.file(
                  userInfo.profilePhoto!.file!,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  height: 200,
                )
              else
                InkWell(
                  onTap: () {
                    ParkourViewModel()
                        .pickParkourImages()
                        .then((value) => setState(() {}));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    alignment: Alignment.center,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Add Image +", style: TextStyle()),
                  ),
                ),
                */
            ],
          )),
    );
  }
}
