import 'dart:developer';

import 'package:check_point/models/user_model.dart';
import 'package:check_point/pages/_shared/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'LogInPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'CheckPoint',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: mailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-Mail',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () async {
                      try {
                        UserModel().email = mailController.text;
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(e: e as Exception);
                          },
                        );

                        return;
                      }

                      try {
                        await AuthService()
                            .signUp(
                                email: mailController.text,
                                password: passwordController.text)
                            .then((userCredantial) async {
                          UserModel user = UserModel();

                          user.id = userCredantial.user!.uid;
                          user.userName = userNameController.text;

                          user.email = userCredantial.user!.email!;

                          log(user.email.toString());

                          await AuthService().addUser(user).then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogInPage()),
                                  (route) => false));
                        });
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(e: e);
                          },
                        );
                        // if (e.code == 'weak-password') {

                        //   print('The password provided is too weak.');
                        // } else if (e.code == 'email-already-in-use') {
                        //   print('The account already exists for that email.');
                        // }
                      } catch (e) {
                        print(e);
                      }

                      //FirebaseFirestore firestore = FirebaseFirestore.instance;
                      print(mailController.text);
                      print(passwordController.text);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Have an account?'),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return const LogInPage();
                        },
                      ), (route) => false);
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
