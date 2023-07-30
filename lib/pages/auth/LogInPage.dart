import 'package:check_point/pages/_shared/error_dialog.dart';
import 'package:check_point/pages/async_button.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'SignUpPage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const RememberMeButton(),
              TextButton(
                onPressed: () {
                  try {
                    AuthService.forgotPassword(nameController.text);
                  } catch (exception) {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return Text(
                              "Please enter your mail adress into the given space.");
                        }));
                  }
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: AsyncButton(
                    child: const Text('Log In'),
                    onPressed: () async {
                      // nameController.text = "admin@gmail.com";
                      // passwordController.text = "admin12345";

                      try {
                        await AuthService()
                            .logIn(
                              email: nameController.text,
                              password: passwordController.text,
                            )
                            .then((value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false));
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ErrorDialog(e: e);
                          },
                        );
                      }
                    },
                  )),
              Row(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  const Text('Don\'t have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return const SignUpPage();
                        },
                      ), (route) => false);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}

class RememberMeButton extends StatefulWidget {
  const RememberMeButton({
    Key? key,
  }) : super(key: key);

  @override
  State<RememberMeButton> createState() => _RememberMeButtonState();
}

class _RememberMeButtonState extends State<RememberMeButton> {
  bool _savePassword = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _savePassword = value.getBool("rememberMe") ?? false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _savePassword,
      onChanged: (bool? newValue) {
        setState(() {
          _savePassword = newValue!;
        });

        if (_savePassword == true) {
          AuthService.setRememberMe(true);
        } else if (_savePassword == false) {
          AuthService.setRememberMe(false);
        }
      },
      title: const Text("Remember me"),
    );
  }
}
