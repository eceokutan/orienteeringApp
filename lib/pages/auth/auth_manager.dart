import 'package:check_point/pages/auth/LogInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthManager {
  AuthManager._private();

  static final AuthManager _instance = AuthManager._private();

  factory AuthManager() {
    return _instance;
  }

  signout(BuildContext context) {
    FirebaseAuth.instance.signOut().then(
        (value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const LogInPage();
              },
            ), (route) => false));
  }
}
