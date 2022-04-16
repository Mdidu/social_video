import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_video/widgets/InputItem.dart';
import 'package:social_video/widgets/LoginButton.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SizedBox(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            InputItem(
              controllerField: emailField,
              hintText: 'Email',
            ),
            const SizedBox(
              height: 35,
            ),
            InputItem(
              controllerField: passwordField,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 35,
            ),
            loginButton(
              onPressedFunction: () => login(),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    try {
      auth.signInWithEmailAndPassword(
        email: emailField.text.trim(),
        password: passwordField.text.trim(),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
