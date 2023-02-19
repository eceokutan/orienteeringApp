import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://blog.logrocket.com/implementing-firebase-authentication-in-a-flutter-app/
class AuthService {
  static void signUp({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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

  static bool rememberMe = false;
  static void setRememberMe(bool rememberme) {
    rememberMe = rememberme;
  }

  static void logIn({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      /*
      if (rememberMe) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", email);
        pref.setString("password", password);
        //pref.setBool("rememberMe", true);
        successfulLogin = true;
        print(successfulLogin);
      }
      */
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
  }
}
