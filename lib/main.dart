import 'dart:developer';

import 'package:check_point/pages/auth/LogInPage.dart';
import 'package:check_point/pages/auth/SignUpPage.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

//test
//test2

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //il logged in?
  sharedPrefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await ParkourViewModel().getParkours();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        //home: const HomePage());
        //home: const ParkoursPage());
        home: FirebaseAuth.instance.currentUser == null
            ? const FirstPage()
            : const HomePage());
    //home: const LogInPage());
  }
}

var sharedPrefs;

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool authenticated = false;

  @override
  void initState() {
    super.initState();

    // if (FirebaseAuth.instance.currentUser != null) {
    //   if (sharedPrefs.getBool("rememberMe") ?? false) {
    //     Future.delayed(Duration.zero, () {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const HomePage()));
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/compass.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "CheckPoint",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 48,
                color: Colors.black.withOpacity(1.0),
                height: 1.5,
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Log In'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const LogInPage();
                      },
                    ), (route) => false);
                  },
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignUpPage();
                      },
                    ), (route) => false);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
