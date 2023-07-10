import 'dart:developer';

import 'package:check_point/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://blog.logrocket.com/implementing-firebase-authentication-in-a-flutter-app/
class AuthService {
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> addUser(UserModel user) async {
    await FirebaseFirestore.instance.collection("users").doc(user.id).set(
          user.toMap(),
        );
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    return snapshot.data();
  }

  static bool successfullyLoggedIn() {
    bool toReturn = false;
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        toReturn = false;
      } else {
        toReturn = true;
      }
    });
    return toReturn;
  }

  static void setRememberMe(bool rememberme) async {
    var sharedPrefs = await SharedPreferences.getInstance();

    await sharedPrefs.setBool("rememberMe", rememberme);
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    var result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    
  }
}
